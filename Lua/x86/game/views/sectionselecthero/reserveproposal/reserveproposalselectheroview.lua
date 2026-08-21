local var_0_0 = import("game.views.sectionSelectHero.SelectHeroBaseView")
local var_0_1 = class("ReserveProposalSelectHeroView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.isEnter = true

	arg_1_0:ResetUpdatePosFlag()
	arg_1_0:AddEventListener()
	arg_1_0:SubViewOnEnter()
end

function var_0_1.Refresh(arg_2_0)
	return
end

function var_0_1.AddEventListener(arg_3_0)
	var_0_1.super.AddEventListener(arg_3_0)
	arg_3_0:RegistEventListener(COMBO_SKILL_SELECT, arg_3_0.selectComboSkillHandler_)
end

function var_0_1.SetContID(arg_4_0, arg_4_1)
	if SectionSelectHeroScene.GetInstance():IsLoadingModel() then
		return
	end

	arg_4_0.reserveParams_.contID = arg_4_1

	arg_4_0:RefreshHeroTeam()

	if arg_4_0.isEnter then
		SectionSelectHeroScene.GetInstance():SetNeedChangeEffect(false)

		arg_4_0.isEnter = false
	else
		SectionSelectHeroScene.GetInstance():SetNeedChangeEffect(true)
	end

	arg_4_0:LoadHeroModels()
end

function var_0_1.GetHeroInfoItemClass(arg_5_0)
	return SectionSelectHeroInfoItem
end

function var_0_1.GetMimirInfoViewClass(arg_6_0)
	return NewSectionMimirView
end

function var_0_1.GetComboSkillViewClass(arg_7_0)
	return NewSectionComboSkillView
end

return var_0_1
