class = var_0_10000

local var_0_0 = "MainResetL2dBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_6

	var_1_1(var_1_0, var_6.ROTATE_PAINTING_INDEX, function()
		local var_2_0 = arg_1_0

		var_0.FlushL2d(var_2_0)

		return
	end)

	return
end

function var_0_1.OnClick(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NewMainScene = var_1_10004

	var_3_1(var_3_0, var_1_10004.RESET_L2D)

	return
end

function var_0_1.Flush(arg_4_0, arg_4_1)
	arg_4_0:FlushL2d()

	return
end

function var_0_1.FlushL2d(arg_5_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)

	if not var_1.ShowL2dResetInMainScene(var_5_0) then
		setActive = var_1

		var_1(arg_5_0._tf, false)

		return
	end

	getProxy = var_1
	PlayerProxy = var_5_0

	local var_5_1 = var_1(var_5_0)
	local var_5_2 = var_1.getRawData(var_5_1)
	local var_5_3 = var_1.GetFlagShip(var_5_2)

	MainPaintingView = var_1_10002

	local var_5_4 = var_1_10002.GetAssistantStatus(var_5_3)

	MainPaintingView = var_5_2

	local var_5_5 = var_5_4 == var_5_2.STATE_L2D

	setActive = var_4

	var_4(arg_5_0._tf, var_5_5)

	return
end

return var_0_1
