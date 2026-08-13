class = var_0_10000

local var_0_0 = "MainActBossBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_boss"
end

function var_0_1.GetActivityID(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	return var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2) and var_1.id
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0:IsShowTip()

	setActive = var_1_10002

	var_1_10002(arg_3_0.tipTr.gameObject, var_3_0)

	return
end

function var_0_1.IsShowTip(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_4_2 = var_4_1(var_4_0, var_1_10004.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)
	local var_4_3 = false
	local var_4_4 = var_4_2

	if var_4_2.checkBattleTimeInBossAct(var_4_4) then
		var_4_3 = var_4_2:readyToAchieve()
	else
		local var_4_5 = var_4_2
		local var_4_6 = var_4_2.GetBindPtActID(var_4_5)

		getProxy = var_4_4
		ActivityProxy = var_1_10007

		local var_4_7 = var_4_4(var_1_10007)

		if var_5.getActivityById(var_4_7, var_4_6) then
			ActivityBossPtData = var_4_5

			local var_4_8 = var_4_5.New(var_5)

			var_4_3 = var_6.CanGetAward(var_4_8)
		end
	end

	return var_4_3
end

function var_0_1.CustomOnClick(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.emit

	NewMainMediator = var_1_10004

	local var_5_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_5_1(var_5_0, var_5_2, var_1_10005.ACT_BOSS_BATTLE, {
		showAni = true
	})

	return
end

return var_0_1
