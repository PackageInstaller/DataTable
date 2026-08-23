local MeshNode = class("MeshNode")
local var_0_1 = 0

function MeshNode.nextOid()
	var_0_1 = var_0_1 + 1

	return var_0_1
end

function MeshNode:ctor(arg_2_1)
	self.oid = MeshNode.nextOid()
	self.triangle = arg_2_1
	self._isObstacle = false
	self._lineColor = cc.c4f(0, 0, 0, 1)
	self._fillColor = cc.c4f(1, 1, 1, 0.3)
	self.g = 0
	self.h = 0
	self.g = self.g + self.h
	self.parent = nil
	self.parentEdge = nil
	self._neighbors = {}
end

function MeshNode:isInNode(arg_3_1)
	return self.triangle:isIn(arg_3_1)
end

function MeshNode:setObstacle(arg_4_1)
	self._isObstacle = arg_4_1
	self._fillColor = arg_4_1 and cc.c4f(0.7, 0.7, 0.7, 1) or cc.c4f(1, 1, 1, 0.3)
end

function MeshNode:isObstacle()
	return self._isObstacle
end

function MeshNode:setStart(arg_6_1)
	self._fillColor = self:isObstacle() and cc.c4f(0.7, 0.7, 0.7, 1) or arg_6_1 and cc.c4f(1, 0, 0, 1) or cc.c4f(1, 1, 1, 1)
end

function MeshNode:setEnd(arg_7_1)
	self._fillColor = self:isObstacle() and cc.c4f(0.7, 0.7, 0.7, 1) or arg_7_1 and cc.c4f(0, 1, 0, 1) or cc.c4f(1, 1, 1, 1)
end

function MeshNode:setPath(arg_8_1)
	self._fillColor = self:isObstacle() and cc.c4f(0.7, 0.7, 0.7, 1) or arg_8_1 and cc.c4f(0, 0, 1, 1) or cc.c4f(1, 1, 1, 1)
end

function MeshNode:drawPolygonWithGraph(arg_9_1)
	arg_9_1:drawPolygon(1, self._lineColor, self._fillColor, {
		cc.p(self.triangle.a.x, self.triangle.a.y),
		cc.p(self.triangle.b.x, self.triangle.b.y),
		cc.p(self.triangle.c.x, self.triangle.c.y)
	}, 3)
end

function MeshNode:setNeighbor(arg_10_1, arg_10_2)
	self._neighbors[arg_10_1] = arg_10_2
end

function MeshNode:getNeighbor()
	return self._neighbors
end

function MeshNode:getDistance(arg_12_1)
	return math.sqrt((self.triangle.a.x - arg_12_1.triangle.a.x) * (self.triangle.a.x - arg_12_1.triangle.a.x) + (self.triangle.a.y - arg_12_1.triangle.a.y) * (self.triangle.a.y - arg_12_1.triangle.a.y))
end

return MeshNode
