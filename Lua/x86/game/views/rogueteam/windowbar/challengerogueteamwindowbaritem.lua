local var_0_0 = class("ChallengeRogueTeamWindowBarItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lastAnimatorTime_ = 0
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:StopTimer()
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(nil, nil, function()
		arg_3_0:OnClickItem()
	end)
end

function var_0_0.OnClickItem(arg_5_0)
	local var_5_0 = ChallengeRogueTeamData:AttributeGetValue(arg_5_0.id_)
	local var_5_1

	if arg_5_0.id_ == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD then
		var_5_1 = ChallengeRogueTeamConst.SETTING_VALUE.GOLD_ITEM_ID
	elseif arg_5_0.id_ == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT then
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

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id_ = arg_6_1

	arg_6_0:RefreshUI()

	if arg_6_0.timer_ == nil then
		SetActive(arg_6_0.effectGo_, false)
	else
		arg_6_0.animator_:Update(arg_6_0.lastAnimatorTime_)
	end

	arg_6_0:Show(true)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshText()

	arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetAttributeIconPath(arg_7_0.id_))
end

function var_0_0.RefreshText(arg_8_0)
	local var_8_0 = arg_8_0.id_
	local var_8_1 = ChallengeRogueTeamTools.GetWindowBarText(var_8_0)

	arg_8_0.text_.text = var_8_1
end

function var_0_0.PlayAnimator(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.id_ == arg_9_1

	if arg_9_0.id_ == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT and arg_9_1 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT then
		var_9_0 = true
	end

	if var_9_0 then
		if arg_9_1 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT or arg_9_1 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT then
			local var_9_1 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT)

			ChallengeRogueTeamData:UISetAttributeValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT, var_9_1)

			local var_9_2 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT)

			ChallengeRogueTeamData:UISetAttributeValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT, var_9_2)
		else
			local var_9_3 = ChallengeRogueTeamData:AttributeGetValue(arg_9_1)

			ChallengeRogueTeamData:UISetAttributeValue(arg_9_1, var_9_3)
		end

		arg_9_0:RefreshText()
		arg_9_0:AddTimer()
	end
end

function var_0_0.AddTimer(arg_10_0)
	arg_10_0:StopTimer()
	ChallengeRogueTeamData:RemoveServerTriggerQueue()
	arg_10_0:OverAnimator()
	SetActive(arg_10_0.effectGo_, true)

	if arg_10_0.lastAnimatorTime_ > 1 then
		arg_10_0.lastAnimatorTime_ = 0
	end

	arg_10_0.animator_:Update(arg_10_0.lastAnimatorTime_ or 0)

	arg_10_0.timer_ = FrameTimer.New(function()
		local var_11_0 = arg_10_0.animator_:GetCurrentAnimatorStateInfo(0)

		arg_10_0:SetAnimatorInfo(var_11_0.normalizedTime)

		if var_11_0.normalizedTime < 1 then
			return
		end

		arg_10_0:StopTimer()
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		SetActive(arg_12_0.effectGo_, false)
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.OverAnimator(arg_13_0)
	ChallengeRogueTeamAction.RemovePopWindowCnt()
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)

	if arg_14_1 then
		arg_14_0.animator_:Update(arg_14_0.lastAnimatorTime_ or 0)
	end
end

function var_0_0.SetAnimatorInfo(arg_15_0, arg_15_1)
	arg_15_0.lastAnimatorTime_ = arg_15_0.lastAnimatorTime_ or 0

	if arg_15_0.lastAnimatorTime_ > 0 and arg_15_1 > arg_15_0.lastAnimatorTime_ then
		arg_15_0.lastAnimatorTime_ = arg_15_1
	elseif arg_15_0.lastAnimatorTime_ > 1 then
		arg_15_0.lastAnimatorTime_ = arg_15_1
	elseif arg_15_0.lastAnimatorTime_ == 0 then
		arg_15_0.lastAnimatorTime_ = arg_15_1
	end
end

return var_0_0
