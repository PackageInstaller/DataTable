local ActivityRaceTrialSelectHeroProxy = class("ActivityRaceTrialSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ActivityRaceTrialSelectHeroProxy:InitCustomParams(arg_1_1)
	self.activityID_ = arg_1_1.activityID
end

function ActivityRaceTrialSelectHeroProxy:GetRaceEffect()
	return ActivityRaceTrialCfg[self.activityID_].race, 3, true
end

return ActivityRaceTrialSelectHeroProxy
