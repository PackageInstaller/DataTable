local ActivityHeroEnhanceTeamInfoView = class("ActivityHeroEnhanceTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function ActivityHeroEnhanceTeamInfoView:GetHeroList()
	return (HeroTools.Sort({
		[ActivityHeroEnhanceCfg[self.params_.heroEnhance_CfgID].hero_id] = HeroData:GetHeroData(ActivityHeroEnhanceCfg[self.params_.heroEnhance_CfgID].hero_id)
	}))
end

return ActivityHeroEnhanceTeamInfoView
