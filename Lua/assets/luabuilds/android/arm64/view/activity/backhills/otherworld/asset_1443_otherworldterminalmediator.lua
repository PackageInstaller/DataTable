local OtherworldTerminalMediator = class("OtherworldTerminalMediator", import("view.base.ContextMediator"))

OtherworldTerminalMediator.ON_GET_PT_ALL_AWARD = "OtherworldTerminalMediator.ON_GET_PT_AWARD"
OtherworldTerminalMediator.ON_BUFF_LIST_CHANGE = "OtherworldTerminalMediator.ON_BUFF_LIST_CHANGE"

function OtherworldTerminalMediator:register()
	self:bind(OtherworldTerminalMediator.ON_GET_PT_ALL_AWARD, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACT_NEW_PT, {
			cmd = 4,
			activity_id = arg_2_1.actId,
			arg1 = arg_2_1.arg1
		})

		return
	end)
	self:bind(OtherworldTerminalMediator.ON_BUFF_LIST_CHANGE, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 3,
			activity_id = arg_3_1.actId,
			arg_list = arg_3_1.ids
		})

		return
	end)

	return
end

function OtherworldTerminalMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.ACT_NEW_PT_DONE
	}
end

function OtherworldTerminalMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1.id == TerminalAdventurePage.BIND_PT_ACT_ID then
			self.viewComponent:UpdateAdventurePtAct(var_5_1)
		elseif var_5_1.id == TerminalAdventurePage.BIND_TASK_ACT_ID then
			self.viewComponent:UpdateAdventureTaskAct(var_5_1)
		elseif var_5_1.id == ActivityConst.OTHER_WORLD_TERMINAL_LOTTERY_ID then
			self.viewComponent:UpdateGuardianAct(var_5_1)
		end
	elseif var_5_0 == GAME.ACT_NEW_PT_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards)
		self.viewComponent:UpdateAdventureTip()
	end

	return
end

return OtherworldTerminalMediator
