local var_0_0 = class("MainCommissionBtn", import(".MainBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.animTime = arg_1_3 or 0.2

	arg_1_0:bind(NewMainMediator.REMOVE_LAYERS, function(arg_2_0, arg_2_1)
		arg_1_0:OnRemoveLayer(arg_2_1.context)

		return
	end)

	return
end

function var_0_0.IsFixed(arg_3_0)
	return true
end

function var_0_0.OnClick(arg_4_0)
	if LeanTween.isTweening(arg_4_0._tf.gameObject) then
		return
	end

	LeanTween.moveX(arg_4_0._tf, -1 * arg_4_0._tf.rect.width, arg_4_0.animTime):setOnComplete(System.Action(function()
		arg_4_0:emit(NewMainMediator.OPEN_COMMISION)

		return
	end))

	return
end

function var_0_0.OnRemoveLayer(arg_6_0, arg_6_1)
	if arg_6_1.mediator == CommissionInfoMediator then
		arg_6_0:ResetCommissionBtn()
	end

	return
end

function var_0_0.ResetCommissionBtn(arg_7_0)
	arg_7_0._tf.localPosition = Vector3(0, arg_7_0._tf.localPosition.y, 0)

	return
end

function var_0_0.Flush(arg_8_0, arg_8_1)
	arg_8_0:ResetCommissionBtn()

	return
end

return var_0_0
