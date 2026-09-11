local ActivityHeroEnhanceSelectHeroProxy = class("ActivityHeroEnhanceSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ActivityHeroEnhanceSelectHeroProxy:InitCustomParams(arg_1_1)
	self.needMimirPanel = false
	self.canChangeMimir = false
	self.needPresetReservePanel = false
	self.canChangePresetReserve = false
	self.heroEnhance_CfgID = arg_1_1.heroEnhance_CfgID
end

function ActivityHeroEnhanceSelectHeroProxy:GetCustomeTeamInfoParams(arg_2_1)
	return {
		heroEnhance_CfgID = self.heroEnhance_CfgID
	}
end

function ActivityHeroEnhanceSelectHeroProxy:GetStageData()
	return BattleActivityHeroEnhanceTemplate.New(self.stageID, self.activityID, self.heroEnhance_CfgID)
end

return ActivityHeroEnhanceSelectHeroProxy
