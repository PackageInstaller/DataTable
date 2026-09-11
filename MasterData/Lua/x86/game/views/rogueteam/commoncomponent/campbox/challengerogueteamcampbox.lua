local ChallengeRogueTeamCampBox = class("ChallengeRogueTeamCampBox", ReduxView)

function ChallengeRogueTeamCampBox:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.activeCampController_ = self.controllerEx_:GetController("activeCamp")
	self.treasurePointItemList_ = {}

	for iter_1_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		self.treasurePointItemList_[iter_1_0] = ChallengeRogueTeamCampItem.New(self[string.format("item%s_", iter_1_0)])
	end
end

function ChallengeRogueTeamCampBox:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.treasurePointItemList_) do
		iter_2_1:Dispose()
	end

	self.treasurePointItemList_ = nil

	ChallengeRogueTeamCampBox.super.Dispose(self)
end

function ChallengeRogueTeamCampBox:AddListeners()
	return
end

function ChallengeRogueTeamCampBox:ShowTreasure()
	if not ChallengeRogueTeamTools.HasSuitSkillPop() and ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
		self:RefreshSuitSkillUI()

		return
	end

	self.activeCampController_:SetSelectedState("false")

	local var_4_0 = ChallengeRogueTeamData:UIGetTreasureCampMaxCnt()
	local var_4_1 = ChallengeRogueTeamTools.GetTreasureCmapMaxCnt()
	local var_4_2 = var_4_0 < var_4_1 and var_4_0 or var_4_1

	for iter_4_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		self.treasurePointItemList_[iter_4_0]:RefreshState(iter_4_0 <= var_4_2)
	end

	if var_4_1 < var_4_0 then
		ChallengeRogueTeamData:UISetTreasureCampMaxCnt(var_4_1)
	end

	self.starSlider_.fillAmount = math.max(var_4_2 - 1, 0) / 5

	for iter_4_1, iter_4_2 in ipairs(self.treasurePointItemList_) do
		iter_4_2:StopPlayAnimator()
	end

	self.treasureEffectAnimator_.enabled = false

	SetActive(self.treasureEffectGo_, false)
end

function ChallengeRogueTeamCampBox:ShowSuitSkill()
	self.suitSkillAnimator_.enabled = false

	SetActive(self.suitSkillEffectGo_, false)

	self.treasureEffectAnimator_.enabled = false

	SetActive(self.treasureEffectGo_, false)

	if not ChallengeRogueTeamTools.NeedPlaySuitSkillEffectAnimation() then
		self:RefreshSuitSkillIcon()

		return
	end

	if ChallengeRogueTeamData:UIGetIsPlaySuitSkillAnimationFlag() == true then
		self:RefreshSuitSkillUI()

		return
	end
end

function ChallengeRogueTeamCampBox:RefreshTreasure(arg_6_1)
	if not ChallengeRogueTeamTools.HasSuitSkillPop() and ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
		self:RefreshSuitSkillUI()
		self:PlayLeftEffect(arg_6_1)

		return
	end

	self.activeCampController_:SetSelectedState("false")
	self:PlayAllEffect(arg_6_1)
end

function ChallengeRogueTeamCampBox:PlayLeftEffect(arg_7_1)
	if arg_7_1.value.itemList[1].operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.value.itemList) do
			ChallengeRogueTeamData:UIRemoveTreasureID(iter_7_1.id)
		end

		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)

		return
	elseif arg_7_1.value.itemList[1].operate == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		for iter_7_2, iter_7_3 in ipairs(arg_7_1.value.itemList) do
			ChallengeRogueTeamData:UIAddTreasureID(iter_7_3.id)
		end

		self.isPlaying_ = true

		manager.ui:UIEventEnabled(false)

		self.treasureEffectAnimator_.enabled = true

		SetActive(self.treasureEffectGo_, true)
		self.treasureEffectAnimator_:Play("New Animation", -1, 0)
		self:StopTimer()

		self.timer_ = FrameTimer.New(function()
			if self.treasureEffectAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				ChallengeRogueTeamData:RemoveServerTriggerQueue()
				ChallengeRogueTeamAction.RemovePopWindowCnt()
				manager.ui:UIEventEnabled(true)

				self.isPlaying_ = false
				self.treasureEffectAnimator_.enabled = false

				SetActive(self.treasureEffectGo_, false)
				self:StopTimer()
				manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
			end
		end, 1, -1)

		self.timer_:Start()
	else
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end
end

