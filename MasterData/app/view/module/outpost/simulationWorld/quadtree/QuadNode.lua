local QuadNode = class("QuadNode")

function QuadNode:ctor()
	self.x = 0
	self.y = 0
	self.width = 0
	self.height = 0
	self.capacity = 4
	self.maxDepth = 4
	self.depth = 0
	self.entities = {}
	self.children = nil
	self.root = nil
	self.renderAfter = {}
end

function QuadNode:updateEntity(arg_2_1, arg_2_2, arg_2_3)
	if self.root then
		self.root:update(arg_2_1, arg_2_2, arg_2_3)
	else
		assert(false, "not root ， can not update entity")
	end
end

function QuadNode:removeEntity(arg_3_1)
	if self.root then
		self.root:remove(arg_3_1)
	else
		assert(false, "not root ， can not remove entity")
	end
end

function QuadNode:release()
	self.entities = {}

	if self.children then
		for iter_4_0, iter_4_1 in ipairs(self.children) do
			iter_4_1:release()
		end
	end

	self.children = nil
	self.root = nil
end

return QuadNode
