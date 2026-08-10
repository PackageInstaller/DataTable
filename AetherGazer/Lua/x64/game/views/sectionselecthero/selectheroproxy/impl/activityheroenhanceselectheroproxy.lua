local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("ActivityHeroEnhanceSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.needMimirPanel = false
	arg_1_0.canChangeMimir = false
	arg_1_0.needPresetReservePanel = false
	arg_1_0.canChangePresetReserve = false
	arg_1_0.heroEnhance_CfgID = arg_1_1.heroEnhance_CfgID
end

function var_0_1.GetCustomeTeamInfoParams(arg_2_0, arg_2_1)
	return {
		heroEnhance_CfgID = arg_2_0.heroEnhance_CfgID
	}
end

function var_0_1.GetStageData(arg_3_0)
	return BattleActivityHeroEnhanceTemplate.New(arg_3_0.stageID, arg_3_0.activityID, arg_3_0.heroEnhance_CfgID)
end

return var_0_1
