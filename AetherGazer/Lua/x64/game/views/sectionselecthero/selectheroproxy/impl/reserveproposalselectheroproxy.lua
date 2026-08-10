local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("ReserveProposalSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.outerLockHeroList = arg_1_1.outerLockHeroList
end

function var_0_1.SetOuterLockHeroList(arg_2_0, arg_2_1)
	arg_2_0.outerLockHeroList = arg_2_1
end

function var_0_1.GetOuterLockHeroList(arg_3_0)
	return arg_3_0.outerLockHeroList
end

function var_0_1.CustomRefreshHeroInfoList(arg_4_0)
	for iter_4_0 = 1, arg_4_0.heroPosMaxCount do
		local var_4_0 = arg_4_0.heroInfoList[iter_4_0].heroID
		local var_4_1 = arg_4_0.heroInfoList[iter_4_0].trialID
		local var_4_2 = table.indexof(arg_4_0.outerLockHeroList, var_4_0) ~= false or table.indexof(arg_4_0.outerLockHeroList, var_4_1) ~= false

		arg_4_0.heroInfoList[iter_4_0]:SetHeroLock(var_4_2)
	end
end

function var_0_1.CustomSaveTeam(arg_5_0)
	local var_5_0 = arg_5_0:GetHeroIDList()
	local var_5_1 = arg_5_0:GetTrialIDList()

	ReserveTools.SetTeam(arg_5_0.reserveParams, var_5_0, var_5_1, arg_5_0.comboSkillID, arg_5_0.mimirID, arg_5_0.chipList, arg_5_0:GetCharChipBaseID())
end

function var_0_1.GetSelectHeroViewClass(arg_6_0)
	return ReserveProposalSelectHeroView
end

function var_0_1.GetAdditionalViewClass(arg_7_0)
	return ReserveProposalAdditionalView
end

return var_0_1
