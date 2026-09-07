local MainActBossBtn = class("MainActBossBtn", import(".MainBaseActivityBtn"))

function MainActBossBtn:GetEventName()
	return "event_boss"
end

function MainActBossBtn:GetActivityID()
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	return var_2_0 and var_2_0.id
end

function MainActBossBtn:OnInit()
	setActive(self.tipTr.gameObject, (self:IsShowTip()))

	return
end

function MainActBossBtn:IsShowTip()
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

function MainActBossBtn:CustomOnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.ACT_BOSS_BATTLE, {
		showAni = true
	})

	return
end

return MainActBossBtn
