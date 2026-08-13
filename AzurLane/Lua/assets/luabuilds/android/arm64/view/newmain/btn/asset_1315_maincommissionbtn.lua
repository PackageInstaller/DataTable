class = var_0_10000

local var_0_0 = "MainCommissionBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.animTime = arg_1_3 or 0.2

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	NewMainMediator = var_7

	var_1_1(var_1_0, var_7.REMOVE_LAYERS, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.OnRemoveLayer(var_2_0, arg_2_1.context)

		return
	end)

	return
end

function var_0_1.IsFixed(arg_3_0)
	return true
end

function var_0_1.OnClick(arg_4_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_4_0._tf.gameObject) then
		return
	end

	LeanTween = var_1

	local var_4_0 = var_1.moveX(arg_4_0._tf, -1 * arg_4_0._tf.rect.width, arg_4_0.animTime)
	local var_4_1 = var_1.setOnComplete

	System = var_4

	var_4_1(var_4_0, var_4.Action(function()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		NewMainMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.OPEN_COMMISION)

		return
	end))

	return
end

function var_0_1.OnRemoveLayer(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.mediator

	CommissionInfoMediator = var_1_10003

	if var_6_0 == var_1_10003 then
		arg_6_0:ResetCommissionBtn()
	end

	return
end

function var_0_1.ResetCommissionBtn(arg_7_0)
	local var_7_0 = arg_7_0._tf.localPosition
	local var_7_1 = arg_7_0._tf

	Vector3 = var_1_10003
	var_7_1.localPosition = var_1_10003(0, var_7_0.y, 0)

	return
end

function var_0_1.Flush(arg_8_0, arg_8_1)
	arg_8_0:ResetCommissionBtn()

	return
end

return var_0_1
