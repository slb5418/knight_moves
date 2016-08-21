class Knight

	def initialize(source, destination)
		@source = Node.new(source[0], source[1])
		@destination = destination
	end

	def find_moves(node)
		x, y = node.x, node.y
		return if [x,y] == @destination 
		potential_moves = [[x+2, y+1], [x+2, y-1], [x+1, y+2], [x+1, y-2],
							[x-2, y+1], [x-2, y-1], [x-1, y+2], [x-1, y-2]]
		valid_moves = potential_moves.select{|item| item if \
					item[0]>0 && item[0]<7 && item[1]>0 && item[1]<7}
		return valid_moves
	end

	def make_children(node, moves)
		moves.each{|arr| node.children << Node.new(arr[0], arr[1], parent = node)}
	end

	def bfs()
		queue = [@source]
		until queue == []
			node = queue.shift
			return path(node) if [node.x, node.y] == @destination
			make_children(node, find_moves(node))
			node.children.each{|node| queue.push(node)}
		end
		return nil
	end

	#don't do this
	# def dfs(node = @source)
	# 	return path(node) if [node.x, node.y] == @destination
	# 	make_children(node, find_moves(node))
	# 	node.children.each{|node| dfs(node)}
	# end

	def path(node)
		path = [node]
		until node.parent.nil?
			path << node.parent
			node = node.parent
		end
		return path.reverse.map{|node| [node.x, node.y]}
	end

	class Node
		attr_accessor :x, :y, :parent, :children
		def initialize(x, y, parent = nil, children = [])
			@x = x
			@y = y
			@parent = parent
			@children = children
		end
	end
end

def knight_moves(source, dest)
	knight = Knight.new(source, dest)
	path = knight.bfs
	puts "Reached destination in #{path.size-1} moves!"
	path.each{|item| p item}
end

knight_moves([3,3], [1,1])