class = var_0_10000

local var_0_0 = "MonopolyCarPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseActivityPage"))

var_0_1.ON_START = "MonopolyGame:ON_START"
var_0_1.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_1.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_1.ON_AWARD = "MonopolyGame:ON_AWARD"

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	MonopolyCarPage = var_1_10004

	var_1_1(var_1_0, var_1_10004.ON_START, function(arg_2_0, arg_2_1, arg_2_2)
		pg = var_2_10003

		local var_2_0 = var_2_10003.m02
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_2_2 = var_2_10006.MONOPOLY_OP
		local var_2_3 = {
			activity_id = arg_2_1
		}

		ActivityConst = var_2_10008
		var_2_3.cmd = var_2_10008.MONOPOLY_OP_THROW
		var_2_3.callback = arg_2_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	MonopolyCarPage = var_4

	var_1_3(var_1_2, var_4.ON_MOVE, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.MONOPOLY_OP
		local var_3_3 = {
			activity_id = arg_3_1
		}

		ActivityConst = var_2_10008
		var_3_3.cmd = var_2_10008.MONOPOLY_OP_MOVE
		var_3_3.callback = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	MonopolyCarPage = var_4

	var_1_5(var_1_4, var_4.ON_TRIGGER, function(arg_4_0, arg_4_1, arg_4_2)
		pg = var_2_10003

		local var_4_0 = var_2_10003.m02
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_4_2 = var_2_10006.MONOPOLY_OP
		local var_4_3 = {
			activity_id = arg_4_1
		}

		ActivityConst = var_2_10008
		var_4_3.cmd = var_2_10008.MONOPOLY_OP_TRIGGER
		var_4_3.callback = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	MonopolyCarPage = var_4

	var_1_7(var_1_6, var_4.ON_AWARD, function(arg_5_0)
		pg = var_2_10001

		local var_5_0 = var_2_10001.m02
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_5_2 = var_2_10004.MONOPOLY_OP
		local var_5_3 = {
			activity_id = arg_1_0.activity.id
		}

		ActivityConst = var_6
		var_5_3.cmd = var_6.MONOPOLY_OP_AWARD

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	if arg_7_0.gameUI then
		local var_7_0 = arg_7_0.gameUI

		var_1.updataActivity(var_7_0, arg_7_0.activity)
	else
		MonopolyCarGame = var_1

		local var_7_1 = var_1.New
		local var_7_2 = arg_7_0

		findTF = var_1_10004
		arg_7_0.gameUI = var_7_1(var_7_2, var_1_10004(arg_7_0._tf, "AD"), arg_7_0.event)

		local var_7_3 = arg_7_0.gameUI

		var_1.firstUpdata(var_7_3, arg_7_0.activity)
	end

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
