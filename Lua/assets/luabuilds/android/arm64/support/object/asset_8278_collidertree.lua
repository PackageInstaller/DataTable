pg = pg or {}

local var_0_0 = math.max
local var_0_1 = math.min
local var_0_2 = pg
local var_0_4 = table

pg.CldArea = class("CldArea")

function pg.CldArea.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.min = arg_1_1
	arg_1_0.max = arg_1_2
	arg_1_0.center = (arg_1_1 + arg_1_2):Mul(0.5)
	arg_1_0.father = arg_1_3
	arg_1_0.level = arg_1_3 and arg_1_3.level + 1 or 1
	arg_1_0.isLeaf = true
	arg_1_0.childs = {}
	arg_1_0.nodes = {}

	return
end

function pg.CldArea:AddNode(arg_2_1)
	var_0_4.insert(self.nodes, arg_2_1)

	arg_2_1.area = self

	return
end

function pg.CldArea:InArea(arg_3_1, arg_3_2)
	if arg_3_1.x < self.min.x or arg_3_1.y < self.min.y then
		return false
	end

	if arg_3_2.x > self.max.x or arg_3_2.y > self.max.y then
		return false
	end

	return true
end

function pg.CldArea:GetAreaIndex(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.x >= self.center.x and 0 or 2
	local var_4_1 = arg_4_2.x >= self.center.x and 0 or 2

	if (arg_4_1.x >= self.center.x and 0 or 2) ~= (arg_4_2.x >= self.center.x and 0 or 2) then
		return 0
	end

	return var_4_0 + (arg_4_1.z >= self.center.z and 1 or 2) == var_4_1 + (arg_4_2.z >= self.center.z and 1 or 2) and var_4_0 + (arg_4_1.z >= self.center.z and 1 or 2) or 0
end

local ColliderTree = class("ColliderTree")

pg.ColliderTree = ColliderTree
ColliderTree.MaxLayer = 3

local var_0_6 = 6

function ColliderTree:Ctor(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.name = arg_5_1
	self.root = var_0_2.CldArea.New(arg_5_2, arg_5_3, nil)
	self.MaxLayer = arg_5_4
	self.cldStack = {}

	return
end

function ColliderTree:Insert(arg_6_1)
	if arg_6_1.area then
		var_0_4.removebyvalue(arg_6_1.area.nodes, arg_6_1)
	end

	self:_insert(arg_6_1, self:_findParent(arg_6_1, self.root))

	return
end

function ColliderTree:_findParent(arg_7_1, arg_7_2)
	while not arg_7_2.isLeaf do
		local var_7_1 = arg_7_2:GetAreaIndex(arg_7_1.min, arg_7_1.max)

		if var_7_1 < 1 then
			break
		end

		arg_7_2 = arg_7_2.childs[var_7_1]
	end

	return arg_7_2
end

function ColliderTree:_insert(arg_8_1, arg_8_2)
	if not arg_8_2.isLeaf or #arg_8_2.nodes < var_0_6 or arg_8_2.level >= self.MaxLayer then
		arg_8_2:AddNode(arg_8_1)

		return
	end

	arg_8_2.isLeaf = false
	arg_8_2.childs[1] = var_0_2.CldArea.New(arg_8_2.center, arg_8_2.max, arg_8_2)
	arg_8_2.childs[2] = var_0_2.CldArea.New(Vector3(arg_8_2.center.x, 0, arg_8_2.min.z), Vector3(arg_8_2.max.x, 0, arg_8_2.center.z), arg_8_2)
	arg_8_2.childs[3] = var_0_2.CldArea.New(Vector3(arg_8_2.min.x, 0, arg_8_2.center.z), Vector3(arg_8_2.center.x, 0, arg_8_2.max.z), arg_8_2)
	arg_8_2.childs[4] = var_0_2.CldArea.New(arg_8_2.min, arg_8_2.center, arg_8_2)

	for iter_8_0 = #arg_8_2.nodes, 1, -1 do
		local var_8_1 = arg_8_2:GetAreaIndex(arg_8_2.nodes[iter_8_0].min, arg_8_2.nodes[iter_8_0].max)

		if var_8_1 > 0 then
			arg_8_2.childs[var_8_1]:AddNode(arg_8_2.nodes[iter_8_0])
			var_0_4.remove(arg_8_2.nodes, iter_8_0)
		end
	end

	local var_8_2 = arg_8_2:GetAreaIndex(arg_8_1.min, arg_8_1.max)

	if var_8_2 > 0 then
		arg_8_2.childs[var_8_2]:AddNode(arg_8_1)
	else
		arg_8_2:AddNode(arg_8_1)
	end

	return
end

function ColliderTree:Update(arg_9_1)
	local var_9_0 = arg_9_1.area

	if arg_9_1.area == nil then
		return
	end

	local var_9_1 = arg_9_1.min

	while var_9_0.father do
		if var_9_0:InArea(var_9_1, arg_9_1.max) then
			break
		end

		var_9_0 = var_9_0.father
	end

	local var_9_2 = self:_findParent(arg_9_1, var_9_0)

	if var_9_2 ~= arg_9_1.area then
		var_0_4.removebyvalue(arg_9_1.area.nodes, arg_9_1)
		self:_insert(arg_9_1, var_9_2)
	end

	return
end

function ColliderTree:Remove(arg_10_1)
	if not arg_10_1.area then
		return
	end

	var_0_4.removebyvalue(arg_10_1.area.nodes, arg_10_1)

	arg_10_1.area = nil

	return
end

function ColliderTree:Intersect(arg_11_1, arg_11_2, arg_11_3)
	return self.x <= arg_11_3.x and arg_11_1.x >= arg_11_2.x and self.z <= arg_11_3.z and arg_11_1.z >= arg_11_2.z
end

function ColliderTree:CylinderCheck(arg_12_1)
	if not self.cylinder and not arg_12_1.cylinder then
		return true
	end

	local var_12_3
	local var_12_4

	if self.cylinder and arg_12_1.cylinder then
		local var_12_0 = self.center.x - arg_12_1.center.x
		local var_12_1 = self.center.z - arg_12_1.center.z
		local var_12_2 = self.range + arg_12_1.range

		do return var_12_0 * var_12_0 + var_12_1 * var_12_1 <= var_12_2 * var_12_2 end

		var_12_3 = (self.cylinder and self or arg_12_1).range
		var_12_4 = (self.cylinder and self or arg_12_1).center.x
	end

	local var_12_5 = (self.cylinder and self or arg_12_1).center.z
	local var_12_6 = self.cylinder and arg_12_1 or self

	if var_12_4 >= (self.cylinder and arg_12_1 or self).min.x and var_12_4 <= var_12_6.max.x then
		return var_12_5 >= var_12_6.min.z - var_12_3 and var_12_5 <= var_12_6.max.z + var_12_3
	elseif var_12_5 >= var_12_6.min.z and var_12_5 <= var_12_6.max.z then
		return var_12_4 >= var_12_6.min.x - var_12_3 and var_12_4 <= var_12_6.max.x + var_12_3
	else
		local var_12_7
		local var_12_8

		var_12_7 = var_12_4 < var_12_6.min.x and var_12_6.min.x - var_12_4 or var_12_6.max.x - var_12_4
		var_12_8 = var_12_5 < var_12_6.min.z and var_12_6.min.z - var_12_5 or var_12_6.max.z - var_12_5

		return var_12_7 * var_12_7 + var_12_8 * var_12_8 < var_12_3 * var_12_3
	end

	return
end

function ColliderTree:getTime(arg_13_1, arg_13_2)
	local var_13_0 = 0

	if arg_13_2.x ~= 0 then
		var_13_0 = var_0_0(0, (var_0_0(self.min.x, arg_13_1.min.x) - var_0_1(self.max.x, arg_13_1.max.x)) / arg_13_2.x)
	end

	if arg_13_2.z ~= 0 then
		var_13_0 = var_0_0(var_13_0, (var_0_0(self.min.z, arg_13_1.min.z) - var_0_1(self.max.z, arg_13_1.max.z)) / arg_13_2.z)
	end

	return var_13_0
end

function ColliderTree:GetCldList(arg_14_1, arg_14_2)
	local var_14_1 = self.root
	local var_14_2 = {}

	while not var_14_1.isLeaf do
		local var_14_3 = var_14_1:GetAreaIndex(arg_14_1.min, arg_14_1.max)

		if var_14_3 < 1 then
			break
		end

		for iter_14_0, iter_14_1 in ipairs(var_14_1.nodes) do
			if ColliderTree.Intersect(iter_14_1.min, iter_14_1.max, arg_14_1.min, arg_14_1.max) and ColliderTree.CylinderCheck(arg_14_1, iter_14_1) then
				var_0_4.insert(var_14_2, iter_14_1)
			end
		end

		var_14_1 = var_14_1.childs[var_14_3]
	end

	local var_14_4 = self.cldStack

	var_0_4.insert(self.cldStack, var_14_1)

	while #var_14_4 > 0 do
		local var_14_5 = var_0_4.remove(var_14_4)

		for iter_14_2, iter_14_3 in ipairs(var_14_5.nodes) do
			if ColliderTree.Intersect(iter_14_3.min, iter_14_3.max, arg_14_1.min, arg_14_1.max) and ColliderTree.CylinderCheck(arg_14_1, iter_14_3) then
				var_0_4.insert(var_14_2, iter_14_3)
			end
		end

		for iter_14_4, iter_14_5 in pairs(var_14_5.childs) do
			if iter_14_5 ~= null and ColliderTree.Intersect(iter_14_5.min, iter_14_5.max, arg_14_1.min, arg_14_1.max) then
				var_0_4.insert(var_14_4, iter_14_5)
			end
		end
	end

	return var_14_2
end

function ColliderTree:GetCldListGradient(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = Vector3(math.cos(arg_15_1), 0, math.sin(arg_15_1))
	local var_15_1 = Vector3.Cross(var_15_0, Vector3.up)
	local var_15_2 = {
		1,
		2,
		3,
		4,
		[1] = arg_15_4 + var_15_1 * (arg_15_2 * -0.5),
		[2] = arg_15_4 + var_15_1 * (arg_15_2 * 0.5)
	}

	var_15_2[3] = var_15_2[2] + var_15_0 * arg_15_3
	var_15_2[4] = var_15_2[1] + var_15_0 * arg_15_3

	local var_15_3 = var_0_2.CldNode.New()

	var_15_3:UpdateStaticBox(Vector3(var_0_1(var_15_2[1].x, var_15_2[2].x, var_15_2[3].x, var_15_2[4].x), 0, var_0_1(var_15_2[1].z, var_15_2[2].z, var_15_2[3].z, var_15_2[4].z)), (Vector3(var_0_0(var_15_2[1].x, var_15_2[2].x, var_15_2[3].x, var_15_2[4].x), 0, var_0_0(var_15_2[1].z, var_15_2[2].z, var_15_2[3].z, var_15_2[4].z))))

	local var_15_4 = self:GetCldList(var_15_3, nil)

	if var_15_0.x * var_15_0.z == 0 then
		return var_15_4
	end

	local var_15_5
	local var_15_6
	local var_15_7
	local var_15_8

	for iter_15_0 = #var_15_4, 1, -1 do
		if var_15_0.x * var_15_0.z > 0 then
			var_15_5 = var_15_4[iter_15_0].min
			var_15_6 = var_15_4[iter_15_0].max
			var_15_7 = Vector3(var_15_4[iter_15_0].min.x, 0, var_15_4[iter_15_0].max.z)
			var_15_8 = Vector3(var_15_4[iter_15_0].max.x, 0, var_15_4[iter_15_0].min.z)
		else
			var_15_7 = var_15_4[iter_15_0].min
			var_15_8 = var_15_4[iter_15_0].max
			var_15_5 = Vector3(var_15_4[iter_15_0].min.x, 0, var_15_4[iter_15_0].max.z)
			var_15_6 = Vector3(var_15_4[iter_15_0].max.x, 0, var_15_4[iter_15_0].min.z)
		end

		repeat
			local var_15_9 = Vector3.Dot(var_15_0, var_15_5 - var_15_2[1])
			local var_15_10 = Vector3.Dot(var_15_0, var_15_6 - var_15_2[1])

			if var_15_9 < 0 and var_15_10 < 0 or arg_15_3 < var_15_9 and arg_15_3 < var_15_10 then
				var_0_4.remove(var_15_4, iter_15_0)

				break
			end

			local var_15_11 = Vector3.Dot(var_15_1, var_15_7 - var_15_2[1])
			local var_15_12 = Vector3.Dot(var_15_1, var_15_8 - var_15_2[1])

			if var_15_11 < 0 and var_15_12 < 0 or arg_15_2 < var_15_11 and arg_15_2 < var_15_12 then
				var_0_4.remove(var_15_4, iter_15_0)
			end

			break
		until true
	end

	return var_15_4
end

function ColliderTree:GetCldListEllipse(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = var_0_2.CldNode.New()

	var_16_0:UpdateStaticBox(Vector3(arg_16_3.x - arg_16_1, 0, arg_16_3.z - arg_16_2), Vector3(arg_16_3.x + arg_16_1, 0, arg_16_3.z + arg_16_2))

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs((self:GetCldList(var_16_0, nil))) do
		if ellipseIntersectsRect(arg_16_3.x, arg_16_3.z, arg_16_1, arg_16_2, iter_16_1.min, iter_16_1.max) then
			var_0_4.insert(var_16_1, iter_16_1)
		end
	end

	return var_16_1
end

function ColliderTree:pointInEllipse(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = arg_17_1 - arg_17_3

	return (self - arg_17_2) * (self - arg_17_2) / (arg_17_4 * arg_17_4) + var_17_0 * var_17_0 / (arg_17_5 * arg_17_5) <= 1
end

function ColliderTree:lineIntersectsEllipse(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	arg_18_1 = arg_18_1 - arg_18_5
	self = self - arg_18_4
	arg_18_3 = arg_18_3 - arg_18_5
	arg_18_2 = arg_18_2 - arg_18_4

	local var_18_0 = (arg_18_2 - self) * (arg_18_2 - self) / (arg_18_6 * arg_18_6) + (arg_18_3 - arg_18_1) * (arg_18_3 - arg_18_1) / (arg_18_7 * arg_18_7)
	local var_18_1 = 2 * (self * (arg_18_2 - self) / (arg_18_6 * arg_18_6) + arg_18_1 * (arg_18_3 - arg_18_1) / (arg_18_7 * arg_18_7))

	if var_18_1 * var_18_1 - 4 * ((arg_18_2 - self) * (arg_18_2 - self) / (arg_18_6 * arg_18_6) + (arg_18_3 - arg_18_1) * (arg_18_3 - arg_18_1) / (arg_18_7 * arg_18_7)) * (self * self / (arg_18_6 * arg_18_6) + arg_18_1 * arg_18_1 / (arg_18_7 * arg_18_7) - 1) < 0 then
		return false
	end

	local var_18_2 = math.sqrt(var_18_1 * var_18_1 - 4 * ((arg_18_2 - self) * (arg_18_2 - self) / (arg_18_6 * arg_18_6) + (arg_18_3 - arg_18_1) * (arg_18_3 - arg_18_1) / (arg_18_7 * arg_18_7)) * (self * self / (arg_18_6 * arg_18_6) + arg_18_1 * arg_18_1 / (arg_18_7 * arg_18_7) - 1))
	local var_18_3 = (-var_18_1 + var_18_2) / (2 * var_18_0)

	return (-var_18_1 - var_18_2) / (2 * var_18_0) >= 0 and (-var_18_1 - var_18_2) / (2 * var_18_0) <= 1 or var_18_3 >= 0 and var_18_3 <= 1
end

function ColliderTree:ellipseIntersectsRect(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if self - arg_19_2 > arg_19_5.x or self + arg_19_2 < arg_19_4.x or arg_19_1 - arg_19_3 > arg_19_5.z or arg_19_1 + arg_19_3 < arg_19_4.z then
		return false
	end

	local var_19_0 = {
		{
			arg_19_4.x,
			arg_19_4.z
		},
		{
			arg_19_5.x,
			arg_19_4.z
		},
		{
			arg_19_5.x,
			arg_19_5.z
		},
		{
			arg_19_4.x,
			arg_19_5.z
		}
	}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if ColliderTree.pointInEllipse(iter_19_1[1], iter_19_1[2], self, arg_19_1, arg_19_2, arg_19_3) then
			return true
		end
	end

	if self >= arg_19_4.x and self <= arg_19_5.x and arg_19_1 >= arg_19_4.z and arg_19_1 <= arg_19_5.z then
		return true
	end

	for iter_19_2 = 1, 4 do
		if ColliderTree.lineIntersectsEllipse(var_19_0[iter_19_2][1], var_19_0[iter_19_2][2], var_19_0[iter_19_2 % 4 + 1][1], var_19_0[iter_19_2 % 4 + 1][2], self, arg_19_1, arg_19_2, arg_19_3) then
			return true
		end
	end

	return false
end

return
