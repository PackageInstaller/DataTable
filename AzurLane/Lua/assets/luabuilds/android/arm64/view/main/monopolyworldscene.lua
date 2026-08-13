class = var_0_10000

local var_0_0 = "MonopolyWorldScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.ON_START = "MonopolyGame:ON_START"
var_0_1.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_1.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_1.ON_AWARD = "MonopolyGame:ON_AWARD"
var_0_1.ON_CLOSE = "MonopolyGame:ON_CLOSE"

function var_0_1.getUIName(arg_1_0)
	return "MonopolyWorldUI"
end

function var_0_1.init(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_2_0.activity = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_MONOPOLY)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.bind

	MonopolyWorldScene = var_4

	var_2_3(var_2_2, var_4.ON_START, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.MONOPOLY_OP
		local var_3_3 = {
			activity_id = arg_3_1
		}

		ActivityConst = var_2_10008
		var_3_3.cmd = var_2_10008.MONOPOLY_OP_THROW
		var_3_3.callback = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.bind

	MonopolyWorldScene = var_4

	var_2_5(var_2_4, var_4.ON_MOVE, function(arg_4_0, arg_4_1, arg_4_2)
		pg = var_2_10003

		local var_4_0 = var_2_10003.m02
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_4_2 = var_2_10006.MONOPOLY_OP
		local var_4_3 = {
			activity_id = arg_4_1
		}

		ActivityConst = var_2_10008
		var_4_3.cmd = var_2_10008.MONOPOLY_OP_MOVE
		var_4_3.callback = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.bind

	MonopolyWorldScene = var_4

	var_2_7(var_2_6, var_4.ON_TRIGGER, function(arg_5_0, arg_5_1, arg_5_2)
		pg = var_2_10003

		local var_5_0 = var_2_10003.m02
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_5_2 = var_2_10006.MONOPOLY_OP
		local var_5_3 = {
			activity_id = arg_5_1
		}

		ActivityConst = var_2_10008
		var_5_3.cmd = var_2_10008.MONOPOLY_OP_TRIGGER
		var_5_3.callback = arg_5_2

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.bind

	MonopolyWorldScene = var_4

	var_2_9(var_2_8, var_4.ON_AWARD, function(arg_6_0)
		pg = var_2_10001

		local var_6_0 = var_2_10001.m02
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_6_2 = var_2_10004.MONOPOLY_OP
		local var_6_3 = {
			activity_id = arg_2_0.activity.id
		}

		ActivityConst = var_6
		var_6_3.cmd = var_6.MONOPOLY_OP_AWARD

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)

	MonopolyWorldGame = var_2_9

	local var_2_10 = var_2_9.New
	local var_2_11 = arg_2_0

	findTF = var_4
	arg_2_0.gameUI = var_2_10(var_2_11, var_4(arg_2_0._tf, "AD"), arg_2_0.event)

	local var_2_12 = arg_2_0.gameUI

	var_1.firstUpdata(var_2_12, arg_2_0.activity)

	return
end

function var_0_1.willExit(arg_7_0)
	if arg_7_0.gameUI then
		local var_7_0 = arg_7_0.gameUI

		var_1.dispose(var_7_0)
	end

	return
end

function var_0_1.onBackPressed(arg_8_0)
	if arg_8_0.gameUI.inAnimatedFlag then
		return
	end

	arg_8_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

return var_0_1
