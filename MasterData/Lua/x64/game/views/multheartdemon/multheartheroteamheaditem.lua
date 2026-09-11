local MultHeartHeroTeamHeadItem = class("MultHeartHeroTeamHeadItem", (import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")))

function MultHeartHeroTeamHeadItem:InitProxy()
	self:BindCfgUI()

	self.sectionLockTypeController_ = self.sectionController_:GetController("sectionLockType")
	self.sectionTeamMarkBgStyleController_ = self.sectionController_:GetController("sectionTeamMarkBgStyle")
	self.sectionEnergyController_ = self.sectionController_:GetController("sectionEnergy")
	self.sectionLockingController_ = self.sectionController_:GetController("sectionLocking")
	self.sectionHPController_ = self.sectionController_:GetController("sectionHP")
	self.multController_ = self.sectionController_:GetController("multSelect")
end

function MultHeartHeroTeamHeadItem:SetMultSelected(arg_2_1)
	self.multController_:SetSelectedState(arg_2_1 and "state0" or "state1")
end

function MultHeartHeroTeamHeadItem:SetInTeamFlag(arg_3_1)
	SetActive(self.sectionTeamMarkGo_, false)

	if self.inTeamIndex then
		SetActive(self.labelGo_, arg_3_1)

		self.labelTxt_.text = self.inTeamIndex
	else
		SetActive(self.labelGo_, false)
	end
end

function MultHeartHeroTeamHeadItem:FindInEditTeam()
	for iter_4_0, iter_4_1 in pairs(self.multData) do
		if iter_4_1.id == self.sectionHeroData_.id and iter_4_1.trialID == self.sectionHeroData_.trialID then
			return iter_4_0
		end
	end
end

function MultHeartHeroTeamHeadItem:SetSectionHeroData(arg_5_1, arg_5_2, arg_5_3)
	self.sectionHeroData_ = arg_5_1
	self.multData = arg_5_3
	self.isBattlePanel_ = true
	self.gameObject_.name = tostring(self.sectionHeroData_.id)

	self:SetProxy(self.sectionHeroData_.heroViewProxy)
	self:SetHeroId(self.sectionHeroData_.id, self.sectionHeroData_.type, self.sectionHeroData_.heroViewProxy.tempHeroList)
	self:SetRedPointEnable(false)
	self:RefreshSectionUI()
	self:UpdateMultiSelected(arg_5_2)
end

function MultHeartHeroTeamHeadItem:UpdateMultiSelected(arg_6_1)
	self.inTeamIndex = self:FindInEditTeam()

	self:SetMultSelected(self.inTeamIndex ~= nil and arg_6_1)
	self:SetInTeamFlag(self.inTeamIndex ~= nil)
end

return MultHeartHeroTeamHeadItem
