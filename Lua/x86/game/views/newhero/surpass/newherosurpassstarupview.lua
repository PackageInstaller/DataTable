local var_0_0 = import("game.views.pop.PopLevelUpBaseView")
local var_0_1 = class("NewHeroSurpassView", var_0_0)
local var_0_2 = {
	showEx = {
		name = "infoShow",
		skill = "skill",
		attr = "attr"
	}
}

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_transition/HeroPrintLvUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.attrInfo = SurpassUpAttrNode.New(arg_4_0.levelcapbreakthroughGo_)
	arg_4_0.skillInfo = SurpassUpSkillNode.New(arg_4_0.skilllevelimprovementGo_)
	arg_4_0.showController = arg_4_0.heroprintlvuiControllerexcollection_:GetController(var_0_2.showEx.name)
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		arg_5_0:OnClose()
	end)
end

function var_0_1.OnClose(arg_7_0)
	if arg_7_0.exitTimer then
		return
	end

	arg_7_0.compopui04Ani_:Play("Fx_CompopUI04_xs", 0, 0)

	arg_7_0.exitTimer = Timer.New(function()
		JumpTools.Back()
	end, 0.467)

	arg_7_0.exitTimer:Start()
end

function var_0_1.OnEnter(arg_9_0)
	arg_9_0:CheckBack()

	arg_9_0.starID = arg_9_0.params_.starID
	arg_9_0.heroID = arg_9_0.params_.heroID
	arg_9_0.dataProxy = arg_9_0.params_.dataProxy

	if arg_9_0.exitTimer then
		arg_9_0.exitTimer:Stop()

		arg_9_0.exitTimer = nil
	end

	arg_9_0:Refresh()
	manager.audio:PlayEffect("ui_system", "starsup_small", "")
end

function var_0_1.Refresh(arg_10_0)
	local var_10_0 = HeroStarCfg[arg_10_0.starID]
	local var_10_1 = HeroCfg[arg_10_0.heroID]

	SurpassTools.ChangeIconStarSpirte(arg_10_0.iconImg_, var_10_0.star)

	local var_10_2, var_10_3, var_10_4 = SurpassTools.GetStarUpAttrShowDesc(var_10_1, arg_10_0.starID)
	local var_10_5 = ""

	if HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP == var_10_4.type then
		arg_10_0.showController:SetSelectedState(var_0_2.showEx.attr)

		local var_10_6 = arg_10_0.dataProxy:GetHeroAllAttribute(arg_10_0.heroID)

		arg_10_0.attrInfo:RefreshUi(var_10_4, var_10_6)
	elseif HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP == var_10_4.type then
		arg_10_0.showController:SetSelectedState(var_0_2.showEx.skill)
		arg_10_0.skillInfo:RefreshUi(var_10_2, GetTips("SKILL_LEVEL_UP"))
	else
		arg_10_0.showController:SetSelectedState(var_0_2.showEx.skill)
		arg_10_0.skillInfo:RefreshUi({
			var_10_3
		}, GetTips("SPECIAL_SKILL"))
	end

	local var_10_7 = SurpassTools.GetSmallStageShow(arg_10_0.starID)

	arg_10_0.lvText_.text = var_10_7
end

function var_0_1.OnExit(arg_11_0)
	return
end

function var_0_1.Dispose(arg_12_0)
	if arg_12_0.exitTimer then
		arg_12_0.exitTimer:Stop()

		arg_12_0.exitTimer = nil
	end

	arg_12_0.attrInfo:Dispose()
	arg_12_0.skillInfo:Dispose()
	var_0_1.super.Dispose(arg_12_0)
end

return var_0_1
