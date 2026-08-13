class = var_0_10000

local var_0_0 = "Monopoly3thPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseActivityPage"))

var_0_1.ON_START = "MonopolyGame:ON_START"
var_0_1.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_1.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_1.ON_AWARD = "MonopolyGame:ON_AWARD"
var_0_1.MONOPOLY_OP_LAST = "MonopolyGame:MONOPOLY_OP_LAST"

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	Monopoly3thPage = var_1_10003

	var_1_1(var_1_0, var_1_10003.MONOPOLY_OP_LAST, function(arg_2_0, arg_2_1, arg_2_2)
		pg = var_2_10003

		local var_2_0 = var_2_10003.m02
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.MONOPOLY_OP
		local var_2_3 = {
			activity_id = arg_2_1
		}

		ActivityConst = var_2_10007
		var_2_3.cmd = var_2_10007.MONOPOLY_OP_LAST
		var_2_3.callback = arg_2_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	Monopoly3thPage = var_3

	var_1_3(var_1_2, var_3.ON_START, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.MONOPOLY_OP
		local var_3_3 = {
			activity_id = arg_3_1
		}

		ActivityConst = var_2_10007
		var_3_3.cmd = var_2_10007.MONOPOLY_OP_THROW
		var_3_3.callback = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	Monopoly3thPage = var_3

	var_1_5(var_1_4, var_3.ON_MOVE, function(arg_4_0, arg_4_1, arg_4_2)
		pg = var_2_10003

		local var_4_0 = var_2_10003.m02
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.MONOPOLY_OP
		local var_4_3 = {
			activity_id = arg_4_1
		}

		ActivityConst = var_2_10007
		var_4_3.cmd = var_2_10007.MONOPOLY_OP_MOVE
		var_4_3.callback = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	Monopoly3thPage = var_3

	var_1_7(var_1_6, var_3.ON_TRIGGER, function(arg_5_0, arg_5_1, arg_5_2)
		pg = var_2_10003

		local var_5_0 = var_2_10003.m02
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.MONOPOLY_OP
		local var_5_3 = {
			activity_id = arg_5_1
		}

		ActivityConst = var_2_10007
		var_5_3.cmd = var_2_10007.MONOPOLY_OP_TRIGGER
		var_5_3.callback = arg_5_2

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	Monopoly3thPage = var_3

	var_1_9(var_1_8, var_3.ON_AWARD, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.emit

		ActivityMediator = var_2_10003

		local var_6_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_6_1(var_6_0, var_6_2, var_2_10004.REDPACKEY)

		return
	end)

	return
end

function var_0_1.getLeftRpCount()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_7_0 = var_1_10000(var_1_10001)
	local var_7_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	local var_7_2 = var_7_1(var_7_0, var_1_10002.ACTIVITY_TYPE_MONOPOLY).data2_list[2]

	return var_0.data2_list[1] - var_7_2
end

function var_0_1.OnFirstFlush(arg_8_0)
	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	arg_9_0:updateGameUI()

	return
end

function var_0_1.updateGameUI(arg_10_0)
	if not arg_10_0.activity then
		return
	end

	if arg_10_0.gameUI then
		local var_10_0 = arg_10_0.gameUI

		var_1.updataActivity(var_10_0, arg_10_0.activity)
	else
		Monopoly3thGame = var_1

		local var_10_1 = var_1.New
		local var_10_2 = arg_10_0

		findTF = var_1_10003
		arg_10_0.gameUI = var_10_1(var_10_2, var_1_10003(arg_10_0._tf, "AD"), arg_10_0.event, 4)

		local var_10_3 = arg_10_0.gameUI

		var_1.firstUpdata(var_10_3, arg_10_0.activity)
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	local var_11_0 = arg_11_0.gameUI

	var_1.dispose(var_11_0)

	return
end

return var_0_1
