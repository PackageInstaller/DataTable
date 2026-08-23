local Triangle2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Triangle2")
local Vector2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Vector2")
local Delaunay = class("Delaunay")

function Delaunay:ctor(arg_1_1)
	self._isDebug = arg_1_1
	self.triangulateList = {}
	self.debugLines = {}
end

function Delaunay:setDebug(arg_2_1)
	self._isDebug = arg_2_1
end

function Delaunay:generalTriangulate(arg_3_1)
	self.triangulateList = {}
	self.debugLines = {}

	if not arg_3_1 or #arg_3_1 < 3 then
		return
	end

	local var_3_0 = arg_3_1[1].x
	local var_3_1 = arg_3_1[1].y
	local var_3_2 = arg_3_1[1].x
	local var_3_3 = arg_3_1[1].y

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_3_0 = math.min(var_3_0, iter_3_1.x)
		var_3_1 = math.min(var_3_1, iter_3_1.y)
		var_3_2 = math.max(var_3_2, iter_3_1.x)
		var_3_3 = math.max(var_3_3, iter_3_1.y)
	end

	local var_3_4 = math.max(var_3_2 - var_3_0, var_3_3 - var_3_1)
	local var_3_5 = Vector2.new((var_3_0 + var_3_2) * 0.5 - 2 * var_3_4, (var_3_1 + var_3_3) * 0.5 - var_3_4)
	local var_3_6 = Vector2.new((var_3_0 + var_3_2) * 0.5, (var_3_1 + var_3_3) * 0.5 + 2 * var_3_4)
	local var_3_7 = Vector2.new((var_3_0 + var_3_2) * 0.5 + 2 * var_3_4, (var_3_1 + var_3_3) * 0.5 - var_3_4)

	self:addTriangulate(var_3_5, var_3_6, var_3_7)

	for iter_3_2, iter_3_3 in ipairs(arg_3_1) do
		local var_3_8 = {}

		for iter_3_4, iter_3_5 in ipairs(self.triangulateList) do
			if iter_3_5:CircleContains(iter_3_3) then
				iter_3_5.invalid = true

				table.insert(var_3_8, iter_3_5.e1)
				table.insert(var_3_8, iter_3_5.e2)
				table.insert(var_3_8, iter_3_5.e3)
			end
		end

		Delaunay.RemoveAll(self.triangulateList, function(arg_4_0)
			return arg_4_0.invalid
		end)

		for iter_3_6 = 1, #var_3_8 do
			for iter_3_7 = iter_3_6 + 1, #var_3_8 do
				if var_3_8[iter_3_6]:Equal(var_3_8[iter_3_7]) then
					var_3_8[iter_3_6].invalid = true
					var_3_8[iter_3_7].invalid = true
				end
			end
		end

		Delaunay.RemoveAll(var_3_8, function(arg_5_0)
			return arg_5_0.invalid
		end)

		for iter_3_8, iter_3_9 in ipairs(var_3_8) do
			self:addTriangulate(iter_3_9.u, iter_3_9.w, iter_3_3)
		end
	end

	Delaunay.RemoveAll(self.triangulateList, function(arg_6_0)
		return arg_6_0:Contains(var_3_5) or arg_6_0:Contains(var_3_6) or arg_6_0:Contains(var_3_7)
	end)

	if self._isDebug then
		table.insert(self.debugLines, self:getAllLines())
	end
end

function Delaunay:addTriangulate(arg_7_1, arg_7_2, arg_7_3)
	table.insert(self.triangulateList, Triangle2.new(arg_7_1, arg_7_2, arg_7_3))

	if self._isDebug then
		table.insert(self.debugLines, self:getAllLines())
	end
end

function Delaunay:getDebugAllLines()
	return self.debugLines
end

function Delaunay:getAllLines()
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(self.triangulateList) do
		local var_9_2 = iter_9_1.e1:getKey()

		if not var_9_1[var_9_2] then
			table.insert(var_9_0, iter_9_1.e1)

			var_9_1[var_9_2] = true
		end

		local var_9_3 = iter_9_1.e2
		local var_9_4 = iter_9_1.e2:getKey()

		if not var_9_1[var_9_4] then
			table.insert(var_9_0, var_9_3)

			var_9_1[var_9_4] = true
		end

		local var_9_5 = iter_9_1.e3
		local var_9_6 = iter_9_1.e3:getKey()

		if not var_9_1[var_9_6] then
			table.insert(var_9_0, var_9_5)

			var_9_1[var_9_6] = true
		end
	end

	return var_9_0
end

function Delaunay:RemoveAll(arg_10_1)
	for iter_10_0 = #self, 1, -1 do
		if arg_10_1(self[iter_10_0]) then
			table.remove(self, iter_10_0)
		end
	end
end

function Delaunay:dump()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self.triangulateList) do
		var_11_0[iter_11_0] = {
			a = cc.p(iter_11_1.a.x, iter_11_1.a.y),
			b = cc.p(iter_11_1.b.x, iter_11_1.b.y),
			c = cc.p(iter_11_1.c.x, iter_11_1.c.y)
		}
	end

	dump(var_11_0)
end

return Delaunay
