local var_0_0 = class("MainResetL2dBtn", import(".MainBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:bind(GAME.ROTATE_PAINTING_INDEX, function()
		arg_1_0:FlushL2d()

		return
	end)

	return
end

function var_0_0.OnClick(arg_3_0)
	arg_3_0:emit(NewMainScene.RESET_L2D)

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1)
	arg_4_0:FlushL2d()

	return
end

function var_0_0.FlushL2d(arg_5_0)
	if not getProxy(SettingsProxy):ShowL2dResetInMainScene() then
		setActive(arg_5_0._tf, false)

		return
	end

	local var_5_0 = getProxy(PlayerProxy):getRawData()
	local var_5_1 = MainPaintingView.GetAssistantStatus((var_5_0:GetFlagShip()))

	setActive(arg_5_0._tf, var_5_1 == MainPaintingView.STATE_L2D)

	return
end

return var_0_0
