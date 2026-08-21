local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("SummerWaterSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.mainActivityID = arg_1_1.mainActivityID
	arg_1_0.needComboSkillPanel = false
	arg_1_0.needMimirPanel = false
	arg_1_0.needReserveProposalPanel = false
end

function var_0_1.GetHeroTeamInfoRoute(arg_2_0)
	return "/summerWaterTeamInfo"
end

function var_0_1.GetStageData(arg_3_0)
	local var_3_0 = BattleStageFactory.Produce(arg_3_0.stageType, arg_3_0.stageID, arg_3_0.activityID)

	var_3_0:SetMainActivityId(arg_3_0.mainActivityID)

	return var_3_0
end

return var_0_1
