local BossSingleContinuousOperationWindowMediator = class("BossSingleContinuousOperationWindowMediator", import("view.base.ContextMediator"))

function BossSingleContinuousOperationWindowMediator:register()
	self:bind(PreCombatMediator.CONTINUOUS_OPERATION, function(arg_2_0)
		self:sendNotification(GAME.AUTO_BOT, {
			isActiveBot = false,
			system = SYSTEM_BOSS_SINGLE
		})
		getProxy(SettingsProxy):RecordContinuousOperationAutoSubStatus((ys.Battle.BattleState.IsAutoSubActive(SYSTEM_BOSS_SINGLE)))
		self:sendNotification(GAME.AUTO_SUB, {
			isActiveSub = false,
			system = SYSTEM_BOSS_SINGLE
		})
		self:sendNotification(BossSinglePreCombatMediator.CONTINUOUS_OPERATION, {
			mainFleetId = self.contextData.mainFleetId,
			battleTimes = math.min(self.contextData.battleTimes, 15)
		})

		return
	end)

	return
end

function BossSingleContinuousOperationWindowMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED
	}
end

function BossSingleContinuousOperationWindowMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == PlayerProxy.UPDATED then
		self.viewComponent:UpdateContent()
	end

	return
end

function BossSingleContinuousOperationWindowMediator:remove()
	return
end

return BossSingleContinuousOperationWindowMediator
