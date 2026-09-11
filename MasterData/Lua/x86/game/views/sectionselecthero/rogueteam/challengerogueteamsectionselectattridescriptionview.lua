local ChallengeRogueTeamSectionSelectAttriDescriptionView = class("ChallengeRogueTeamSectionSelectAttriDescriptionView", ReduxView)

function ChallengeRogueTeamSectionSelectAttriDescriptionView:UIName()
	return "Widget/System/Formation/ChallengeRogueTeam/ChallengeRogueTeamFormationAttriPopUPUI"
end

function ChallengeRogueTeamSectionSelectAttriDescriptionView:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamSectionSelectAttriDescriptionView:Init()
	self:InitUI()
	self:AddListener()
end

function ChallengeRogueTeamSectionSelectAttriDescriptionView:InitUI()
	self:BindCfgUI()

	self.itemList = {}
end

function ChallengeRogueTeamSectionSelectAttriDescriptionView:AddListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function ChallengeRogueTeamSectionSelectAttriDescriptionView:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.itemList) do
		iter_7_1:Dispose()
	end

	ChallengeRogueTeamSectionSelectAttriDescriptionView.super.Dispose(self)
end

function ChallengeRogueTeamSectionSelectAttriDescriptionView:OnEnter()
	self.heroList_ = self.params_.heroList
	self.attriDic_ = {}

	for iter_8_0, iter_8_1 in ipairs(self.heroList_) do
		if HeroCfg[iter_8_1] then
			self.attriDic_[HeroCfg[iter_8_1].ATK_attribute[1]] = self.attriDic_[HeroCfg[iter_8_1].ATK_attribute[1]] or 0
			self.attriDic_[HeroCfg[iter_8_1].ATK_attribute[1]] = self.attriDic_[HeroCfg[iter_8_1].ATK_attribute[1]] + 1
		end
	end

	self.attriIDList_ = ChallengeRogueTeamData:GetAttriIDList()

	local var_8_0 = ChallengeRogueTeamTools.HasTeamEffectMaxLevel()

	for iter_8_2, iter_8_3 in ipairs(self.attriIDList_) do
		if not self.itemList[iter_8_2] then
			local var_8_1 = Object.Instantiate(self.godlistnewGo_, self.contentTrs_)

			SetActive(var_8_1, true)

			self.itemList[iter_8_2] = self:GetItemClass().New(var_8_1)
		end

		self.itemList[iter_8_2]:SetData(iter_8_2, self.attriIDList_[iter_8_2], (self.attriDic_[self.attriIDList_[iter_8_2]] and var_8_0 or nil) and 3)
	end
end

function ChallengeRogueTeamSectionSelectAttriDescriptionView:GetItemClass()
	return ChallengeRogueTeamSectionSelectAttriDescriptionItem
end

return ChallengeRogueTeamSectionSelectAttriDescriptionView
