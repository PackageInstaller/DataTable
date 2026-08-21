local var_0_0 = class("BossRushContinuousOperationWindowMediator", import("view.activity.worldboss.ContinuousOperationWindowMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(PreCombatMediator.CONTINUOUS_OPERATION, function(arg_2_0)
		arg_1_0:sendNotification(GAME.AUTO_BOT, {
			isActiveBot = false,
			system = SYSTEM_BOSS_RUSH
		})
		getProxy(SettingsProxy):RecordContinuousOperationAutoSubStatus((ys.Battle.BattleState.IsAutoSubActive(SYSTEM_BOSS_RUSH)))
		arg_1_0:sendNotification(GAME.AUTO_SUB, {
			isActiveSub = false,
			system = SYSTEM_BOSS_RUSH
		})
		arg_1_0:sendNotification(BossRushPreCombatMediator.CONTINUOUS_OPERATION, {
			battleTimes = math.min(arg_1_0.contextData.battleTimes, 10)
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			arg_4_0.viewComponent:SetActivity(var_4_1)
		end
	elseif var_4_0 == PlayerProxy.UPDATED then
		arg_4_0.viewComponent:UpdateContent()
	end

	return
end

function var_0_0.remove(arg_5_0)
	return
end

return var_0_0
