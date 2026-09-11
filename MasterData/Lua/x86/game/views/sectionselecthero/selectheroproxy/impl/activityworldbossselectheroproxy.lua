local ActivityWorldBossSelectHeroProxy = class("ActivityWorldBossSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ActivityWorldBossSelectHeroProxy:CustomCheckBeforeBattle()
	if not ActivityData:GetActivityIsOpen(self.activityID) then
		return false, "TIME_OVER"
	end

	return true
end

function ActivityWorldBossSelectHeroProxy:GetStageData()
	return (BattleActivityWorldBossTemplate.New(ActivityWorldBossData:GetStageId(self.activityID), self.activityID))
end

return ActivityWorldBossSelectHeroProxy
