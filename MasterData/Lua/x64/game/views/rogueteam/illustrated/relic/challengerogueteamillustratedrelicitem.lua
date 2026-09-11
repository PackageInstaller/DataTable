local ChallengeRogueTeamBagRelicItem = class("ChallengeRogueTeamBagRelicItem", ReduxView)

function ChallengeRogueTeamBagRelicItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.statusController_ = self.controller_:GetController("status")
	self.selectController_ = self.controller_:GetController("select")
end

function ChallengeRogueTeamBagRelicItem:Dispose()
	ChallengeRogueTeamBagRelicItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamBagRelicItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self.isViewed_ = ChallengeRogueTeamData:IsIllustratedViewd(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, self.id_)
		self.isUnlock_ = ChallengeRogueTeamData:IsIllustratedUnlock(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, self.id_)

		if self.isUnlock_ and not self.isViewed_ then
			ChallengeRogueTeamAction.RequestViewCollectionItem(self.templateID_, {
				self.id_
			}, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC)

			self.isViewed_ = true

			self:RefreshState()
		end

		manager.notify:Invoke(CHALLENGER_ROGUE_TEAM_BAG_RELIC_SELECTED, self.id_)
	end)
end

function ChallengeRogueTeamBagRelicItem:SetData(arg_5_1)
	self.id_ = arg_5_1
	self.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_5_1))
	self.name_.text = RogueTeamItemCfg[arg_5_1].name
	self.isViewed_ = ChallengeRogueTeamData:IsIllustratedViewd(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, self.id_)

	self:RefreshState()
	self:Show(true)
	self.selectController_:SetSelectedState(tostring(self.id_ == self.selectID_))
end

function ChallengeRogueTeamBagRelicItem:SetSelectID(arg_6_1)
	self.selectID_ = arg_6_1

	self.selectController_:SetSelectedState(tostring(self.id_ == arg_6_1))
end

function ChallengeRogueTeamBagRelicItem:RefreshState()
	self.isObtained_ = ChallengeRogueTeamData:IsIllustratedObtained(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, self.id_)
	self.isUnlock_ = ChallengeRogueTeamData:IsIllustratedUnlock(self.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.RELIC, self.id_)

	if self.isObtained_ then
		self.statusController_:SetSelectedState("on")
	elseif self.isUnlock_ then
		self.statusController_:SetSelectedState("gray")
	end

	self.statusController_:SetSelectedState("black")

	self.name_.text = "???"

	manager.redPoint:SetRedPointIndependent(self.transform_, self.isUnlock_ and not self.isViewed_)
end

function ChallengeRogueTeamBagRelicItem:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

return ChallengeRogueTeamBagRelicItem
