local Numeric = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Numeric")
local Vector2 = class("Vector2")

function Vector2:ctor(arg_1_1, arg_1_2)
	self.x = math.floor(arg_1_1 * 10 + 0.5) / 10
	self.y = math.floor(arg_1_2 * 10 + 0.5) / 10
end

function Vector2:toS()
	return self.x .. "," .. self.y
end

function Vector2:magnitude()
	return math.sqrt(self:magnitude2())
end

function Vector2:magnitude2()
	return self.x * self.x + self.y * self.y
end

function Vector2:distance(arg_5_1)
	return math.sqrt(Vector2.distance2(self, arg_5_1))
end

function Vector2:distance2(arg_6_1)
	return (self.x - arg_6_1.x) * (self.x - arg_6_1.x) + (self.y - arg_6_1.y) * (self.y - arg_6_1.y)
end

function Vector2:Equal(arg_7_1)
	return Numeric.Equal(self.x, arg_7_1.x) and Numeric.Equal(self.y, arg_7_1.y)
end

return Vector2
