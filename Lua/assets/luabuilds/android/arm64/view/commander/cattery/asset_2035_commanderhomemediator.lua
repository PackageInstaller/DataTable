local CommanderHomeMediator = class("CommanderHomeMediator", import("...base.ContextMediator"))

CommanderHomeMediator.ON_CLEAN = "CommanderHomeMediator:ON_CLEAN"
CommanderHomeMediator.ON_FEED = "CommanderHomeMediator:ON_FEED"
CommanderHomeMediator.ON_PLAY = "CommanderHomeMediator:ON_PLAY"
CommanderHomeMediator.ON_SEL_COMMANDER = "CommanderHomeMediator:ON_SEL_COMMANDER"
CommanderHomeMediator.ON_CHANGE_STYLE = "CommanderHomeMediator:ON_CHANGE_STYLE"

function CommanderHomeMediator:register()
	self:bind(CommanderHomeMediator.ON_CLEAN, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.COMMANDER_CATTERY_OP, {
			op = 1
		})

		return
	end)
	self:bind(CommanderHomeMediator.ON_FEED, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.COMMANDER_CATTERY_OP, {
			op = 2
		})

		return
	end)
	self:bind(CommanderHomeMediator.ON_PLAY, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.COMMANDER_CATTERY_OP, {
			op = 3
		})

		return
	end)
	self:bind(CommanderHomeMediator.ON_SEL_COMMANDER, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		arg_5_3 = defaultValue(arg_5_3, true)

		self:sendNotification(GAME.PUT_COMMANDER_IN_CATTERY, {
			id = arg_5_1,
			commanderId = arg_5_2,
			tip = arg_5_3,
			callback = arg_5_4
		})

		return
	end)
	self:bind(CommanderHomeMediator.ON_CHANGE_STYLE, function(arg_6_0, arg_6_1, arg_6_2)
		self:sendNotification(GAME.COMMANDER_CHANGE_CATTERY_STYLE, {
			id = arg_6_1,
			styleId = arg_6_2
		})

		return
	end)
	self.viewComponent:SetHome(getProxy(CommanderProxy):GetCommanderHome())

	return
end

function CommanderHomeMediator:listNotificationInterests()
	return {
		GAME.PUT_COMMANDER_IN_CATTERY_DONE,
		GAME.COMMANDER_CHANGE_CATTERY_STYLE_DONE,
		GAME.COMMANDER_CATTERY_OP_DONE,
		GAME.ZERO_HOUR_OP_DONE,
		GAME.CALC_CATTERY_EXP_DONE
	}
end

function CommanderHomeMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.PUT_COMMANDER_IN_CATTERY_DONE then
		self.viewComponent:OnCatteryUpdate(var_8_1.id)
	elseif var_8_0 == GAME.COMMANDER_CHANGE_CATTERY_STYLE_DONE then
		self.viewComponent:OnCatteryStyleUpdate(var_8_1.id)
	elseif var_8_0 == GAME.COMMANDER_CATTERY_OP_DONE then
		self.viewComponent.forbiddenClose = true

		seriesAsync({
			function(arg_9_0)
				self.viewComponent:OnCatteryOPDone()
				self.viewComponent:OnOpAnimtion(var_8_1.cmd, var_8_1.opCatteries, arg_9_0)

				return
			end,
			function(arg_10_0)
				self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards, arg_10_0)

				self.viewComponent.forbiddenClose = false

				return
			end,
			function(arg_11_0)
				self.viewComponent:OnDisplayAwardDone(var_8_1)

				return
			end
		})
	elseif var_8_0 == GAME.ZERO_HOUR_OP_DONE then
		self.viewComponent:OnZeroHour()
	elseif var_8_0 == GAME.CALC_CATTERY_EXP_DONE then
		self.viewComponent:OnCommanderExpChange(var_8_1.commanderExps)
	end

	return
end

return CommanderHomeMediator
