class = var_0_10000

local var_0_0 = "MonopolyCar2024Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MonopolyCar2024UI"
end

function var_0_1.init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0.contextData.actId

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_3_1 = var_1_10002(var_1_10003)
	local var_3_2 = var_2.getActivityById(var_3_1, var_3_0)

	arg_3_0:UpdateGame(var_3_2)

	return
end

function var_0_1.UpdateGame(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	if arg_4_0.gameUI then
		local var_4_0 = arg_4_0.gameUI

		var_2.UpdateActivity(var_4_0, arg_4_0.activity)
	else
		arg_4_0.gameUI = arg_4_0:NewGame()

		local var_4_1 = arg_4_0.gameUI

		var_2.Setup(var_4_1)
	end

	return
end

function var_0_1.UpdateStory(arg_5_0)
	if not arg_5_0.gameUI then
		return
	end

	local var_5_0 = arg_5_0.gameUI

	var_1.UpdateStory(var_5_0)

	return
end

function var_0_1.NewGame(arg_6_0)
	MonopolyCar2024Game = var_1_10001

	local var_6_0 = var_1_10001.New
	local var_6_1 = arg_6_0.activity
	local var_6_2 = arg_6_0._tf

	return var_6_0(var_6_1, var_3.Find(var_6_2, "adapt"), arg_6_0.event)
end

function var_0_1.onBackPressed(arg_7_0)
	if arg_7_0.gameUI and arg_7_0.gameUI.isBlocksRaycasts then
		return
	end

	var_0_1.super.onBackPressed(arg_7_0)

	return
end

function var_0_1.willExit(arg_8_0)
	if arg_8_0.gameUI then
		local var_8_0 = arg_8_0.gameUI

		var_1.Dispose(var_8_0)

		arg_8_0.gameUI = nil
	end

	return
end

return var_0_1
