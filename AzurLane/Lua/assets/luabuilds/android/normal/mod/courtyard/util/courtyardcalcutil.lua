class = var_0_10000

local var_0_0 = var_0_10000("CourtYardCalcUtil")
local var_0_1 = 78.2
local var_0_2 = 39

function var_0_0.Screen2Local(arg_1_0, arg_1_1)
	GameObject = var_1_10002

	local var_1_0 = var_1_10002.Find("UICamera")
	local var_1_1 = var_2.GetComponent(var_1_0, "Camera")
	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.GetComponent(var_1_2, "RectTransform")

	LuaHelper = var_1_2

	return (var_1_2.ScreenToLocal(var_1_3, arg_1_1, var_1_1))
end

function var_0_0.Map2Local(arg_2_0)
	local var_2_0 = (arg_2_0.x - arg_2_0.y) * (var_0_1 / 2)
	local var_2_1 = (arg_2_0.x + arg_2_0.y) * (var_0_2 / 2)

	Vector2 = var_3

	return var_3(var_2_0, var_2_1)
end

function var_0_0.Local2Map(arg_3_0)
	math = var_1_10001

	local var_3_0 = var_1_10001.floor(arg_3_0.x / var_0_1 + arg_3_0.y / var_0_2)

	math = var_2

	local var_3_1 = var_2.floor(arg_3_0.y / var_0_2 - arg_3_0.x / var_0_1)

	Vector2 = var_3

	return var_3(var_3_0, var_3_1)
end

function var_0_0.World2Local(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.InverseTransformPoint(var_4_0, arg_4_1)

	Vector3 = var_4_0

	return var_4_0(var_4_1.x, var_4_1.y, 0)
end

function var_0_0.local2RelativeLocal(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_0.Map2Local

	Vector2 = var_1_10004

	return arg_5_0 + var_5_0(var_1_10004(arg_5_1, arg_5_2))
end

function var_0_0.TrPosition2LocalPos(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0 == arg_6_1 then
		return arg_6_2
	else
		local var_6_0 = arg_6_0:TransformPoint(arg_6_2)
		local var_6_1 = arg_6_1
		local var_6_2 = arg_6_1.InverseTransformPoint(var_6_1, var_6_0)

		Vector3 = var_6_1

		return var_6_1(var_6_2.x, var_6_2.y, 0)
	end

	return
end

function var_0_0.IsHappen(arg_7_0)
	math = var_1_10001

	return arg_7_0 >= var_1_10001.random(0, 100)
end

function var_0_0.HalfProbability()
	return var_0_0.IsHappen(50)
end

function var_0_0.GetSign(arg_9_0)
	if arg_9_0 <= 0 then
		return -1
	else
		return 1
	end

	return
end

function var_0_0.GetTransformSign(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_1.localScale.x * arg_10_0.localScale.x

	while var_10_0.parent ~= arg_10_1 do
		var_10_1 = var_10_1 * var_10_0.parent.localScale.x
	end

	return var_0_0.GetSign(var_10_1)
end

return var_0_0
