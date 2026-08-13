class = var_0_10000

local var_0_0 = "MonopolyCar2024Mediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_START = "MonopolyCar2024Mediator:ON_START"
var_0_1.ON_MOVE = "MonopolyCar2024Mediator:ON_MOVE"
var_0_1.ON_PICK = "MonopolyCar2024Mediator:ON_PICK"
var_0_1.ON_DIALOGUE = "MonopolyCar2024Mediator:ON_DIALOGUE"
var_0_1.ON_AUTO = "MonopolyCar2024Mediator:ON_AUTO"
var_0_1.ON_TRIGGER = "MonopolyCar2024Mediator:ON_TRIGGER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TRIGGER, function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		local var_2_0 = arg_1_0.viewComponent.gameUI.autoFlag
		local var_2_1 = arg_1_0.viewComponent.gameUI.awardCollector

		pg = var_2_10005

		local var_2_2 = var_2_10005.m02
		local var_2_3 = var_5.sendNotification

		GAME = var_2_10008

		local var_2_4 = var_2_10008.MONOPOLY_OP
		local var_2_5 = {
			activity_id = arg_2_1
		}

		ActivityConst = var_2_10010
		var_2_5.cmd = var_2_10010.MONOPOLY_OP_TRIGGER
		var_2_5.autoFlag = var_2_0
		var_2_5.awardCollector = var_2_1
		var_2_5.callback = arg_2_2

		var_2_3(var_2_2, var_2_4, var_2_5)

		return
	end)
	arg_1_0:bind(var_0_1.ON_AUTO, function(arg_3_0, arg_3_1)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		local var_3_0 = arg_1_0.viewComponent.gameUI.autoFlag
		local var_3_1 = arg_1_0.viewComponent.gameUI.awardCollector

		pg = var_2_10004

		local var_3_2 = var_2_10004.m02
		local var_3_3 = var_4.sendNotification

		GAME = var_2_10007

		local var_3_4 = var_2_10007.MONOPOLY_OP
		local var_3_5 = {
			activity_id = arg_3_1,
			autoFlag = var_3_0,
			awardCollector = var_3_1
		}

		ActivityConst = var_2_10009
		var_3_5.cmd = var_2_10009.MONOPOLY_OP_AUTO

		var_3_3(var_3_2, var_3_4, var_3_5)

		return
	end)
	arg_1_0:bind(var_0_1.ON_PICK, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		local var_4_0 = arg_1_0.viewComponent.gameUI.autoFlag
		local var_4_1 = arg_1_0.viewComponent.gameUI.awardCollector

		pg = var_2_10006

		local var_4_2 = var_2_10006.m02
		local var_4_3 = var_6.sendNotification

		GAME = var_2_10009

		local var_4_4 = var_2_10009.MONOPOLY_OP
		local var_4_5 = {
			activity_id = arg_4_1,
			arg1 = arg_4_2,
			autoFlag = var_4_0,
			awardCollector = var_4_1
		}

		ActivityConst = var_2_10011
		var_4_5.cmd = var_2_10011.MONOPOLY_OP_PICK
		var_4_5.callback = arg_4_3

		var_4_3(var_4_2, var_4_4, var_4_5)

		return
	end)
	arg_1_0:bind(var_0_1.ON_START, function(arg_5_0, arg_5_1, arg_5_2)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		local var_5_0 = arg_1_0.viewComponent.gameUI.autoFlag
		local var_5_1 = arg_1_0.viewComponent.gameUI.awardCollector

		pg = var_2_10005

		local var_5_2 = var_2_10005.m02
		local var_5_3 = var_5.sendNotification

		GAME = var_2_10008

		local var_5_4 = var_2_10008.MONOPOLY_OP
		local var_5_5 = {
			activity_id = arg_5_1,
			autoFlag = var_5_0,
			awardCollector = var_5_1
		}

		ActivityConst = var_2_10010
		var_5_5.cmd = var_2_10010.MONOPOLY_OP_THROW
		var_5_5.callback = arg_5_2

		var_5_3(var_5_2, var_5_4, var_5_5)

		return
	end)
	arg_1_0:bind(var_0_1.ON_MOVE, function(arg_6_0, arg_6_1, arg_6_2)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		local var_6_0 = arg_1_0.viewComponent.gameUI.autoFlag
		local var_6_1 = arg_1_0.viewComponent.gameUI.awardCollector

		pg = var_2_10005

		local var_6_2 = var_2_10005.m02
		local var_6_3 = var_5.sendNotification

		GAME = var_2_10008

		local var_6_4 = var_2_10008.MONOPOLY_OP
		local var_6_5 = {
			activity_id = arg_6_1,
			autoFlag = var_6_0,
			awardCollector = var_6_1
		}

		ActivityConst = var_2_10010
		var_6_5.cmd = var_2_10010.MONOPOLY_OP_MOVE
		var_6_5.callback = arg_6_2

		var_6_3(var_6_2, var_6_4, var_6_5)

		return
	end)
	arg_1_0:bind(var_0_1.ON_DIALOGUE, function(arg_7_0, arg_7_1, arg_7_2)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		local var_7_0 = arg_1_0.viewComponent.gameUI.autoFlag
		local var_7_1 = arg_1_0.viewComponent.gameUI.awardCollector

		pg = var_2_10005

		local var_7_2 = var_2_10005.m02
		local var_7_3 = var_5.sendNotification

		GAME = var_2_10008

		local var_7_4 = var_2_10008.MONOPOLY_OP
		local var_7_5 = {
			activity_id = arg_7_1,
			autoFlag = var_7_0,
			awardCollector = var_7_1
		}

		ActivityConst = var_2_10010
		var_7_5.cmd = var_2_10010.MONOPOLY_OP_DIALOGUE
		var_7_5.arg1 = arg_7_2

		var_7_3(var_7_2, var_7_4, var_7_5)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	ActivityProxy = var_1_10002
	var_8_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_8_0[2] = var_2.STORY_UPDATE_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1
	local var_9_3 = arg_9_1.getBody(var_9_2)

	ActivityProxy = var_9_0

	local var_9_4

	if var_9_1 == var_9_0.ACTIVITY_UPDATED then
		var_9_4 = var_9_3:getConfig("type")
		ActivityConst = var_9_2

		if var_9_4 == var_9_2.ACTIVITY_TYPE_MONOPOLY then
			local var_9_5 = arg_9_0.viewComponent

			var_9_4.UpdateGame(var_9_5, var_9_3)
		end
	else
		GAME = var_9_4

		if var_9_1 == var_9_4.STORY_UPDATE_DONE then
			local var_9_6 = arg_9_0.viewComponent

			var_4.UpdateStory(var_9_6)

			local var_9_7 = arg_9_0.viewComponent
			local var_9_8 = var_4.emit

			BaseUI = var_1_10007

			var_9_8(var_9_7, var_1_10007.ON_ACHIEVE, var_9_3.awards, function()
				return
			end)
		end
	end

	return
end

return var_0_1
