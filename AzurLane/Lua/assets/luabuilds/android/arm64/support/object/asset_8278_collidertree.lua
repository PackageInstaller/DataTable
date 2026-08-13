pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
math = pg

local var_0_1 = var_0.max

math = var_0_10001

local var_0_2 = var_0_10001.min

pg = var_0_10002

local var_0_3 = var_0_10002.CldNode

table = var_0_10004
class = var_0_10005
var_0_10002.CldArea = var_0_10005("CldArea")

function var_0_10002.CldArea.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.min = arg_1_1
	arg_1_0.max = arg_1_2

	local var_1_0 = arg_1_1 + arg_1_2

	arg_1_0.center = var_4.Mul(var_1_0, 0.5)
	arg_1_0.father = arg_1_3

	if arg_1_3 then
		arg_1_0.level = arg_1_3.level + 1
	else
		arg_1_0.level = 1
	end

	arg_1_0.isLeaf = true
	arg_1_0.childs = {}
	arg_1_0.nodes = {}

	return
end

function var_0_10002.CldArea.AddNode(arg_2_0, arg_2_1)
	var_0_10004.insert(arg_2_0.nodes, arg_2_1)

	arg_2_1.area = arg_2_0

	return
end

function var_0_10002.CldArea.InArea(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1.x < arg_3_0.min.x or arg_3_1.y < arg_3_0.min.y then
		return false
	end

	if arg_3_2.x > arg_3_0.max.x or arg_3_2.y > arg_3_0.max.y then
		return false
	end

	return true
end

local var_0_4 = var_0_10002.CldArea

function var_0_4.GetAreaIndex(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.center

	if (arg_4_1.x >= var_4_0.x and 0 or 2) ~= (arg_4_2.x >= var_4_0.x and 0 or 2) then
		return 0
	end

	return var_4 + (arg_4_1.z >= var_4_0.z and 1 or 2) == var_5 + (arg_4_2.z >= var_4_0.z and 1 or 2) and var_4 or 0
end

class = var_0_4
var_0_10002.ColliderTree = var_0_4("ColliderTree")
var_5.MaxLayer = 3

local var_0_5 = 6

function var_5.Ctor(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.name = arg_5_1
	arg_5_0.root = var_0_10002.CldArea.New(arg_5_2, arg_5_3, nil)
	arg_5_0.MaxLayer = arg_5_4
	arg_5_0.cldStack = {}

	return
end

function var_5.Insert(arg_6_0, arg_6_1)
	if arg_6_1.area then
		var_0_10004.removebyvalue(var_2.nodes, arg_6_1)
	end

	arg_6_0:_insert(arg_6_1, arg_6_0:_findParent(arg_6_1, arg_6_0.root))

	return
end

function var_5._findParent(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.min
	local var_7_1 = arg_7_1.max
	local var_7_2

	while not arg_7_2.isLeaf do
		if arg_7_2:GetAreaIndex(var_7_0, var_7_1) < 1 then
			break
		end

		arg_7_2 = arg_7_2.childs[var_5]
	end

	return arg_7_2
end

function var_5._insert(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if not arg_8_2.isLeaf or #arg_8_2.nodes < var_0_5 or arg_8_2.level >= arg_8_0.MaxLayer then
		arg_8_2:AddNode(arg_8_1)

		return
	end

	arg_8_2.isLeaf = false

	local var_8_1 = arg_8_2.center
	local var_8_2 = arg_8_2.max
	local var_8_3 = arg_8_2.min

	arg_8_2.childs[1] = var_0_10002.CldArea.New(var_8_1, var_8_2, arg_8_2)

	local var_8_4 = arg_8_2.childs
	local var_8_5 = var_0_10002.CldArea.New

	Vector3 = var_10

	local var_8_6 = var_10(var_8_1.x, 0, var_8_3.z)

	Vector3 = var_11
	var_8_4[2] = var_8_5(var_8_6, var_11(var_8_2.x, 0, var_8_1.z), arg_8_2)

	local var_8_7 = arg_8_2.childs
	local var_8_8 = var_0_10002.CldArea.New

	Vector3 = var_8_6

	local var_8_9 = var_8_6(var_8_3.x, 0, var_8_1.z)

	Vector3 = var_11
	var_8_7[3] = var_8_8(var_8_9, var_11(var_8_1.x, 0, var_8_2.z), arg_8_2)
	arg_8_2.childs[4] = var_0_10002.CldArea.New(var_8_3, var_8_1, arg_8_2)

	for iter_8_0 = #arg_8_2.nodes, 1, -1 do
		local var_8_10 = arg_8_2.nodes[iter_8_0]

		if arg_8_2:GetAreaIndex(var_8_10.min, var_8_10.max) > 0 then
			local var_8_11 = arg_8_2.childs[var_3]

			var_12.AddNode(var_8_11, var_8_10)
			var_0_10004.remove(arg_8_2.nodes, iter_8_0)
		end
	end

	if arg_8_2:GetAreaIndex(arg_8_1.min, arg_8_1.max) > 0 then
		local var_8_12 = arg_8_2.childs[var_3]

		var_7.AddNode(var_8_12, arg_8_1)
	else
		arg_8_2:AddNode(arg_8_1)
	end

	return
end

function var_5.Update(arg_9_0, arg_9_1)
	if arg_9_1.area == nil then
		return
	end

	local var_9_0 = arg_9_1.min
	local var_9_1 = arg_9_1.max

	while var_9_2.father do
		if var_9_2:InArea(var_9_0, var_9_1) then
			break
		end

		local var_9_2 = var_9_2.father
	end

	if arg_9_0:_findParent(arg_9_1, var_9_2) ~= arg_9_1.area then
		var_0_10004.removebyvalue(arg_9_1.area.nodes, arg_9_1)
		arg_9_0:_insert(arg_9_1, var_5)
	end

	return
end

function var_5.Remove(arg_10_0, arg_10_1)
	if not arg_10_1.area then
		return
	end

	var_0_10004.removebyvalue(var_2.nodes, arg_10_1)

	arg_10_1.area = nil

	return
end

function var_5.Intersect(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return arg_11_0.x <= arg_11_3.x and arg_11_1.x >= arg_11_2.x and arg_11_0.z <= arg_11_3.z and arg_11_1.z >= arg_11_2.z
end

function var_5.CylinderCheck(arg_12_0, arg_12_1)
	if not arg_12_0.cylinder and not arg_12_1.cylinder then
		return true
	end

	if arg_12_0.cylinder and arg_12_1.cylinder then
		local var_12_0 = arg_12_0.center.x - arg_12_1.center.x
		local var_12_1 = arg_12_0.center.z - arg_12_1.center.z
		local var_12_2 = arg_12_0.range + arg_12_1.range

		return var_12_0 * var_12_0 + var_12_1 * var_12_1 <= var_12_2 * var_12_2
	end

	local var_12_3 = (arg_12_0.cylinder and arg_12_0 or arg_12_1).range
	local var_12_4 = var_2.center.x
	local var_12_5 = var_2.center.z

	if var_12_4 >= (arg_12_0.cylinder and arg_12_1 or arg_12_0).min.x and var_12_4 <= var_6.max.x then
		return var_12_5 >= var_6.min.z - var_12_3 and var_12_5 <= var_6.max.z + var_12_3
	elseif var_12_5 >= var_6.min.z and var_12_5 <= var_6.max.z then
		return var_12_4 >= var_6.min.x - var_12_3 and var_12_4 <= var_6.max.x + var_12_3
	else
		local var_12_6
		local var_12_7

		if var_12_4 < var_6.min.x then
			var_12_6 = var_6.min.x - var_12_4
		else
			var_12_6 = var_6.max.x - var_12_4
		end

		if var_12_5 < var_6.min.z then
			var_12_7 = var_6.min.z - var_12_5
		else
			var_12_7 = var_6.max.z - var_12_5
		end

		return var_12_6 * var_12_6 + var_12_7 * var_12_7 < var_12_3 * var_12_3
	end

	return
end

function var_5.getTime(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = 0

	if arg_13_2.x ~= 0 then
		var_13_0 = var_0_1(0, (var_0_1(arg_13_0.min.x, arg_13_1.min.x) - var_0_2(arg_13_0.max.x, arg_13_1.max.x)) / arg_13_2.x)
	end

	if arg_13_2.z ~= 0 then
		var_13_0 = var_0_1(var_13_0, (var_0_1(arg_13_0.min.z, arg_13_1.min.z) - var_0_2(arg_13_0.max.z, arg_13_1.max.z)) / arg_13_2.z)
	end

	return var_13_0
end

function var_5.GetCldList(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1.min
	local var_14_1 = arg_14_1.max
	local var_14_2
	local var_14_3 = arg_14_0.root
	local var_14_4 = {}

	while not var_14_3.isLeaf do
		if var_14_3:GetAreaIndex(var_14_0, var_14_1) < 1 then
			break
		end

		ipairs = var_8

		for iter_14_0, iter_14_1 in var_8(var_14_3.nodes) do
			if var_0.Intersect(iter_14_1.min, iter_14_1.max, var_14_0, var_14_1) and var_0.CylinderCheck(arg_14_1, iter_14_1) then
				var_0_10004.insert(var_14_4, iter_14_1)
			end
		end

		var_14_3 = var_14_3.childs[var_5]
	end

	local var_14_5 = arg_14_0.cldStack

	var_0_10004.insert(var_14_5, var_14_3)

	::label_14_0::

	local var_14_6 = #var_14_5

	if 0 < var_14_6 then
		repeat
			local var_14_7 = var_0_10004.remove(var_14_5)

			ipairs = var_10

			for iter_14_2, iter_14_3 in var_10(var_14_7.nodes) do
				if var_0.Intersect(iter_14_3.min, iter_14_3.max, var_14_0, var_14_1) and var_0.CylinderCheck(arg_14_1, iter_14_3) then
					var_0_10004.insert(var_14_4, iter_14_3)
				end
			end

			pairs = var_10

			for iter_14_4, iter_14_5 in var_10(var_14_7.childs) do
				null = var_1_10015

				if iter_14_5 ~= var_1_10015 and var_0.Intersect(iter_14_5.min, iter_14_5.max, var_14_0, var_14_1) then
					var_0_10004.insert(var_14_5, iter_14_5)
				end
			end

			goto label_14_0
		until true
	end

	return var_14_4
end

function var_5.GetCldListGradient(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	Vector3 = var_1_10005
	math = var_1_10007

	local var_15_0 = var_1_10007.cos(arg_15_1)
	local var_15_1 = 0

	math = var_9

	local var_15_2 = var_1_10005(var_15_0, var_15_1, var_9.sin(arg_15_1))

	Vector3 = var_1_10006

	local var_15_3 = var_1_10006.Cross
	local var_15_4 = var_15_2

	Vector3 = var_9

	local var_15_5 = var_15_3(var_15_4, var_9.up)
	local var_15_6 = {
		1,
		2,
		3,
		4,
		[1] = arg_15_4 + var_15_5 * (arg_15_2 * -0.5),
		[2] = arg_15_4 + var_15_5 * (arg_15_2 * 0.5)
	}
	local var_15_7 = var_15_2 * arg_15_3

	var_15_6[3] = var_15_6[2] + var_15_7
	var_15_6[4] = var_15_6[1] + var_15_7

	local var_15_8 = var_0_10002.CldNode.New()

	Vector3 = var_1_10010

	local var_15_9 = var_1_10010(var_0_2(var_15_6[1].x, var_15_6[2].x, var_15_6[3].x, var_15_6[4].x), 0, var_0_2(var_15_6[1].z, var_15_6[2].z, var_15_6[3].z, var_15_6[4].z))

	Vector3 = var_11

	local var_15_10 = var_11(var_0_1(var_15_6[1].x, var_15_6[2].x, var_15_6[3].x, var_15_6[4].x), 0, var_0_1(var_15_6[1].z, var_15_6[2].z, var_15_6[3].z, var_15_6[4].z))

	var_15_8:UpdateStaticBox(var_15_9, var_15_10)

	local var_15_11 = arg_15_0:GetCldList(var_15_8, nil)

	if var_15_2.x * var_15_2.z == 0 then
		return var_15_11
	end

	local var_15_12
	local var_15_13
	local var_15_14
	local var_15_15

	for iter_15_0 = #var_15_11, 1, -1 do
		local var_15_16 = var_15_11[iter_15_0]

		if 0 < var_13 then
			var_15_12 = var_15_16.min
			var_15_13 = var_15_16.max
			Vector3 = var_15_17
			var_15_14 = var_15_17(var_15_12.x, 0, var_15_13.z)
			Vector3 = var_15_17
			var_15_15 = var_15_17(var_15_13.x, 0, var_15_12.z)
		else
			var_15_14 = var_15_16.min
			var_15_15 = var_15_16.max
			Vector3 = var_15_17
			var_15_12 = var_15_17(var_15_14.x, 0, var_15_15.z)
			Vector3 = var_15_17
			var_15_13 = var_15_17(var_15_15.x, 0, var_15_14.z)
		end

		repeat
			Vector3 = var_15_17

			local var_15_17 = var_15_17.Dot(var_15_2, var_15_12 - var_15_6[1])

			Vector3 = var_1_10024
			var_1_10024 = var_1_10024.Dot(var_15_2, var_15_13 - var_15_6[1])

			if var_15_17 < 0 and var_1_10024 < 0 or arg_15_3 < var_15_17 and arg_15_3 < var_1_10024 then
				var_0_10004.remove(var_15_11, iter_15_0)

				break
			end

			Vector3 = var_25

			local var_15_18 = var_25.Dot(var_15_5, var_15_14 - var_15_6[1])

			Vector3 = var_26

			local var_15_19 = var_26.Dot(var_15_5, var_15_15 - var_15_6[1])

			if var_15_18 < 0 and var_15_19 < 0 or arg_15_2 < var_15_18 and arg_15_2 < var_15_19 then
				var_0_10004.remove(var_15_11, iter_15_0)
			end

			break
		until true
	end

	return var_15_11
end

function var_5.GetCldListEllipse(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_3.x
	local var_16_1 = arg_16_3.z
	local var_16_2 = var_0_10002.CldNode.New()
	local var_16_3 = var_6.UpdateStaticBox

	Vector3 = var_1_10010

	local var_16_4 = var_1_10010(var_16_0 - arg_16_1, 0, var_16_1 - arg_16_2)

	Vector3 = var_1_10011

	var_16_3(var_16_2, var_16_4, var_1_10011(var_16_0 + arg_16_1, 0, var_16_1 + arg_16_2))

	local var_16_5 = arg_16_0
	local var_16_6 = arg_16_0.GetCldList(var_16_5, var_6, nil)
	local var_16_7 = {}

	ipairs = var_16_5

	for iter_16_0, iter_16_1 in var_16_5(var_16_6) do
		ellipseIntersectsRect = var_14

		if var_14(var_16_0, var_16_1, arg_16_1, arg_16_2, iter_16_1.min, iter_16_1.max) then
			var_0_10004.insert(var_16_7, iter_16_1)
		end
	end

	return var_16_7
end

function var_5.pointInEllipse(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = arg_17_0 - arg_17_2
	local var_17_1 = arg_17_1 - arg_17_3

	return var_17_0 * var_17_0 / (arg_17_4 * arg_17_4) + var_17_1 * var_17_1 / (arg_17_5 * arg_17_5) <= 1
end

function var_5.lineIntersectsEllipse(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	arg_18_0, arg_18_1 = arg_18_0 - arg_18_4, arg_18_1 - arg_18_5

	local var_18_0 = arg_18_2 - arg_18_4

	arg_18_3 = arg_18_3 - arg_18_5

	local var_18_1 = var_18_0 - arg_18_0
	local var_18_2 = arg_18_3 - arg_18_1
	local var_18_3 = var_18_1 * var_18_1 / (arg_18_6 * arg_18_6) + var_18_2 * var_18_2 / (arg_18_7 * arg_18_7)
	local var_18_4 = 2 * (arg_18_0 * var_18_1 / (arg_18_6 * arg_18_6) + arg_18_1 * var_18_2 / (arg_18_7 * arg_18_7))
	local var_18_5 = arg_18_0 * arg_18_0 / (arg_18_6 * arg_18_6) + arg_18_1 * arg_18_1 / (arg_18_7 * arg_18_7) - 1

	if var_18_4 * var_18_4 - 4 * var_18_3 * var_18_5 < 0 then
		return false
	end

	math = var_14

	local var_18_6 = var_14.sqrt(var_13)
	local var_18_7 = (-var_18_4 - var_18_6) / (2 * var_18_3)
	local var_18_8 = (-var_18_4 + var_18_6) / (2 * var_18_3)

	return var_18_7 >= 0 and var_18_7 <= 1 or var_18_8 >= 0 and var_18_8 <= 1
end

function var_5.ellipseIntersectsRect(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = arg_19_0 - arg_19_2
	local var_19_1 = arg_19_0 + arg_19_2
	local var_19_2 = arg_19_1 - arg_19_3
	local var_19_3 = arg_19_1 + arg_19_3

	if var_19_0 > arg_19_5.x or var_19_1 < arg_19_4.x or var_19_2 > arg_19_5.z or var_19_3 < arg_19_4.z then
		return false
	end

	local var_19_4 = {
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

	ipairs = var_11

	for iter_19_0, iter_19_1 in var_11(var_19_4) do
		if var_0.pointInEllipse(iter_19_1[1], iter_19_1[2], arg_19_0, arg_19_1, arg_19_2, arg_19_3) then
			return true
		end
	end

	if arg_19_0 >= arg_19_4.x and arg_19_0 <= arg_19_5.x and arg_19_1 >= arg_19_4.z and arg_19_1 <= arg_19_5.z then
		return true
	end

	for iter_19_2 = 1, 4 do
		local var_19_5 = var_19_4[iter_19_2]
		local var_19_6 = var_19_4[iter_19_2 % 4 + 1]

		if var_0.lineIntersectsEllipse(var_19_5[1], var_19_5[2], var_19_6[1], var_19_6[2], arg_19_0, arg_19_1, arg_19_2, arg_19_3) then
			return true
		end
	end

	return false
end

return
