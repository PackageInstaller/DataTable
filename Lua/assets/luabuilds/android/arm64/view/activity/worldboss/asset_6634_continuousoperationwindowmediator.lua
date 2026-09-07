local ContinuousOperationWindowMediator = class("ContinuousOperationWindowMediator", import("view.base.ContextMediator"))

function ContinuousOperationWindowMediator:register()
	self:bind(PreCombatMediator.CONTINUOUS_OPERATION, function(arg_2_0)
		getProxy(SettingsProxy):setActBossExchangeTicketTip(self.contextData.useTicket and 1 or 0)
		self:sendNotification(GAME.AUTO_BOT, {
			isActiveBot = false,
			system = SYSTEM_ACT_BOSS
		})
		getProxy(SettingsProxy):RecordContinuousOperationAutoSubStatus((ys.Battle.BattleState.IsAutoSubActive(SYSTEM_ACT_BOSS)))
		self:sendNotification(GAME.AUTO_SUB, {
			isActiveSub = false,
			system = SYSTEM_ACT_BOSS
		})
		self:sendNotification(PreCombatMediator.CONTINUOUS_OPERATION, {
			mainFleetId = self.contextData.mainFleetId,
			battleTimes = math.min(self.contextData.battleTimes, 15)
		})

		return
	end)
	self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)))

	return
end

function ContinuousOperationWindowMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED
	}
end

function ContinuousOperationWindowMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			self.viewComponent:SetActivity(var_4_1)
		end
	elseif var_4_0 == PlayerProxy.UPDATED then
		self.viewComponent:UpdateContent()
	end

	return
end

function ContinuousOperationWindowMediator:remove()
	return
end

return ContinuousOperationWindowMediator
