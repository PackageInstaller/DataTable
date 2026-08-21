local var_0_0 = class("CourtYardCalcUtil")
local var_0_1 = 78.2
local var_0_2 = 39

function var_0_0.Screen2Local(arg_1_0, arg_1_1)
	return (LuaHelper.ScreenToLocal(arg_1_0:GetComponent("RectTransform"), arg_1_1, (GameObject.Find("UICamera"):GetComponent("Camera"))))
end

function var_0_0.Map2Local(arg_2_0)
	return Vector2((arg_2_0.x - arg_2_0.y) * (var_0_1 / 2), (arg_2_0.x + arg_2_0.y) * (var_0_2 / 2))
end

function var_0_0.Local2Map(arg_3_0)
	return Vector2(math.floor(arg_3_0.x / var_0_1 + arg_3_0.y / var_0_2), (math.floor(arg_3_0.y / var_0_2 - arg_3_0.x / var_0_1)))
end

function var_0_0.World2Local(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:InverseTransformPoint(arg_4_1)

	return Vector3(var_4_0.x, var_4_0.y, 0)
end

function var_0_0.local2RelativeLocal(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0 + var_0_0.Map2Local(Vector2(arg_5_1, arg_5_2))
end

function var_0_0.TrPosition2LocalPos(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0 == arg_6_1 then
		return arg_6_2
	else
		local var_6_0 = arg_6_1:InverseTransformPoint((arg_6_0:TransformPoint(arg_6_2)))

		return Vector3(var_6_0.x, var_6_0.y, 0)
	end

	return
end

function var_0_0.IsHappen(arg_7_0)
	return arg_7_0 >= math.random(0, 100)
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
		var_10_0 = var_10_0.parent
		var_10_1 = var_10_1 * var_10_0.localScale.x
	end

	return var_0_0.GetSign(var_10_1)
end

return var_0_0
