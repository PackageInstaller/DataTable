local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("XH3rdWaterSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.mainActivityID = arg_1_1.mainActivityID
	arg_1_0.needComboSkillPanel = false
	arg_1_0.needMimirPanel = false
	arg_1_0.needPresetReservePanel = false
end

function var_0_1.GetHeroTeamInfoRoute(arg_2_0)
	return "/xH3rdWaterTeamInfo"
end

function var_0_1.GetCustomeTeamInfoParams(arg_3_0, arg_3_1)
	return {
		mainActivityID = arg_3_0.mainActivityID
	}
end

function var_0_1.GetStageData(arg_4_0)
	local var_4_0 = BattleStageFactory.Produce(arg_4_0.stageType_, arg_4_0.stageID_, arg_4_0.activityID)

	var_4_0:SetMainActivityId(arg_4_0.mainActivityID)

	return var_4_0
end

return var_0_1
