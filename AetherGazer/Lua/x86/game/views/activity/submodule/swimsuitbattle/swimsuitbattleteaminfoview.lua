local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("SwimsuitBattleTeamInfoView", var_0_0)

function var_0_1.GetHeroList(arg_1_0)
	local var_1_0 = SwimsuitBattleHeroCfg[arg_1_0.activityID_].hero_id

	if HeroTools.GetHeroIsUnlock(var_1_0) then
		return {
			var_1_0
		}
	end

	return {}
end

function var_0_1.GetTrialHeroList(arg_2_0)
	return {
		SwimsuitBattleHeroCfg[arg_2_0.activityID_].standard_hero_id
	}
end

return var_0_1
