local HeroTeamInfoAttributeArenaView = class("HeroTeamInfoAttributeArenaView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function HeroTeamInfoAttributeArenaView:GetTrialHeroList()
	return AttributeArenaTools.GetTrialHeroList(self.params_.attribute_arena_id)
end

return HeroTeamInfoAttributeArenaView
