class = var_0_10000

local var_0_0 = "MonopolyCar2024Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MonopolyCar2024UI"
end

function var_0_1.init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0.contextData.actId

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_3_1 = var_1_10002(var_1_10004)
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
		MonopolyCar2024Game = var_2

		local var_4_1 = var_2.New
		local var_4_2 = arg_4_0.activity
		local var_4_3 = arg_4_0._tf

		arg_4_0.gameUI = var_4_1(var_4_2, var_5.Find(var_4_3, "adapt"), arg_4_0.event)
	end

	return
end

function var_0_1.onBackPressed(arg_5_0)
	var_0_1.super.onBackPressed(arg_5_0)

	return
end

function var_0_1.willExit(arg_6_0)
	if arg_6_0.gameUI then
		local var_6_0 = arg_6_0.gameUI

		var_1.Dispose(var_6_0)

		arg_6_0.gameUI = nil
	end

	return
end

return var_0_1
