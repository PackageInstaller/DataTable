local SwimsuitBattleTeamInfoView = class("SwimsuitBattleTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function SwimsuitBattleTeamInfoView:GetHeroList()
	if HeroTools.GetHeroIsUnlock(SwimsuitBattleHeroCfg[self.activityID_].hero_id) then
		return {
			SwimsuitBattleHeroCfg[self.activityID_].hero_id
		}
	end

	return {}
end

function SwimsuitBattleTeamInfoView:GetTrialHeroList()
	return {
		SwimsuitBattleHeroCfg[self.activityID_].standard_hero_id
	}
end

return SwimsuitBattleTeamInfoView
