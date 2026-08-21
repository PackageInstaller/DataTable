local var_0_0 = class("MainActBossBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_boss"
end

function var_0_0.GetActivityID(arg_2_0)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	return var_2_0 and var_2_0.id
end

function var_0_0.OnInit(arg_3_0)
	setActive(arg_3_0.tipTr.gameObject, (arg_3_0:IsShowTip()))

	return
end

function var_0_0.IsShowTip(arg_4_0)
	local var_4_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)
	local var_4_1 = false

	if var_4_0:checkBattleTimeInBossAct() then
		var_4_1 = var_4_0:readyToAchieve()
	else
		local var_4_2 = getProxy(ActivityProxy):getActivityById((var_4_0:GetBindPtActID()))

		if var_4_2 then
			var_4_1 = ActivityBossPtData.New(var_4_2):CanGetAward()
		end
	end

	return var_4_1
end

function var_0_0.CustomOnClick(arg_5_0)
	arg_5_0:emit(NewMainMediator.GO_SCENE, SCENE.ACT_BOSS_BATTLE, {
		showAni = true
	})

	return
end

return var_0_0
