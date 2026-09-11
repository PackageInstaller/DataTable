local ChallengeRogueTeamEntraceDifficultyItem = class("ChallengeRogueTeamEntraceDifficultyItem", ReduxView)

function ChallengeRogueTeamEntraceDifficultyItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.difficultyStateController_ = self.controllerEx_:GetController("icondifficult")
	self.hasAffixController_ = self.controllerEx_:GetController("hasAffix")
	self.isSelectAffixController_ = self.controllerEx_:GetController("selectaffix")
	self.tempVector3_ = Vector3(0, 0, 0)
	self.affixItemList_ = {}
end

function ChallengeRogueTeamEntraceDifficultyItem:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.affixItemList_) do
		iter_2_1:Dispose()
	end

	self.affixItemList_ = nil

	ChallengeRogueTeamEntraceDifficultyItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamEntraceDifficultyItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_DIFFICULTY_SELECT, self.difficultyID_)
	end)
	self:AddBtnListener(self.affixBtn_, nil, function()
		if self.isSelected_ and self.isUnlock_ then
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_DIFFICULTY_AFFIX_CLICK)
		end
	end)
end

function ChallengeRogueTeamEntraceDifficultyItem:SetDifficulty(arg_6_1)
	self.difficultyID_ = arg_6_1

	self:RefreshUI()
end

function ChallengeRogueTeamEntraceDifficultyItem:RefreshUI()
	self.rateText_.text = string.format("x%s%%", RogueTeamDifficultyCfg[self.difficultyID_].score)
	self.difficultyIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Common/com_icondifficulty_%02d", (table.keyof(RogueTeamDifficultyCfg.get_id_list_by_template_id[RogueTeamDifficultyCfg[self.difficultyID_].template_id], self.difficultyID_))))

	local var_7_0 = IsConditionAchieved(RogueTeamDifficultyCfg[self.difficultyID_].unlock_condition)

	self.isUnlock_ = var_7_0

	if not var_7_0 then
		self.lockText_.text = self:GetLockText()
	end

	self.lockController_:SetSelectedState(tostring(not var_7_0))

	if #RogueTeamDifficultyCfg[self.difficultyID_].affix_pool > 0 then
		self.isSelectAffixController_:SetSelectedState("true")

		self.selectAffixText_.text = GetTips("ROUGE_TEAM_OPTIONAL_HARD")
	else
		self.isSelectAffixController_:SetSelectedState("false")
	end

	self:RefreshSelectState(false)
	self:RefreshAffixList()
	SetActive(self.gameObject_, true)
end

function ChallengeRogueTeamEntraceDifficultyItem:SetSelectDifficulty(arg_8_1)
	self:RefreshSelectState(self.difficultyID_ == arg_8_1)
end

function ChallengeRogueTeamEntraceDifficultyItem:RefreshSelectState(arg_9_1)
	self.isSelected_ = arg_9_1

	self.selectController_:SetSelectedState(tostring(arg_9_1))
	self:RefreshDifficultyState(arg_9_1)
end

function ChallengeRogueTeamEntraceDifficultyItem:RefreshDifficultyState(arg_10_1)
	if not self.isUnlock_ then
		self.difficultyStateController_:SetSelectedState("lock")
	elseif arg_10_1 then
		self.difficultyStateController_:SetSelectedState("select01")
	else
		self.difficultyStateController_:SetSelectedState("select02")
	end
end

function ChallengeRogueTeamEntraceDifficultyItem:RefreshAffixList()
	if #RogueTeamDifficultyCfg[self.difficultyID_].affix > 0 then
		for iter_11_0, iter_11_1 in ipairs(RogueTeamDifficultyCfg[self.difficultyID_].affix) do
			self.affixItemList_[iter_11_0] = self.affixItemList_[iter_11_0] or ChallengeRogueTeamEntranceAffixItem.New(self.affixItem_, self.affixParent_)

			self.affixItemList_[iter_11_0]:SetData(iter_11_1)
		end

		self.hasAffixController_:SetSelectedState("true")
	else
		self.hasAffixController_:SetSelectedState("false")
	end
end

function ChallengeRogueTeamEntraceDifficultyItem:GetDifficultyID()
	return self.difficultyID_
end

function ChallengeRogueTeamEntraceDifficultyItem:GetLocalPosition()
	return self.transform_.localPosition
end

function ChallengeRogueTeamEntraceDifficultyItem:GetAffixPool()
	return RogueTeamDifficultyCfg[self.difficultyID_].affix_pool
end

function ChallengeRogueTeamEntraceDifficultyItem:SetChildrenTransform(arg_15_1, arg_15_2, arg_15_3)
	self.childrenTf_.localPosition.x = arg_15_1
	self.childrenTf_.localPosition = self.childrenTf_.localPosition
	self.childrenTf_.localEulerAngles.x = arg_15_3
	self.childrenTf_.localEulerAngles = self.childrenTf_.localEulerAngles
	self.childrenTf_.localScale.x = arg_15_2
	self.childrenTf_.localScale.y = arg_15_2
	self.childrenTf_.localScale = self.childrenTf_.localScale
end

function ChallengeRogueTeamEntraceDifficultyItem:GetIsUnlock()
	return self.isUnlock_
end

function ChallengeRogueTeamEntraceDifficultyItem:GetLockText()
	return ConditionCfg[RogueTeamDifficultyCfg[self.difficultyID_].unlock_condition].desc
end

return ChallengeRogueTeamEntraceDifficultyItem
