local NewHeroSurpassView = class("NewHeroSurpassView", (import("game.views.pop.PopLevelUpBaseView")))
local var_0_1 = {
	showEx = {
		name = "infoShow",
		skill = "skill",
		attr = "attr"
	}
}

function NewHeroSurpassView:UIName()
	return "Widget/System/Hero_transition/HeroPrintLvUI"
end

function NewHeroSurpassView:UIParent()
	return manager.ui.uiPop.transform
end

function NewHeroSurpassView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewHeroSurpassView:InitUI()
	self:BindCfgUI()

	self.attrInfo = SurpassUpAttrNode.New(self.levelcapbreakthroughGo_)
	self.skillInfo = SurpassUpSkillNode.New(self.skilllevelimprovementGo_)
	self.showController = self.heroprintlvuiControllerexcollection_:GetController(var_0_1.showEx.name)
end

function NewHeroSurpassView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:OnClose()
	end)
end

function NewHeroSurpassView:OnClose()
	if self.exitTimer then
		return
	end

	self.compopui04Ani_:Play("Fx_CompopUI04_xs", 0, 0)

	self.exitTimer = Timer.New(function()
		JumpTools.Back()
	end, 0.467)

	self.exitTimer:Start()
end

function NewHeroSurpassView:OnEnter()
	self:CheckBack()

	self.starID = self.params_.starID
	self.heroID = self.params_.heroID
	self.dataProxy = self.params_.dataProxy

	if self.exitTimer then
		self.exitTimer:Stop()

		self.exitTimer = nil
	end

	self:Refresh()
	manager.audio:PlayEffect("ui_system", "starsup_small", "")
end

function NewHeroSurpassView:Refresh()
	SurpassTools.ChangeIconStarSpirte(self.iconImg_, HeroStarCfg[self.starID].star)

	local var_10_0, var_10_1, var_10_2 = SurpassTools.GetStarUpAttrShowDesc(HeroCfg[self.heroID], self.starID)

	if HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP == var_10_2.type then
		self.showController:SetSelectedState(var_0_1.showEx.attr)
		self.attrInfo:RefreshUi(var_10_2, (self.dataProxy:GetHeroAllAttribute(self.heroID)))
	elseif HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP == var_10_2.type then
		self.showController:SetSelectedState(var_0_1.showEx.skill)
		self.skillInfo:RefreshUi(var_10_0, GetTips("SKILL_LEVEL_UP"))
	else
		self.showController:SetSelectedState(var_0_1.showEx.skill)
		self.skillInfo:RefreshUi({
			var_10_1
		}, GetTips("SPECIAL_SKILL"))
	end

	self.lvText_.text = SurpassTools.GetSmallStageShow(self.starID)
end

function NewHeroSurpassView:OnExit()
	return
end

function NewHeroSurpassView:Dispose()
	if self.exitTimer then
		self.exitTimer:Stop()

		self.exitTimer = nil
	end

	self.attrInfo:Dispose()
	self.skillInfo:Dispose()
	NewHeroSurpassView.super.Dispose(self)
end

return NewHeroSurpassView
