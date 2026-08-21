local var_0_0 = class("ChallengeRogueTeamCampBox", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.activeCampController_ = arg_1_0.controllerEx_:GetController("activeCamp")
	arg_1_0.treasurePointItemList_ = {}

	for iter_1_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		arg_1_0.treasurePointItemList_[iter_1_0] = ChallengeRogueTeamCampItem.New(arg_1_0[string.format("item%s_", iter_1_0)])
	end
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.treasurePointItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.treasurePointItemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.ShowTreasure(arg_4_0)
	if not ChallengeRogueTeamTools.HasSuitSkillPop() and ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
		arg_4_0:RefreshSuitSkillUI()

		return
	end

	arg_4_0.activeCampController_:SetSelectedState("false")

	local var_4_0 = ChallengeRogueTeamData:UIGetTreasureCampMaxCnt()
	local var_4_1 = ChallengeRogueTeamTools.GetTreasureCmapMaxCnt()
	local var_4_2 = var_4_0 < var_4_1 and var_4_0 or var_4_1

	for iter_4_0 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		arg_4_0.treasurePointItemList_[iter_4_0]:RefreshState(iter_4_0 <= var_4_2)
	end

	if var_4_1 < var_4_0 then
		ChallengeRogueTeamData:UISetTreasureCampMaxCnt(var_4_1)
	end

	arg_4_0.starSlider_.fillAmount = math.max(var_4_2 - 1, 0) / 5

	for iter_4_1, iter_4_2 in ipairs(arg_4_0.treasurePointItemList_) do
		iter_4_2:StopPlayAnimator()
	end

	arg_4_0.treasureEffectAnimator_.enabled = false

	SetActive(arg_4_0.treasureEffectGo_, false)
end

function var_0_0.ShowSuitSkill(arg_5_0)
	arg_5_0.suitSkillAnimator_.enabled = false

	SetActive(arg_5_0.suitSkillEffectGo_, false)

	arg_5_0.treasureEffectAnimator_.enabled = false

	SetActive(arg_5_0.treasureEffectGo_, false)

	if not ChallengeRogueTeamTools.NeedPlaySuitSkillEffectAnimation() then
		arg_5_0:RefreshSuitSkillIcon()

		return
	end

	if ChallengeRogueTeamData:UIGetIsPlaySuitSkillAnimationFlag() == true then
		arg_5_0:RefreshSuitSkillUI()

		return
	end
end

function var_0_0.RefreshTreasure(arg_6_0, arg_6_1)
	if not ChallengeRogueTeamTools.HasSuitSkillPop() and ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
		arg_6_0:RefreshSuitSkillUI()
		arg_6_0:PlayLeftEffect(arg_6_1)

		return
	end

	arg_6_0.activeCampController_:SetSelectedState("false")
	arg_6_0:PlayAllEffect(arg_6_1)
end

function var_0_0.PlayLeftEffect(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.value.itemList[1]
	local var_7_1 = var_7_0.id
	local var_7_2 = RogueTeamItemCfg[var_7_1]

	if var_7_0.operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.value.itemList) do
			ChallengeRogueTeamData:UIRemoveTreasureID(iter_7_1.id)
		end

		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)

		return
	elseif var_7_0.operate == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		for iter_7_2, iter_7_3 in ipairs(arg_7_1.value.itemList) do
			ChallengeRogueTeamData:UIAddTreasureID(iter_7_3.id)
		end

		arg_7_0.isPlaying_ = true

		manager.ui:UIEventEnabled(false)

		arg_7_0.treasureEffectAnimator_.enabled = true

		SetActive(arg_7_0.treasureEffectGo_, true)
		arg_7_0.treasureEffectAnimator_:Play("New Animation", -1, 0)
		arg_7_0:StopTimer()

		arg_7_0.timer_ = FrameTimer.New(function()
			if arg_7_0.treasureEffectAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				ChallengeRogueTeamData:RemoveServerTriggerQueue()
				ChallengeRogueTeamAction.RemovePopWindowCnt()
				manager.ui:UIEventEnabled(true)

				arg_7_0.isPlaying_ = false
				arg_7_0.treasureEffectAnimator_.enabled = false

				SetActive(arg_7_0.treasureEffectGo_, false)
				arg_7_0:StopTimer()
				manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
			end
		end, 1, -1)

		arg_7_0.timer_:Start()
	else
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end
end

