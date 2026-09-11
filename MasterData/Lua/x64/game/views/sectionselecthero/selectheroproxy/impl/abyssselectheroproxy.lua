local AbyssSelectHeroProxy = class("AbyssSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function AbyssSelectHeroProxy:InitCustomParams(arg_1_1)
	self.layer = arg_1_1.layer
	self.curActivityID = arg_1_1.curActivityID
	self.stageIndex = arg_1_1.stageIndex
end

function AbyssSelectHeroProxy:CustomCheckBeforeBattle()
	if self.curActivityID ~= AbyssData:GetActivityId() then
		return false, "ERROR_ACTIVITY_NOT_OPEN"
	end

	return true
end

function AbyssSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/abyssTeamInfo"
end

function AbyssSelectHeroProxy:GetCustomeTeamInfoParams(arg_4_1)
	return {
		layer = self.layer
	}
end

function AbyssSelectHeroProxy:GetStageData()
	local var_5_0 = AbyssData:GetAbyssCfg(self.layer)

	if var_5_0.stage_list[self.stageIndex][1] == 3 then
		AbyssData:SetCurrentBossPhase(AbyssData:GetStageData(var_5_0.level, self.stageIndex).phase or 1)
	end

	local var_5_1 = BattleStageFactory.Produce(self.stageType, self.stageID, {
		activityID = self.activityID,
		curActivityID = self.curActivityID
	})

	var_5_1:SetStageData(var_5_0.level, self.stageIndex)

	return var_5_1
end

return AbyssSelectHeroProxy
