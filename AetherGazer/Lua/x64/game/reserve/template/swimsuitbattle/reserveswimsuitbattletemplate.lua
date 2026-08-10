local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveSwimsuitBattleTemplate", var_0_0)

function var_0_1.GetTrialHeroList(arg_1_0, arg_1_1)
	return {
		SwimsuitBattleHeroCfg[arg_1_1.customData.activityID].standard_hero_id,
		0,
		0
	}
end

function var_0_1.FillDefaultTeam(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2.resultHeroList = {
		SwimsuitBattleHeroCfg[arg_2_1.customData.activityID].hero_id,
		0,
		0
	}
	arg_2_2.lockStateList = {
		false,
		true,
		true
	}
	arg_2_2.lockHeroList = {}
	arg_2_2.resultTrialList = {
		SwimsuitBattleHeroCfg[arg_2_1.customData.activityID].standard_hero_id,
		0,
		0
	}
	arg_2_2.isInVaild = false
end

function var_0_1.GetLockHero(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.super.GetLockHero(arg_3_0, arg_3_1, arg_3_2)

	arg_3_2.lockStateList = {
		false,
		true,
		true
	}
end

return var_0_1
