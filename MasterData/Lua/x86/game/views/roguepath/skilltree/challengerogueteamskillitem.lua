local ChallengeRogueTeamSkillItem = class("ChallengeRogueTeamSkillItem", ReduxView)

function ChallengeRogueTeamSkillItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.typeController_ = self.controllerEx_:GetController("type")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.stateController_ = self.controllerEx_:GetController("state")
end

function ChallengeRogueTeamSkillItem:SetData(arg_2_1, arg_2_2, arg_2_3)
	self.skillID_ = arg_2_2
	self.index_ = arg_2_1
	self.clickcCallBack_ = arg_2_3

	self:RefreshUI()
end

function ChallengeRogueTeamSkillItem:SelectorItem(arg_3_1)
	local var_3_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	if self.skillID_ == arg_3_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end

	if ChallengeRogueTeamData:IsHasSkill(var_3_0, self.skillID_) then
		self.stateController_:SetSelectedState("activated")
	elseif ChallengeRogueTeamData:CanSelectSkill(var_3_0, self.skillID_) then
		self.stateController_:SetSelectedState("normal")
	else
		self.stateController_:SetSelectedState("lock")
	end
end

function ChallengeRogueTeamSkillItem:Dispose()
	ChallengeRogueTeamSkillItem.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.transform_, self.skillRedPointStr_)
	Object.Destroy(self.gameObject_)
end

function ChallengeRogueTeamSkillItem:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		self:OnClick()
	end)
end

function ChallengeRogueTeamSkillItem:SetHandler(arg_7_1)
	self.handler_ = arg_7_1
end

function ChallengeRogueTeamSkillItem:RefreshUI()
	self.skillRedPointStr_ = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, self.skillID_)

	manager.redPoint:bindUIandKey(self.transform_, self.skillRedPointStr_)

	local var_8_0 = ChallengeRogueTeamData:GetSkillByLevel(RogueTeamSkillTreeCfg[self.skillID_].level)
	local var_8_1 = ChallengeRogueTeamData:GetCacheTemplateID()

	self.icon_.sprite = pureGetSpriteWithoutAtlas(RogueTeamSkillTreeCfg[self.skillID_].icon)
	self.transform_.localPosition = Vector3(RogueTeamSkillTreeCfg[self.skillID_].level * 400, (table.indexof(var_8_0, self.skillID_) - math.ceil(#var_8_0 / 2)) * 200, 0)

	if RogueTeamSkillTreeCfg[self.skillID_].node_type == 0 then
		self.typeController_:SetSelectedState("small")
	else
		self.typeController_:SetSelectedState("big")
	end

	self:Show(true)
end

function ChallengeRogueTeamSkillItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function ChallengeRogueTeamSkillItem:GetLocalPosition()
	return self.transform_.localPosition
end

function ChallengeRogueTeamSkillItem:OnClick()
	self:Go("challengeRogueTeamSkillInfo", {
		skillID = self.skillID_,
		handler = self.handler_
	})

	if self.clickcCallBack_ then
		self.clickcCallBack_()
	end

	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SELECT_SKILL_ITEM, self.skillID_)
end

function ChallengeRogueTeamSkillItem:IsOpenSectionInfo()
	return self:IsOpenRoute("challengeRogueTeamSkillInfo")
end

return ChallengeRogueTeamSkillItem
