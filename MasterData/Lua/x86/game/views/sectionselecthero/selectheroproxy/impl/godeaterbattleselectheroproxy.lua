local GodEaterBattleSelectHeroProxy = class("GodEaterBattleSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function GodEaterBattleSelectHeroProxy:GetStageData()
	return BattleStageFactory.Produce(self.stageType, self.stageID, {
		viewType = DailyMonsterData:GetBattleType(),
		activityId = self.activityID
	})
end

return GodEaterBattleSelectHeroProxy
