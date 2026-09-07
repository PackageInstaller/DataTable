local MonopolyCar2024Mediator = class("MonopolyCar2024Mediator", import("view.base.ContextMediator"))

MonopolyCar2024Mediator.ON_START = "MonopolyCar2024Mediator:ON_START"
MonopolyCar2024Mediator.ON_MOVE = "MonopolyCar2024Mediator:ON_MOVE"
MonopolyCar2024Mediator.ON_PICK = "MonopolyCar2024Mediator:ON_PICK"
MonopolyCar2024Mediator.ON_DIALOGUE = "MonopolyCar2024Mediator:ON_DIALOGUE"
MonopolyCar2024Mediator.ON_AUTO = "MonopolyCar2024Mediator:ON_AUTO"
MonopolyCar2024Mediator.ON_TRIGGER = "MonopolyCar2024Mediator:ON_TRIGGER"

function MonopolyCar2024Mediator:register()
	self:bind(MonopolyCar2024Mediator.ON_TRIGGER, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0

		if not self.viewComponent.gameUI then
			do return end

			var_2_0 = {
				activity_id = arg_2_1,
				cmd = ActivityConst.MONOPOLY_OP_TRIGGER
			}
		end

		var_2_0.autoFlag = self.viewComponent.gameUI.autoFlag
		var_2_0.awardCollector = self.viewComponent.gameUI.awardCollector
		var_2_0.callback = arg_2_2

		pg.m02:sendNotification(GAME.MONOPOLY_OP, var_2_0)

		return
	end)
	self:bind(MonopolyCar2024Mediator.ON_AUTO, function(arg_3_0, arg_3_1)
		local var_3_0

		if not self.viewComponent.gameUI then
			do return end

			var_3_0 = {
				activity_id = arg_3_1
			}
		end

		var_3_0.autoFlag = self.viewComponent.gameUI.autoFlag
		var_3_0.awardCollector = self.viewComponent.gameUI.awardCollector
		var_3_0.cmd = ActivityConst.MONOPOLY_OP_AUTO

		pg.m02:sendNotification(GAME.MONOPOLY_OP, var_3_0)

		return
	end)
	self:bind(MonopolyCar2024Mediator.ON_PICK, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0

		if not self.viewComponent.gameUI then
			do return end

			var_4_0 = {
				activity_id = arg_4_1,
				arg1 = arg_4_2
			}
		end

		var_4_0.autoFlag = self.viewComponent.gameUI.autoFlag
		var_4_0.awardCollector = self.viewComponent.gameUI.awardCollector
		var_4_0.cmd = ActivityConst.MONOPOLY_OP_PICK
		var_4_0.callback = arg_4_3

		pg.m02:sendNotification(GAME.MONOPOLY_OP, var_4_0)

		return
	end)
	self:bind(MonopolyCar2024Mediator.ON_START, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0

		if not self.viewComponent.gameUI then
			do return end

			var_5_0 = {
				activity_id = arg_5_1
			}
		end

		var_5_0.autoFlag = self.viewComponent.gameUI.autoFlag
		var_5_0.awardCollector = self.viewComponent.gameUI.awardCollector
		var_5_0.cmd = ActivityConst.MONOPOLY_OP_THROW
		var_5_0.callback = arg_5_2

		pg.m02:sendNotification(GAME.MONOPOLY_OP, var_5_0)

		return
	end)
	self:bind(MonopolyCar2024Mediator.ON_MOVE, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0

		if not self.viewComponent.gameUI then
			do return end

			var_6_0 = {
				activity_id = arg_6_1
			}
		end

		var_6_0.autoFlag = self.viewComponent.gameUI.autoFlag
		var_6_0.awardCollector = self.viewComponent.gameUI.awardCollector
		var_6_0.cmd = ActivityConst.MONOPOLY_OP_MOVE
		var_6_0.callback = arg_6_2

		pg.m02:sendNotification(GAME.MONOPOLY_OP, var_6_0)

		return
	end)
	self:bind(MonopolyCar2024Mediator.ON_DIALOGUE, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0

		if not self.viewComponent.gameUI then
			do return end

			var_7_0 = {
				activity_id = arg_7_1
			}
		end

		var_7_0.autoFlag = self.viewComponent.gameUI.autoFlag
		var_7_0.awardCollector = self.viewComponent.gameUI.awardCollector
		var_7_0.cmd = ActivityConst.MONOPOLY_OP_DIALOGUE
		var_7_0.arg1 = arg_7_2

		pg.m02:sendNotification(GAME.MONOPOLY_OP, var_7_0)

		return
	end)

	return
end

function MonopolyCar2024Mediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.STORY_UPDATE_DONE
	}
end

function MonopolyCar2024Mediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_9_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_MONOPOLY then
			self.viewComponent:UpdateGame(var_9_1)
		end
	elseif var_9_0 == GAME.STORY_UPDATE_DONE then
		self.viewComponent:UpdateStory()
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards, function()
			return
		end)
	end

	return
end

return MonopolyCar2024Mediator
