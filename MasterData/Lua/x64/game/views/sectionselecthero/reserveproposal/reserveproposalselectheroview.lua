local ReserveProposalSelectHeroView = class("ReserveProposalSelectHeroView", (import("game.views.sectionSelectHero.SelectHeroBaseView")))

function ReserveProposalSelectHeroView:OnEnter()
	self.isEnter = true

	self:ResetUpdatePosFlag()
	self:AddEventListener()
	self:SubViewOnEnter()
end

function ReserveProposalSelectHeroView:Refresh()
	return
end

function ReserveProposalSelectHeroView:AddEventListener()
	ReserveProposalSelectHeroView.super.AddEventListener(self)
	self:RegistEventListener(COMBO_SKILL_SELECT, self.selectComboSkillHandler_)
end

function ReserveProposalSelectHeroView:SetContID(arg_4_1)
	if SectionSelectHeroScene.GetInstance():IsLoadingModel() then
		return
	end

	self.reserveParams_.contID = arg_4_1

	self:RefreshHeroTeam()

	if self.isEnter then
		SectionSelectHeroScene.GetInstance():SetNeedChangeEffect(false)

		self.isEnter = false
	else
		SectionSelectHeroScene.GetInstance():SetNeedChangeEffect(true)
	end

	self:LoadHeroModels()
end

function ReserveProposalSelectHeroView:GetHeroInfoItemClass()
	return SectionSelectHeroInfoItem
end

function ReserveProposalSelectHeroView:GetMimirInfoViewClass()
	return NewSectionMimirView
end

function ReserveProposalSelectHeroView:GetComboSkillViewClass()
	return NewSectionComboSkillView
end

return ReserveProposalSelectHeroView
