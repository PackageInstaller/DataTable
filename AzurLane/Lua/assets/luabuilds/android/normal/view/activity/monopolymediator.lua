class = var_0_10000

local var_0_0 = "MonopolyPtMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_START = "MonopolyGame:ON_START"
var_0_1.ON_MOVE = "MonopolyGame:ON_MOVE"
var_0_1.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
var_0_1.ON_AWARD = "MonopolyGame:ON_AWARD"
var_0_1.MONOPOLY_OP_LAST = "MonopolyGame:MONOPOLY_OP_LAST"
var_0_1.ON_STOP = "MonopolyGame:MONOPOLY_ON_STOP"
var_0_1.AWARDS = {}

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	MonopolyPtMediator = var_1_10003

	var_1_1(var_1_0, var_1_10003.ON_STOP, function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_1_0.viewComponent.autoFlag then
			MonopolyPtMediator = var_3

			if #var_3.AWARDS > 0 then
				local var_2_0 = arg_1_0
				local var_2_1 = var_3.emit

				BaseUI = var_2_10005

				local var_2_2 = var_2_10005.ON_ACHIEVE

				MonopolyPtMediator = var_2_10006

				var_2_1(var_2_0, var_2_2, var_2_10006.AWARDS, arg_2_2)

				MonopolyPtMediator = var_2_1
				var_2_1.AWARDS = {}
			end
		end

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	MonopolyPtMediator = var_3

	var_1_3(var_1_2, var_3.MONOPOLY_OP_LAST, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.MONOPOLY_OP
		local var_3_3 = {
			activity_id = arg_3_1
		}

		ActivityConst = var_2_10007
		var_3_3.cmd = var_2_10007.MONOPOLY_OP_LAST
		var_3_3.callback = arg_3_2

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	MonopolyPtMediator = var_3

	var_1_5(var_1_4, var_3.ON_START, function(arg_4_0, arg_4_1, arg_4_2)
		pg = var_2_10003

		local var_4_0 = var_2_10003.m02
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_4_2 = var_2_10005.MONOPOLY_OP
		local var_4_3 = {
			activity_id = arg_4_1
		}

		ActivityConst = var_2_10007
		var_4_3.cmd = var_2_10007.MONOPOLY_OP_THROW
		var_4_3.callback = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	MonopolyPtMediator = var_3

	var_1_7(var_1_6, var_3.ON_MOVE, function(arg_5_0, arg_5_1, arg_5_2)
		pg = var_2_10003

		local var_5_0 = var_2_10003.m02
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.MONOPOLY_OP
		local var_5_3 = {
			activity_id = arg_5_1
		}

		ActivityConst = var_2_10007
		var_5_3.cmd = var_2_10007.MONOPOLY_OP_MOVE
		var_5_3.callback = arg_5_2

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	MonopolyPtMediator = var_3

	var_1_9(var_1_8, var_3.ON_TRIGGER, function(arg_6_0, arg_6_1, arg_6_2)
		pg = var_2_10003

		local var_6_0 = var_2_10003.m02
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_6_2 = var_2_10005.MONOPOLY_OP
		local var_6_3 = {
			activity_id = arg_6_1
		}

		ActivityConst = var_2_10007
		var_6_3.cmd = var_2_10007.MONOPOLY_OP_TRIGGER
		var_6_3.callback = arg_6_2

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.bind

	MonopolyPtMediator = var_3

	var_1_11(var_1_10, var_3.ON_AWARD, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.emit

		ActivityMediator = var_2_10003

		local var_7_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.REDPACKEY)

		return
	end)

	arg_1_0._configId = arg_1_0.contextData.configId
	arg_1_0._activityId = arg_1_0.contextData.activityId
	getProxy = var_1
	ActivityProxy = var_1_10

	local var_1_12 = var_1(var_1_10)

	arg_1_0._activity = var_1.getActivityById(var_1_12, arg_1_0._activityId)

	local var_1_13 = arg_1_0.viewComponent

	var_1.firstUpdata(var_1_13, arg_1_0._activity)

	if not arg_1_0.viewComponent.autoFlag then
		MonopolyPtMediator = var_1

		if #var_1.AWARDS > 0 then
			local var_1_14 = arg_1_0
			local var_1_15 = arg_1_0.emit

			BaseUI = var_3

			local var_1_16 = var_3.ON_ACHIEVE

			MonopolyPtMediator = var_4

			var_1_15(var_1_14, var_1_16, var_4.AWARDS, function()
				return
			end)

			MonopolyPtMediator = var_1_15
			var_1_15.AWARDS = {}
		end
	end

	return
end

function var_0_1.getLeftRpCount()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_9_0 = var_1_10000(var_1_10001)
	local var_9_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	local var_9_2 = var_9_1(var_9_0, var_1_10002.ACTIVITY_TYPE_MONOPOLY).data2_list[2]

	return var_0.data2_list[1] - var_9_2
end

function var_0_1.onAward(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0 = 1, #arg_10_1 do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert
		MonopolyPtMediator = var_1_10008

		var_1_10007(var_1_10008.AWARDS, arg_10_1[iter_10_0])
	end

	if arg_10_0.viewComponent.autoFlag then
		local var_10_0 = arg_10_0.viewComponent

		var_3.addAwards(var_10_0, arg_10_1)

		if arg_10_2 then
			arg_10_2()
		end
	else
		local var_10_1 = arg_10_0
		local var_10_2 = arg_10_0.emit

		BaseUI = var_5

		local var_10_3 = var_5.ON_ACHIEVE

		MonopolyPtMediator = iter_10_0

		var_10_2(var_10_1, var_10_3, iter_10_0.AWARDS, arg_10_2)

		MonopolyPtMediator = var_10_2
		var_10_2.AWARDS = {}
	end

	return
end

function var_0_1.listNotificationInterests(arg_11_0)
	local var_11_0 = {}

	ActivityProxy = var_1_10002
	var_11_0[1] = var_1_10002.ACTIVITY_UPDATED
	ActivityProxy = var_2
	var_11_0[2] = var_2.ACTIVITY_ADDED
	GAME = var_2
	var_11_0[3] = var_2.MONOPOLY_AWARD_DONE

	return var_11_0
end

function var_0_1.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()
	local var_12_2 = arg_12_1
	local var_12_3 = arg_12_1.getType(var_12_2)

	ActivityProxy = var_12_2

	if var_12_0 ~= var_12_2.ACTIVITY_UPDATED then
		ActivityProxy = var_5

		if var_12_0 == var_5.ACTIVITY_ADDED then
			arg_12_0:updateGameUI()
		else
			GAME = var_5

			if var_12_0 == var_5.MONOPOLY_AWARD_DONE then
				local var_12_4 = arg_12_0._activity
				local var_12_5 = var_5.getConfig(var_12_4, "type")

				ActivityConst = var_12_4

				if var_12_5 == var_12_4.ACTIVITY_TYPE_MONOPOLY and arg_12_0.viewComponent.onAward then
					local var_12_6 = arg_12_0.viewComponent

					var_5.onAward(var_12_6, var_12_1.awards, var_12_1.callback)
				else
					local var_12_7 = arg_12_0.viewComponent
					local var_12_8 = var_5.emit

					BaseUI = var_7

					var_12_8(var_12_7, var_7.ON_ACHIEVE, var_12_1.awards, var_12_1.callback)
				end
			end
		end

		return
	end
end

function var_0_1.updateGameUI(arg_13_0)
	if not arg_13_0._activityId then
		return
	end

	getProxy = var_1
	ActivityProxy = var_1_10002

	local var_13_0 = var_1(var_1_10002)

	arg_13_0._activity = var_1.getActivityById(var_13_0, arg_13_0._activityId)

	local var_13_1 = arg_13_0.viewComponent

	var_1.updataActivity(var_13_1, arg_13_0._activity)

	return
end

function var_0_1.remove(arg_14_0)
	if arg_14_0.viewComponent then
		MonopolyPtMediator = var_1
		var_1.AWARDS = {}
	end

	return
end

return var_0_1
