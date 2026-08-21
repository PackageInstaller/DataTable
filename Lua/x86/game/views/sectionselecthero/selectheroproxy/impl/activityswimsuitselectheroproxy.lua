local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("ActivitySwimsuitSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.needComboSkillPanel = false
	arg_1_0.needMimirPanel = false
	arg_1_0.needReserveProposalPanel = false
end

function var_0_1.GetHeroTeamInfoRoute(arg_2_0)
	return "/swimsuitBattleTeamInfo"
end

function var_0_1.CustomGetTeamData(arg_3_0)
	local var_3_0, var_3_1, var_3_2, var_3_3 = ReserveTools.GetHeroList(arg_3_0.reserveParams, true)

	return var_3_0, var_3_1, var_3_2, var_3_3
end

return var_0_1
