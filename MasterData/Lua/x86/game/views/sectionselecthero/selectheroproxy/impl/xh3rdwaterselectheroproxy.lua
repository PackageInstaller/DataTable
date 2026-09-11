local XH3rdWaterSelectHeroProxy = class("XH3rdWaterSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function XH3rdWaterSelectHeroProxy:InitCustomParams(arg_1_1)
	self.mainActivityID = arg_1_1.mainActivityID
	self.needComboSkillPanel = false
	self.needMimirPanel = false
	self.needPresetReservePanel = false
end

function XH3rdWaterSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/xH3rdWaterTeamInfo"
end

function XH3rdWaterSelectHeroProxy:GetCustomeTeamInfoParams(arg_3_1)
	return {
		mainActivityID = self.mainActivityID
	}
end

function XH3rdWaterSelectHeroProxy:GetStageData()
	local var_4_0 = BattleStageFactory.Produce(self.stageType_, self.stageID_, self.activityID)

	var_4_0:SetMainActivityId(self.mainActivityID)

	return var_4_0
end

return XH3rdWaterSelectHeroProxy
