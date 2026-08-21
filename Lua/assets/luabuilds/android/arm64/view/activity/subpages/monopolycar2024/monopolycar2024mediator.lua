local var_0_0 = class("MonopolyCar2024Mediator", import("view.base.ContextMediator"))

var_0_0.ON_START = "MonopolyCar2024Mediator:ON_START"
var_0_0.ON_MOVE = "MonopolyCar2024Mediator:ON_MOVE"
var_0_0.ON_PICK = "MonopolyCar2024Mediator:ON_PICK"
var_0_0.ON_DIALOGUE = "MonopolyCar2024Mediator:ON_DIALOGUE"
var_0_0.ON_AUTO = "MonopolyCar2024Mediator:ON_AUTO"
var_0_0.ON_TRIGGER = "MonopolyCar2024Mediator:ON_TRIGGER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TRIGGER, function(arg_2_0, arg_2_1, arg_2_2)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		;({
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER
		}).autoFlag = arg_1_0.viewComponent.gameUI.autoFlag
		;({
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER
		}).awardCollector = arg_1_0.viewComponent.gameUI.awardCollector
		;({
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER
		}).callback = arg_2_2

		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_2_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_AUTO, function(arg_3_0, arg_3_1)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		;({
			activity_id = arg_3_1
		}).autoFlag = arg_1_0.viewComponent.gameUI.autoFlag
		;({
			activity_id = arg_3_1
		}).awardCollector = arg_1_0.viewComponent.gameUI.awardCollector
		;({
			activity_id = arg_3_1
		}).cmd = ActivityConst.MONOPOLY_OP_AUTO

		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_PICK, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		;({
			activity_id = arg_4_1,
			arg1 = arg_4_2
		}).autoFlag = arg_1_0.viewComponent.gameUI.autoFlag
		;({
			activity_id = arg_4_1,
			arg1 = arg_4_2
		}).awardCollector = arg_1_0.viewComponent.gameUI.awardCollector
		;({
			activity_id = arg_4_1,
			arg1 = arg_4_2
		}).cmd = ActivityConst.MONOPOLY_OP_PICK
		;({
			activity_id = arg_4_1,
			arg1 = arg_4_2
		}).callback = arg_4_3

		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			arg1 = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_START, function(arg_5_0, arg_5_1, arg_5_2)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		;({
			activity_id = arg_5_1
		}).autoFlag = arg_1_0.viewComponent.gameUI.autoFlag
		;({
			activity_id = arg_5_1
		}).awardCollector = arg_1_0.viewComponent.gameUI.awardCollector
		;({
			activity_id = arg_5_1
		}).cmd = ActivityConst.MONOPOLY_OP_THROW
		;({
			activity_id = arg_5_1
		}).callback = arg_5_2

		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_MOVE, function(arg_6_0, arg_6_1, arg_6_2)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		;({
			activity_id = arg_6_1
		}).autoFlag = arg_1_0.viewComponent.gameUI.autoFlag
		;({
			activity_id = arg_6_1
		}).awardCollector = arg_1_0.viewComponent.gameUI.awardCollector
		;({
			activity_id = arg_6_1
		}).cmd = ActivityConst.MONOPOLY_OP_MOVE
		;({
			activity_id = arg_6_1
		}).callback = arg_6_2

		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_DIALOGUE, function(arg_7_0, arg_7_1, arg_7_2)
		if not arg_1_0.viewComponent.gameUI then
			return
		end

		;({
			activity_id = arg_7_1
		}).autoFlag = arg_1_0.viewComponent.gameUI.autoFlag
		;({
			activity_id = arg_7_1
		}).awardCollector = arg_1_0.viewComponent.gameUI.awardCollector
		;({
			activity_id = arg_7_1
		}).cmd = ActivityConst.MONOPOLY_OP_DIALOGUE
		;({
			activity_id = arg_7_1
		}).arg1 = arg_7_2

		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_7_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.STORY_UPDATE_DONE
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_9_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_MONOPOLY then
			arg_9_0.viewComponent:UpdateGame(var_9_1)
		end
	elseif var_9_0 == GAME.STORY_UPDATE_DONE then
		arg_9_0.viewComponent:UpdateStory()
		arg_9_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards, function()
			return
		end)
	end

	return
end

return var_0_0
