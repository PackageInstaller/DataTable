local ReserveProposalSelectHeroProxy = class("ReserveProposalSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function ReserveProposalSelectHeroProxy:InitCustomParams(arg_1_1)
	self.outerLockHeroList = arg_1_1.outerLockHeroList
end

function ReserveProposalSelectHeroProxy:SetOuterLockHeroList(arg_2_1)
	self.outerLockHeroList = arg_2_1
end

function ReserveProposalSelectHeroProxy:GetOuterLockHeroList()
	return self.outerLockHeroList
end

function ReserveProposalSelectHeroProxy:CustomRefreshHeroInfoList()
	for iter_4_0 = 1, self.heroPosMaxCount do
		self.heroInfoList[iter_4_0]:SetHeroLock(table.indexof(self.outerLockHeroList, self.heroInfoList[iter_4_0].heroID) ~= false or table.indexof(self.outerLockHeroList, self.heroInfoList[iter_4_0].trialID) ~= false)
	end
end

function ReserveProposalSelectHeroProxy:CustomSaveTeam()
	ReserveTools.SetTeam(self.reserveParams, self:GetHeroIDList(), self:GetTrialIDList(), self.comboSkillID, self.mimirID, self.chipList, self:GetCharChipBaseID())
end

function ReserveProposalSelectHeroProxy:GetSelectHeroViewClass()
	return ReserveProposalSelectHeroView
end

function ReserveProposalSelectHeroProxy:GetAdditionalViewClass()
	return ReserveProposalAdditionalView
end

return ReserveProposalSelectHeroProxy
