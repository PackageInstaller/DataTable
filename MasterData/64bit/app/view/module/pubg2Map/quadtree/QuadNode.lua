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
	self.renderAfter = {}
end

function QuadNode:release()
	self.entities = {}

	if self.children then
		for iter_2_0, iter_2_1 in ipairs(self.children) do
			iter_2_1:release()
		end
	end

	self.children = nil
end

return QuadNode
