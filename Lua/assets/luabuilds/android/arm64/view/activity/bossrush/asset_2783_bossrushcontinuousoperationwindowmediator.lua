local BossRushContinuousOperationWindowMediator = class("BossRushContinuousOperationWindowMediator", import("view.activity.worldboss.ContinuousOperationWindowMediator"))

function BossRushContinuousOperationWindowMediator:register()
	self:bind(PreCombatMediator.CONTINUOUS_OPERATION, function(arg_2_0)
		self:sendNotification(GAME.AUTO_BOT, {
			isActiveBot = false,
			system = SYSTEM_BOSS_RUSH
		})
		getProxy(SettingsProxy):RecordContinuousOperationAutoSubStatus((ys.Battle.BattleState.IsAutoSubActive(SYSTEM_BOSS_RUSH)))
		self:sendNotification(GAME.AUTO_SUB, {
			isActiveSub = false,
			system = SYSTEM_BOSS_RUSH
		})
		self:sendNotification(BossRushPreCombatMediator.CONTINUOUS_OPERATION, {
			battleTimes = math.min(self.contextData.battleTimes, 10)
		})

		return
	end)

	return
end

function BossRushContinuousOperationWindowMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED
	}
end

function BossRushContinuousOperationWindowMediator:handleNotification(arg_4_1)
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

function BossRushContinuousOperationWindowMediator:remove()
	return
end

return BossRushContinuousOperationWindowMediator
