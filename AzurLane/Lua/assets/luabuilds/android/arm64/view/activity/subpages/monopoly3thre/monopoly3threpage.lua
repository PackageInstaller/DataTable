class = var_0_10000

local var_0_0 = "Monopoly3thRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseActivityPage"))

var_0_1.ON_START = "MonopolyGame:ON_START"
var_0_1.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_1.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_1.ON_AWARD = "MonopolyGame:ON_AWARD"
var_0_1.MONOPOLY_OP_LAST = "MonopolyGame:MONOPOLY_OP_LAST"
var_0_1.ON_STOP = "MonopolyGame:MONOPOLY_ON_STOP"
var_0_1.AWARDS = {}

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	Monopoly3thRePage = var_1_10004

	var_1_1(var_1_0, var_1_10004.ON_STOP, function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_1_0.gameUI.autoFlag then
			Monopoly3thRePage = var_3

			if #var_3.AWARDS > 0 then
				local var_2_0 = arg_1_0
				local var_2_1 = var_3.emit

				BaseUI = var_2_10006

				local var_2_2 = var_2_10006.ON_ACHIEVE

				Monopoly3thRePage = var_2_10007

				var_2_1(var_2_0, var_2_2, var_2_10007.AWARDS, arg_2_2)

				Monopoly3thRePage = var_2_1
				var_2_1.AWARDS = {}
			end
		end

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	Monopoly3thRePage = var_4

	var_1_3(var_1_2, var_4.MONOPOLY_OP_LAST, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.MONOPOLY_OP
		local var_3_3 = {
			activity_id = arg_3_1
		}

		ActivityConst = var_2_10008
		var_3_3.cmd = var_2_10008.MONOPOLY_OP_LAST
		var_3_3.callback = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	Monopoly3thRePage = var_4

	var_1_5(var_1_4, var_4.ON_START, function(arg_4_0, arg_4_1, arg_4_2)
		pg = var_2_10003

		local var_4_0 = var_2_10003.m02
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_4_2 = var_2_10006.MONOPOLY_OP
		local var_4_3 = {
			activity_id = arg_4_1
		}

		ActivityConst = var_2_10008
		var_4_3.cmd = var_2_10008.MONOPOLY_OP_THROW
		var_4_3.callback = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	Monopoly3thRePage = var_4

	var_1_7(var_1_6, var_4.ON_MOVE, function(arg_5_0, arg_5_1, arg_5_2)
		pg = var_2_10003

		local var_5_0 = var_2_10003.m02
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_5_2 = var_2_10006.MONOPOLY_OP
		local var_5_3 = {
			activity_id = arg_5_1
		}

		ActivityConst = var_2_10008
		var_5_3.cmd = var_2_10008.MONOPOLY_OP_MOVE
		var_5_3.callback = arg_5_2

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	Monopoly3thRePage = var_4

	var_1_9(var_1_8, var_4.ON_TRIGGER, function(arg_6_0, arg_6_1, arg_6_2)
		pg = var_2_10003

		local var_6_0 = var_2_10003.m02
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_6_2 = var_2_10006.MONOPOLY_OP
		local var_6_3 = {
			activity_id = arg_6_1
		}

		ActivityConst = var_2_10008
		var_6_3.cmd = var_2_10008.MONOPOLY_OP_TRIGGER
		var_6_3.callback = arg_6_2

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.bind

	Monopoly3thRePage = var_4

	var_1_11(var_1_10, var_4.ON_AWARD, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.emit

		ActivityMediator = var_2_10004

		local var_7_2 = var_2_10004.EVENT_GO_SCENE

		SCENE = var_2_10005

		var_7_1(var_7_0, var_7_2, var_2_10005.REDPACKEY)

		return
	end)

	return
end

function var_0_1.getLeftRpCount()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_8_0 = var_1_10000(var_1_10002)
	local var_8_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_8_2 = var_8_1(var_8_0, var_1_10003.ACTIVITY_TYPE_MONOPOLY).data2_list[2]

	return var_0.data2_list[1] - var_8_2
end

function var_0_1.onAward(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0 = 1, #arg_9_1 do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert
		Monopoly3thRePage = var_1_10009

		var_1_10007(var_1_10009.AWARDS, arg_9_1[iter_9_0])
	end

	if arg_9_0.gameUI.autoFlag then
		local var_9_0 = arg_9_0.gameUI

		var_3.addAwards(var_9_0, arg_9_1)

		if arg_9_2 then
			arg_9_2()
		end
	else
		local var_9_1 = arg_9_0
		local var_9_2 = arg_9_0.emit

		BaseUI = iter_9_0

		local var_9_3 = iter_9_0.ON_ACHIEVE

		Monopoly3thRePage = var_1_10007

		var_9_2(var_9_1, var_9_3, var_1_10007.AWARDS, arg_9_2)

		Monopoly3thRePage = var_9_2
		var_9_2.AWARDS = {}
	end

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	arg_10_0:updateGameUI()

	return
end

function var_0_1.updateGameUI(arg_11_0)
	if not arg_11_0.activity then
		return
	end

	if arg_11_0.gameUI then
		local var_11_0 = arg_11_0.gameUI

		var_1.updataActivity(var_11_0, arg_11_0.activity)
	else
		Monopoly3thReGame = var_1

		local var_11_1 = var_1.New
		local var_11_2 = arg_11_0

		findTF = var_1_10004
		arg_11_0.gameUI = var_11_1(var_11_2, var_1_10004(arg_11_0._tf, "AD"), arg_11_0.event, 4)

		local var_11_3 = arg_11_0.gameUI

		var_1.firstUpdata(var_11_3, arg_11_0.activity)

		if not arg_11_0.gameUI.autoFlag then
			Monopoly3thRePage = var_1

			if #var_1.AWARDS > 0 then
				local var_11_4 = arg_11_0
				local var_11_5 = arg_11_0.emit

				BaseUI = var_4

				local var_11_6 = var_4.ON_ACHIEVE

				Monopoly3thRePage = var_5

				var_11_5(var_11_4, var_11_6, var_5.AWARDS, function()
					return
				end)

				Monopoly3thRePage = var_11_5
				var_11_5.AWARDS = {}
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_13_0)
	if arg_13_0.gameUI then
		Monopoly3thRePage = var_1
		var_1.AWARDS = {}

		local var_13_0 = arg_13_0.gameUI

		var_1.dispose(var_13_0)

		arg_13_0.gameUI = nil
	end

	return
end

function var_0_1.OnHideFlush(arg_14_0)
	if arg_14_0.gameUI then
		Monopoly3thRePage = var_1
		var_1.AWARDS = {}

		local var_14_0 = arg_14_0.gameUI

		var_1.dispose(var_14_0)

		arg_14_0.gameUI = nil
	end

	return
end

return var_0_1
