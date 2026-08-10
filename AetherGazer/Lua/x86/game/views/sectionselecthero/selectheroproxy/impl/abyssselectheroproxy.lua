local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("AbyssSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.layer = arg_1_1.layer
	arg_1_0.curActivityID = arg_1_1.curActivityID
	arg_1_0.stageIndex = arg_1_1.stageIndex
end

function var_0_1.CustomCheckBeforeBattle(arg_2_0)
	if arg_2_0.curActivityID ~= AbyssData:GetActivityId() then
		return false, "ERROR_ACTIVITY_NOT_OPEN"
	end

	return true
end

function var_0_1.GetHeroTeamInfoRoute(arg_3_0)
	return "/abyssTeamInfo"
end

function var_0_1.GetCustomeTeamInfoParams(arg_4_0, arg_4_1)
	return {
		layer = arg_4_0.layer
	}
end

function var_0_1.GetStageData(arg_5_0)
	local var_5_0 = AbyssData:GetAbyssCfg(arg_5_0.layer)

	if var_5_0.stage_list[arg_5_0.stageIndex][1] == 3 then
		local var_5_1 = AbyssData:GetStageData(var_5_0.level, arg_5_0.stageIndex).phase or 1

		AbyssData:SetCurrentBossPhase(var_5_1)
	end

	local var_5_2 = {
		activityID = arg_5_0.activityID,
		curActivityID = arg_5_0.curActivityID
	}
	local var_5_3 = BattleStageFactory.Produce(arg_5_0.stageType, arg_5_0.stageID, var_5_2)

	var_5_3:SetStageData(var_5_0.level, arg_5_0.stageIndex)

	return var_5_3
end

return var_0_1
