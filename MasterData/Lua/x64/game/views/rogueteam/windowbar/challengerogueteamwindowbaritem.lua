local ChallengeRogueTeamWindowBarItem = class("ChallengeRogueTeamWindowBarItem", ReduxView)

function ChallengeRogueTeamWindowBarItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lastAnimatorTime_ = 0
end

function ChallengeRogueTeamWindowBarItem:Dispose()
	self:StopTimer()
	ChallengeRogueTeamWindowBarItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamWindowBarItem:AddListeners()
	self:AddBtnListener(nil, nil, function()
		self:OnClickItem()
	end)
end

function ChallengeRogueTeamWindowBarItem:OnClickItem()
	local var_5_0 = ChallengeRogueTeamData:AttributeGetValue(self.id_)
	local var_5_1

	if self.id_ == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD then
		var_5_1 = ChallengeRogueTeamConst.SETTING_VALUE.GOLD_ITEM_ID
	elseif self.id_ == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT then
		var_5_1 = ChallengeRogueTeamConst.SETTING_VALUE.REVIVE_ITEM_ID
	else
		return
	end

	local var_5_2 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(var_5_1)

	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_POP_ITEM_INFO)
	ShowPopItem(POP_SOURCE_ITEM, {
		var_5_2,
		var_5_0
	})
end

function ChallengeRogueTeamWindowBarItem:SetData(arg_6_1)
	self.id_ = arg_6_1

	self:RefreshUI()

	if self.timer_ == nil then
		SetActive(self.effectGo_, false)
	else
		self.animator_:Update(self.lastAnimatorTime_)
	end

	self:Show(true)
end

function ChallengeRogueTeamWindowBarItem:RefreshUI()
	self:RefreshText()

	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetAttributeIconPath(self.id_))
end

function ChallengeRogueTeamWindowBarItem:RefreshText()
	self.text_.text = ChallengeRogueTeamTools.GetWindowBarText(self.id_)
end

function ChallengeRogueTeamWindowBarItem:PlayAnimator(arg_9_1)
	if (self.id_ == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT and arg_9_1 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT or nil) and true then
		if arg_9_1 ~= ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT then
			if arg_9_1 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT then
				ChallengeRogueTeamData:UISetAttributeValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT, (ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT)))
				ChallengeRogueTeamData:UISetAttributeValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT, (ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT)))

				goto label_9_0
			end
		end

		ChallengeRogueTeamData:UISetAttributeValue(arg_9_1, (ChallengeRogueTeamData:AttributeGetValue(arg_9_1)))

		::label_9_0::

		self:RefreshText()
		self:AddTimer()
	end
end

function ChallengeRogueTeamWindowBarItem:AddTimer()
	self:StopTimer()
	ChallengeRogueTeamData:RemoveServerTriggerQueue()
	self:OverAnimator()
	SetActive(self.effectGo_, true)

	if self.lastAnimatorTime_ > 1 then
		self.lastAnimatorTime_ = 0
	end

	self.animator_:Update(self.lastAnimatorTime_ or 0)

	self.timer_ = FrameTimer.New(function()
		local var_11_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		self:SetAnimatorInfo(var_11_0.normalizedTime)

		if var_11_0.normalizedTime < 1 then
			return
		end

		self:StopTimer()
	end, 1, -1)

	self.timer_:Start()
end

function ChallengeRogueTeamWindowBarItem:StopTimer()
	if self.timer_ then
		SetActive(self.effectGo_, false)
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChallengeRogueTeamWindowBarItem:OverAnimator()
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
end

function ChallengeRogueTeamWindowBarItem:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)

	if arg_14_1 then
		self.animator_:Update(self.lastAnimatorTime_ or 0)
	end
end

function ChallengeRogueTeamWindowBarItem:SetAnimatorInfo(arg_15_1)
	self.lastAnimatorTime_ = self.lastAnimatorTime_ or 0

	if self.lastAnimatorTime_ > 0 and arg_15_1 > self.lastAnimatorTime_ then
		self.lastAnimatorTime_ = arg_15_1
	elseif self.lastAnimatorTime_ > 1 then
		self.lastAnimatorTime_ = arg_15_1
	elseif self.lastAnimatorTime_ == 0 then
		self.lastAnimatorTime_ = arg_15_1
	end
end

return ChallengeRogueTeamWindowBarItem
