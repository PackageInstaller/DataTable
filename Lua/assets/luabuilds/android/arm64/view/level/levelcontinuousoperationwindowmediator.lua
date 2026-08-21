local var_0_0 = class("LevelContinuousOperationWindowMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(PreCombatMediator.CONTINUOUS_OPERATION, function(arg_2_0)
		arg_1_0:sendNotification(LevelUIConst.CONTINUOUS_OPERATION, {
			battleTimes = math.min(arg_1_0.contextData.battleTimes, 10)
		})

		return
	end)
	arg_1_0:bind(LevelMediator2.ON_SPITEM_CHANGED, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(LevelMediator2.ON_SPITEM_CHANGED, arg_3_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			arg_5_0.viewComponent:SetActivity(var_5_1)
		end
	elseif var_5_0 == PlayerProxy.UPDATED then
		arg_5_0.viewComponent:UpdateContent()
	end

	return
end

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
