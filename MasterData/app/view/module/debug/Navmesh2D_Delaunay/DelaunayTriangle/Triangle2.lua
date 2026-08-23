local Edge2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Edge2")
local Vector2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Vector2")
local Triangle2 = class("Triangle2")

function Triangle2:ctor(arg_1_1, arg_1_2, arg_1_3)
	self.a = arg_1_1
	self.b = arg_1_2
	self.c = arg_1_3
	self.invalid = false
	self.am2 = self.a:magnitude2()
	self.bm2 = self.b:magnitude2()
	self.cm2 = self.c:magnitude2()
	self.e1 = Edge2.new(self.a, self.b)
	self.e2 = Edge2.new(self.b, self.c)
	self.e3 = Edge2.new(self.c, self.a)
	self._trianglePos = nil
	self._circlePos = nil
end

function Triangle2:Equal(arg_2_1)
	return self:Contains(arg_2_1.a) and self:Contains(arg_2_1.b) and self:Contains(arg_2_1.c)
end

function Triangle2:Contains(arg_3_1)
	return self.a:Equal(arg_3_1) or self.b:Equal(arg_3_1) or self.c:Equal(arg_3_1)
end

function Triangle2:CircleContains(arg_4_1)
	self._circlePos = self._circlePos or Vector2.new((self.am2 * (self.c.y - self.b.y) + self.bm2 * (self.a.y - self.c.y) + self.cm2 * (self.b.y - self.a.y)) / (self.a.x * (self.c.y - self.b.y) + self.b.x * (self.a.y - self.c.y) + self.c.x * (self.b.y - self.a.y)) * 0.5, (self.am2 * (self.c.x - self.b.x) + self.bm2 * (self.a.x - self.c.x) + self.cm2 * (self.b.x - self.a.x)) / (self.a.y * (self.c.x - self.b.x) + self.b.y * (self.a.x - self.c.x) + self.c.y * (self.b.x - self.a.x)) * 0.5)

	return Vector2.distance(arg_4_1, self._circlePos) <= Vector2.distance(self.a, self._circlePos)
end

function Triangle2:isIn(arg_5_1)
	local var_5_0 = (self.c.x - self.b.x) * (arg_5_1.y - self.b.y) - (self.c.y - self.b.y) * (arg_5_1.x - self.b.x)

	if ((self.b.x - self.a.x) * (arg_5_1.y - self.a.y) - (self.b.y - self.a.y) * (arg_5_1.x - self.a.x)) * ((self.c.x - self.b.x) * (arg_5_1.y - self.b.y) - (self.c.y - self.b.y) * (arg_5_1.x - self.b.x)) < 0 then
		return false
	end

	return var_5_0 * ((self.a.x - self.c.x) * (arg_5_1.y - self.c.y) - (self.a.y - self.c.y) * (arg_5_1.x - self.c.x)) >= 0
end

function Triangle2:getTrianglePoint()
	if not self._trianglePos then
		local var_6_0 = math.max(self.a.x, self.b.x, self.c.x)
		local var_6_1 = math.min(self.a.x, self.b.x, self.c.x)
		local var_6_2 = math.max(self.a.y, self.b.y, self.c.y)
		local var_6_3 = math.min(self.a.y, self.b.y, self.c.y)

		self._trianglePos = math.sqrt(math.max(self.am2, self.bm2, self.cm2)) > 2 * math.min(var_6_0 - var_6_1, var_6_2 - var_6_3) and Vector2.new((var_6_0 + var_6_1) * 0.5, (var_6_2 + var_6_3) * 0.5) or Vector2.new((self.a.x + self.b.x + self.c.x) / 3, (self.a.y + self.b.y + self.c.y) / 3)
	end

	return self._trianglePos
end

return Triangle2
