local ChallengeRogueTeamBagTreasureItem = class("ChallengeRogueTeamBagTreasureItem", ReduxView)

function ChallengeRogueTeamBagTreasureItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controller_:GetController("state")
	self.progressItem_ = {}
	self.progressController_ = {}

	for iter_1_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		self.progressItem_[iter_1_0] = ChallengeRogueTeamCampItem.New(self["scheduleItemGo" .. iter_1_0 .. "_"])
	end
end

function ChallengeRogueTeamBagTreasureItem:Dispose()
	ChallengeRogueTeamBagTreasureItem.super.Dispose(self)

	self.progressController_ = nil
end

function ChallengeRogueTeamBagTreasureItem:AddListeners()
	TerminologyTools.AddTerminologyHandler(self, self.descText_, nil, nil)
end

function ChallengeRogueTeamBagTreasureItem:RefreshUI(arg_4_1)
	self.itemTemp_ = RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp
	self.skillID_ = ChallengeRogueTeamData:GetCampUltimateByCamp(self.itemTemp_, arg_4_1)
	self.cfg_ = RogueTeamItemCfg[self.skillID_]

	if arg_4_1 == 0 then
		if ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
			local var_4_0 = ChallengeRogueTeamTools.GetItemIDByCampID((ChallengeRogueTeamData:SuitSkillGetID()))

			self.cfg_ = RogueTeamItemCfg[var_4_0]
			self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_4_0))
			self.nameText_.text = self.cfg_.name
			self.descText_.text = ChallengeRogueTeamTools.GetItemDesc(var_4_0, nil, self.descText_.color)

			self.stateController_:SetSelectedState("unlock")
		else
			self.stateController_:SetSelectedState("lock")
		end

		return
	end

	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(self.skillID_))
	self.nameText_.text = self.cfg_.name
	self.descText_.text = ChallengeRogueTeamTools.GetItemDesc(self.skillID_, nil, self.descText_.color)

	self:RefreshState()
end

function ChallengeRogueTeamBagTreasureItem:RefreshState()
	local var_5_0 = ChallengeRogueTeamData:TreasureGetListByCampList(self.cfg_.camp)
	local var_5_1 = ChallengeRogueTeamData:GetTreasureIDListByTempAndCampList(self.itemTemp_, self.cfg_.camp)

	if ChallengeRogueTeamData:SuitSkillGetID() ~= 0 and ChallengeRogueTeamData:SuitSkillGetID() ~= self.cfg_.camp[1] then
		self.stateController_:SetSelectedState("hasother")
	elseif ChallengeRogueTeamData:SuitSkillGetID() == self.cfg_.camp[1] then
		self.stateController_:SetSelectedState("unlock")
	else
		self.stateController_:SetSelectedState("progress")
		self:RefeshUnlockState()
	end
end

function ChallengeRogueTeamBagTreasureItem:RefeshUnlockState()
	local var_6_0 = ChallengeRogueTeamData:GetTreasureIDListByTempAndCampList(self.itemTemp_, self.cfg_.camp)
	local var_6_1 = ChallengeRogueTeamData:TreasureGetListByCampList(self.cfg_.camp)

	for iter_6_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		self.progressItem_[iter_6_0]:RefreshState(iter_6_0 <= #var_6_1)
	end
end

return ChallengeRogueTeamBagTreasureItem
