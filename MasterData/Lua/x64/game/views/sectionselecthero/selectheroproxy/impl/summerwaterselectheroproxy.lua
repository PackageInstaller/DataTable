local SummerWaterSelectHeroProxy = class("SummerWaterSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function SummerWaterSelectHeroProxy:InitCustomParams(arg_1_1)
	self.mainActivityID = arg_1_1.mainActivityID
	self.needComboSkillPanel = false
	self.needMimirPanel = false
	self.needReserveProposalPanel = false
end

function SummerWaterSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/summerWaterTeamInfo"
end

function SummerWaterSelectHeroProxy:GetStageData()
	local var_3_0 = BattleStageFactory.Produce(self.stageType, self.stageID, self.activityID)

	var_3_0:SetMainActivityId(self.mainActivityID)

	return var_3_0
end

return SummerWaterSelectHeroProxy
