local ReserveSwimsuitBattleTemplate = class("ReserveSwimsuitBattleTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveSwimsuitBattleTemplate:GetTrialHeroList(arg_1_1)
	return {
		SwimsuitBattleHeroCfg[arg_1_1.customData.activityID].standard_hero_id,
		0,
		0
	}
end

function ReserveSwimsuitBattleTemplate:FillDefaultTeam(arg_2_1, arg_2_2)
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

function ReserveSwimsuitBattleTemplate:GetLockHero(arg_3_1, arg_3_2)
	self.super.GetLockHero(self, arg_3_1, arg_3_2)

	arg_3_2.lockStateList = {
		false,
		true,
		true
	}
end

return ReserveSwimsuitBattleTemplate
