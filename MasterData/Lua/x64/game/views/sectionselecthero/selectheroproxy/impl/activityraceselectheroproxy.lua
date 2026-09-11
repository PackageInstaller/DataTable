local ActivityRaceSelectHeroProxy = class("ActivityRaceSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ActivityRaceSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/activityRaceHeroTeamInfo"
end

return ActivityRaceSelectHeroProxy