function var_0_0.PlayAllEffect(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.value.itemList[1]
	local var_9_1 = var_9_0.id
	local var_9_2 = RogueTeamItemCfg[var_9_1]

	if var_9_0.operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1.value.itemList) do
			ChallengeRogueTeamData:UIRemoveTreasureID(iter_9_1.id)
		end
	else
		for iter_9_2, iter_9_3 in ipairs(arg_9_1.value.itemList) do
			ChallengeRogueTeamData:UIAddTreasureID(iter_9_3.id)
		end
	end

	local var_9_3 = ChallengeRogueTeamData:UIGetTreasureCampMaxCnt()
	local var_9_4 = ChallengeRogueTeamTools.GetTreasureCmapMaxCnt()
	local var_9_5 = var_9_3 < var_9_4 and var_9_3 or var_9_4

	for iter_9_4 = 1, ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT do
		arg_9_0.treasurePointItemList_[iter_9_4]:RefreshState(iter_9_4 <= var_9_5)
	end

	ChallengeRogueTeamData:UISetTreasureCampMaxCnt(var_9_4)

	if var_9_0.operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		arg_9_0.starSlider_.fillAmount = math.max(var_9_5 - 1, 0) / 5

		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)

		return
	else
		if var_9_3 < var_9_4 then
			arg_9_0.isPlaying_ = true

			manager.ui:UIEventEnabled(false)

			arg_9_0.treasureEffectAnimator_.enabled = true

			SetActive(arg_9_0.treasureEffectGo_, true)
			arg_9_0.treasureEffectAnimator_:Play("New Animation", -1, 0)

			local var_9_6 = var_9_3 + 1

			if var_9_4 > ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT then
				var_9_4 = ChallengeRogueTeamConst.SUIT_SKILL_NEED_TREASURE_CNT
			end

			for iter_9_5 = var_9_6, var_9_4 do
				arg_9_0.treasurePointItemList_[iter_9_5]:RefreshState(true)
				arg_9_0.treasurePointItemList_[iter_9_5]:StartPalyAnimator()
			end

			arg_9_0:StopTimer()

			arg_9_0.timer_ = FrameTimer.New(function()
				arg_9_0.starSlider_.fillAmount = math.max(var_9_4 - 1, 0) / 5

				if arg_9_0.treasureEffectAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
					ChallengeRogueTeamData:RemoveServerTriggerQueue()
					ChallengeRogueTeamAction.RemovePopWindowCnt()
					manager.ui:UIEventEnabled(true)

					arg_9_0.isPlaying_ = false
					arg_9_0.treasureEffectAnimator_.enabled = false

					SetActive(arg_9_0.treasureEffectGo_, false)
					arg_9_0:StopTimer()
					manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
				end
			end, 1, -1)

			arg_9_0.timer_:Start()
		else
			arg_9_0.isPlaying_ = true

			manager.ui:UIEventEnabled(false)

			arg_9_0.treasureEffectAnimator_.enabled = true

			SetActive(arg_9_0.treasureEffectGo_, true)
			arg_9_0.treasureEffectAnimator_:Play("New Animation", -1, 0)
			arg_9_0:StopTimer()

			arg_9_0.timer_ = FrameTimer.New(function()
				if arg_9_0.treasureEffectAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
					ChallengeRogueTeamData:RemoveServerTriggerQueue()
					ChallengeRogueTeamAction.RemovePopWindowCnt()
					manager.ui:UIEventEnabled(true)

					arg_9_0.isPlaying_ = false
					arg_9_0.treasureEffectAnimator_.enabled = false

					SetActive(arg_9_0.treasureEffectGo_, false)
					arg_9_0:StopTimer()
					manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
				end
			end, 1, -1)

			arg_9_0.timer_:Start()
		end

		arg_9_0.starSlider_.fillAmount = math.max(var_9_5 - 1, 0) / 5
	end
end

function var_0_0.RefreshSuitSkill(arg_12_0)
	if not ChallengeRogueTeamTools.NeedPlaySuitSkillEffectAnimation() then
		return
	end

	if ChallengeRogueTeamData:UIGetIsPlaySuitSkillAnimationFlag() == true then
		arg_12_0:RefreshSuitSkillUI()

		return
	end

	if arg_12_0.isPlaying_ then
		return
	end

	ChallengeRogueTeamData:UISetIsPlaySuitSkillAnimationFlag(true)

	arg_12_0.suitSkillAnimator_.enabled = true
	arg_12_0.treasureEffectAnimator_.enabled = true

	SetActive(arg_12_0.treasureEffectGo_, true)
	arg_12_0.treasureEffectAnimator_:Play("New Animation", -1, 0)
	arg_12_0:RefreshSuitSkillUI()
	manager.ui:UIEventEnabled(false)

	arg_12_0.isPlaying_ = true

	arg_12_0:StopTimer()

	arg_12_0.timer_ = FrameTimer.New(function()
		if arg_12_0.treasureEffectAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			ChallengeRogueTeamAction.RemovePopWindowCnt()
			manager.ui:UIEventEnabled(true)

			arg_12_0.isPlaying_ = false
			arg_12_0.treasureEffectAnimator_.enabled = false

			SetActive(arg_12_0.treasureEffectGo_, false)
			arg_12_0:StopTimer()
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
		end
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.RefreshSuitSkillUI(arg_14_0)
	arg_14_0.activeCampController_:SetSelectedState("true")
	arg_14_0:RefreshSuitSkillIcon()
end

function var_0_0.RefreshSuitSkillIcon(arg_15_0)
	local var_15_0 = ChallengeRogueTeamData:SuitSkillGetID()

	if var_15_0 ~= 0 then
		local var_15_1 = ChallengeRogueTeamTools.GetItemIDByCampID(var_15_0)

		arg_15_0.suitSkillIcon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_15_1))
	end
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

return var_0_0
