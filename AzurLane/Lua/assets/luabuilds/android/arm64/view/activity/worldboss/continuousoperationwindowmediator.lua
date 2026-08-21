local var_0_0 = class("ContinuousOperationWindowMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(PreCombatMediator.CONTINUOUS_OPERATION, function(arg_2_0)
		getProxy(SettingsProxy):setActBossExchangeTicketTip(arg_1_0.contextData.useTicket and 1 or 0)
		arg_1_0:sendNotification(GAME.AUTO_BOT, {
			isActiveBot = false,
			system = SYSTEM_ACT_BOSS
		})
		getProxy(SettingsProxy):RecordContinuousOperationAutoSubStatus((ys.Battle.BattleState.IsAutoSubActive(SYSTEM_ACT_BOSS)))
		arg_1_0:sendNotification(GAME.AUTO_SUB, {
			isActiveSub = false,
			system = SYSTEM_ACT_BOSS
		})
		arg_1_0:sendNotification(PreCombatMediator.CONTINUOUS_OPERATION, {
			mainFleetId = arg_1_0.contextData.mainFleetId,
			battleTimes = math.min(arg_1_0.contextData.battleTimes, 15)
		})

		return
	end)
	arg_1_0.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)))

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
