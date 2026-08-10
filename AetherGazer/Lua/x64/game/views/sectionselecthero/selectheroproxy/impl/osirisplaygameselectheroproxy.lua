local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("OsirisPlayGameSelectHeroProxy", var_0_0)

function var_0_1.GetHeroInfoItemClass(arg_1_0)
	return OsirisPlayGameSelectHeroInfoItem
end

function var_0_1.GetAdditionalViewClass(arg_2_0)
	return OsirisPlayGameSectionAdditionalView
end

function var_0_1.GetHeroTeamInfoRoute(arg_3_0)
	return "/osirisPlayGameHeroTeamInfoView"
end

function var_0_1.GetSimilarityClass(arg_4_0)
	return OsirisPlayGameSimilarityView
end

function var_0_1.InitCustomParams(arg_5_0, arg_5_1)
	arg_5_0.canHeroDrag = false
	arg_5_0.needComboSkillPanel = false
	arg_5_0.canChangeComboSkill = false
	arg_5_0.needMimirPanel = false
	arg_5_0.canChangeMimir = false
	arg_5_0.needReserveProposalPanel = false
	arg_5_0.canChangeReserveProposal = false
	arg_5_0.needReorderTeam = false
end

return var_0_1