function ChallengeRogueTeamCampBox:PlayAllEffect(arg_9_1)
	local var_9_0 = arg_9_1.value.itemList[1]

	if arg_9_1.value.itemList[1].operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1.value.itemList) do
			ChallengeRogueTeamData:UIRemoveTreasureID(iter_9_1.id)
		end
	else
		for iter_9_2, iter_9_3 in ipairs(arg_9_1.value.itemList) do
			ChallengeRogueTeamData:UIAddTreasureID(iter_9_3.id)
		end
	end

	local var_9_2 = ChallengeRogueTeamData:UIGetTreasureCampMaxCnt()
	local var_9_3 = ChallengeRogueTeamTools.GetTreasureCmapMaxCnt()
	local var_9_4 = var_9_2 < var_9_3 and var_9_2 or var_9_3

	for iter_9_4 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		self.treasurePointItemList_[iter_9_4]:RefreshState(iter_9_4 <= var_9_4)
	end

	ChallengeRogueTeamData:UISetTreasureCampMaxCnt(var_9_3)

	if var_9_0.operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		self.starSlider_.fillAmount = math.max(var_9_4 - 1, 0) / 5

		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)

		return
	else
		if var_9_2 < var_9_3 then
			self.isPlaying_ = true

			manager.ui:UIEventEnabled(false)

			self.treasureEffectAnimator_.enabled = true

			SetActive(self.treasureEffectGo_, true)
			self.treasureEffectAnimator_:Play("New Animation", -1, 0)

			if var_9_3 > ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT then
				var_9_3 = ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT
			end

			for iter_9_5 = var_9_2 + 1, var_9_3 do
				self.treasurePointItemList_[iter_9_5]:RefreshState(true)
				self.treasurePointItemList_[iter_9_5]:StartPalyAnimator()
			end

			self:StopTimer()

			self.timer_ = FrameTimer.New(function()
				self.starSlider_.fillAmount = math.max(var_9_3 - 1, 0) / 5

				if self.treasureEffectAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
					ChallengeRogueTeamData:RemoveServerTriggerQueue()
					ChallengeRogueTeamAction.RemovePopWindowCnt()
					manager.ui:UIEventEnabled(true)

					self.isPlaying_ = false
					self.treasureEffectAnimator_.enabled = false

					SetActive(self.treasureEffectGo_, false)
					self:StopTimer()
					manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
				end
			end, 1, -1)

			self.timer_:Start()
		else
			self.isPlaying_ = true

			manager.ui:UIEventEnabled(false)

			self.treasureEffectAnimator_.enabled = true

			SetActive(self.treasureEffectGo_, true)
			self.treasureEffectAnimator_:Play("New Animation", -1, 0)
			self:StopTimer()

			self.timer_ = FrameTimer.New(function()
				if self.treasureEffectAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
					ChallengeRogueTeamData:RemoveServerTriggerQueue()
					ChallengeRogueTeamAction.RemovePopWindowCnt()
					manager.ui:UIEventEnabled(true)

					self.isPlaying_ = false
					self.treasureEffectAnimator_.enabled = false

					SetActive(self.treasureEffectGo_, false)
					self:StopTimer()
					manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
				end
			end, 1, -1)

			self.timer_:Start()
		end

		self.starSlider_.fillAmount = math.max(var_9_4 - 1, 0) / 5
	end
end

function ChallengeRogueTeamCampBox:RefreshSuitSkill()
	if not ChallengeRogueTeamTools.NeedPlaySuitSkillEffectAnimation() then
		return
	end

	if ChallengeRogueTeamData:UIGetIsPlaySuitSkillAnimationFlag() == true then
		self:RefreshSuitSkillUI()

		return
	end

	if self.isPlaying_ then
		return
	end

	ChallengeRogueTeamData:UISetIsPlaySuitSkillAnimationFlag(true)

	self.suitSkillAnimator_.enabled = true
	self.treasureEffectAnimator_.enabled = true

	SetActive(self.treasureEffectGo_, true)
	self.treasureEffectAnimator_:Play("New Animation", -1, 0)
	self:RefreshSuitSkillUI()
	manager.ui:UIEventEnabled(false)

	self.isPlaying_ = true

	self:StopTimer()

	self.timer_ = FrameTimer.New(function()
		if self.treasureEffectAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			ChallengeRogueTeamAction.RemovePopWindowCnt()
			manager.ui:UIEventEnabled(true)

			self.isPlaying_ = false
			self.treasureEffectAnimator_.enabled = false

			SetActive(self.treasureEffectGo_, false)
			self:StopTimer()
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
		end
	end, 1, -1)

	self.timer_:Start()
end

function ChallengeRogueTeamCampBox:RefreshSuitSkillUI()
	self.activeCampController_:SetSelectedState("true")
	self:RefreshSuitSkillIcon()
end

function ChallengeRogueTeamCampBox:RefreshSuitSkillIcon()
	local var_15_0 = ChallengeRogueTeamData:SuitSkillGetID()

	if var_15_0 ~= 0 then
		self.suitSkillIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon((ChallengeRogueTeamTools.GetItemIDByCampID(var_15_0))))
	end
end

function ChallengeRogueTeamCampBox:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ChallengeRogueTeamCampBox
