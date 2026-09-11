local SlayerSelectHeroProxy = class("SlayerSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function SlayerSelectHeroProxy:InitCustomParams(arg_1_1)
	self.region_activity_id = arg_1_1.region_activity_id
	self.slayer_activity_id = self.activityID
end

function SlayerSelectHeroProxy:CustomCheckBeforeBattle()
	if not ActivityData:GetActivityIsOpen(self.region_activity_id) then
		return false, "TIP_EXPIRED"
	end

	return true
end

function SlayerSelectHeroProxy:GetStageData()
	return BattleStageFactory.Produce(self.stageType, self.region_activity_id, self.slayer_activity_id)
end

return SlayerSelectHeroProxy
