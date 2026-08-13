class = var_0_10000

local var_0_0 = "WSMapTransform"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".WSMapObject"))

var_0_1.Fields = {
	modelOrder = "number",
	isMoving = "boolean",
	transform = "userdata"
}

function var_0_1.Dispose(arg_1_0)
	arg_1_0:ClearModelOrder()
	arg_1_0:Clear()

	return
end

function var_0_1.SetModelOrder(arg_2_0, arg_2_1, arg_2_2)
	assert = var_1_10003

	var_1_10003(arg_2_0.transform)

	GetComponent = var_1_10003

	local var_2_0 = arg_2_0.transform

	typeof = var_1_10005
	Canvas = var_1_10006

	if not var_1_10003(var_2_0, var_1_10005(var_1_10006)) then
		SetCanvasOverrideSorting = var_3

		var_3(arg_2_0.transform, true)
	end

	local var_2_1 = 0

	if arg_2_0.modelOrder then
		var_2_1 = var_2_1 - arg_2_0.modelOrder
	end

	defaultValue = var_4
	arg_2_0.modelOrder = arg_2_1 + var_4(arg_2_2, 0) * 10

	if var_2_1 + arg_2_0.modelOrder ~= 0 then
		WorldConst = var_4

		var_4.ArrayEffectOrder(arg_2_0.transform, var_3)
	end

	return
end

function var_0_1.ClearModelOrder(arg_3_0)
	assert = var_1_10001

	var_1_10001(arg_3_0.transform)
	arg_3_0:UnloadModel()

	if arg_3_0.modelOrder then
		WorldConst = var_1

		var_1.ArrayEffectOrder(arg_3_0.transform, -arg_3_0.modelOrder)

		arg_3_0.modelOrder = nil
	end

	return
end

function var_0_1.LoadModel(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	var_0_1.super.LoadModel(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, function()
		if arg_4_0.modelOrder then
			WorldConst = var_0

			var_0.ArrayEffectOrder(arg_4_0.model, arg_4_0.modelOrder)
		end

		existCall = var_0

		return var_0(arg_4_5)
	end)

	return
end

function var_0_1.UnloadModel(arg_6_0)
	if arg_6_0.modelOrder and arg_6_0.model then
		WorldConst = var_1

		var_1.ArrayEffectOrder(arg_6_0.model, -arg_6_0.modelOrder)
	end

	var_0_1.super.UnloadModel(arg_6_0)

	return
end

return var_0_1
