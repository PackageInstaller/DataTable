local var_0_0 = class("RedEnvelopeMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_10/SandPlay_3_10/SandPlay_3_10_RedEnvelope/RedEnvelopeMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.items_ = {}
	arg_4_0.btnItems = {}
	arg_4_0.activity_id = RedEnvelopeData:GetActivityId()
	arg_4_0.sub_activity_list = ActivityCfg[arg_4_0.activity_id].sub_activity_list
	arg_4_0.maxDay_ = #arg_4_0.sub_activity_list

	for iter_4_0 = 1, 6 do
		local var_4_0 = RedEnvelopeItemView.New(arg_4_0["itemGo_" .. iter_4_0], iter_4_0)

		arg_4_0.items_[iter_4_0] = var_4_0

		arg_4_0.items_[iter_4_0]:RegisterClickFunc(function(arg_5_0)
			arg_4_0:OnBtnSignClick(arg_5_0)
		end)
	end

	for iter_4_1 = 1, 7 do
		local var_4_1 = RedEnvelopeBtnView.New(arg_4_0["btn_" .. iter_4_1], iter_4_1)

		arg_4_0.btnItems[iter_4_1] = var_4_1
	end

	arg_4_0.onSignHandler = handler(arg_4_0, arg_4_0.OnSignSuccess)
	arg_4_0.onClearHandler = handler(arg_4_0, arg_4_0.OnClearSuccess)
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0 = 1, 7 do
		arg_6_0:AddBtnListener(arg_6_0["btn_" .. iter_6_0], nil, function()
			if arg_6_0.cur_days < iter_6_0 then
				local var_7_0 = ActivitySpringRedEnvelopeCfg[1000 + iter_6_0].sub_activity_id
				local var_7_1 = ActivityData:GetActivityData(var_7_0).startTime

				ShowTips(string.format(GetTips("ACTIVITY_SPRING_RED_ENVELOPE_OPEN_TIPS"), manager.time:GetLostTimeStr(var_7_1)))

				return
			elseif arg_6_0.curSelectDay == iter_6_0 then
				return
			end

			RedEnvelopeData:SetCurSelectDay(iter_6_0)

			arg_6_0.normal_select_day = -1

			arg_6_0:Refresh(iter_6_0)
			arg_6_0:RefreshBtnView(iter_6_0)
		end)
	end
end

function var_0_0.UpdateBar(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		QWorldMgr:GetQWorldPerformMgr():TryClearPerformWithBlackFade(function()
			JumpTools.Back()
		end)
	end)
end

function var_0_0.OnEnter(arg_11_0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_11_0.onClearHandler)
	manager.notify:RegistListener(ACTIVITY_RED_ENVELOPE_SIGN_SUCCESS, arg_11_0.onSignHandler)
	arg_11_0:BindRedPoint()
	arg_11_0:UpdateBar()

	arg_11_0.cur_days = RedEnvelopeData:GetCurDays()

	if arg_11_0.params_.isFirst then
		arg_11_0.normal_select_day = RedEnvelopeData:GetNormalSelectDay()

		RedEnvelopeData:SetCurSelectDay(arg_11_0.normal_select_day)

		arg_11_0.params_.isFirst = false
	end

	if RedEnvelopeData:GetIsResetNormalSelect() then
		arg_11_0.curSelectDay = arg_11_0.normal_select_day > 0 and arg_11_0.normal_select_day or RedEnvelopeData:GetCurSelectDay()
	else
		arg_11_0.curSelectDay = RedEnvelopeData:GetCurSelectDay()
	end

	arg_11_0:Refresh(arg_11_0.curSelectDay)
	arg_11_0:RefreshBtnView(arg_11_0.curSelectDay)
	RedEnvelopeData:SetIsResetNormalSelect(true)
end

function var_0_0.BindRedPoint(arg_12_0)
	for iter_12_0 = 1, #arg_12_0.sub_activity_list do
		manager.redPoint:bindUIandKey(arg_12_0["btn_" .. iter_12_0].transform, RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. arg_12_0.sub_activity_list[iter_12_0])
	end
end

function var_0_0.UnBindRedPoint(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.sub_activity_list do
		manager.redPoint:unbindUIandKey(arg_13_0["btn_" .. iter_13_0].transform, RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. arg_13_0.sub_activity_list[iter_13_0])
	end
end

function var_0_0.RefreshBtnView(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.contentTrs_.localPosition

	if arg_14_1 > 4 then
		arg_14_0.contentTrs_.localPosition = Vector3.New(-564.0015, var_14_0.y, var_14_0.z)
	else
		arg_14_0.contentTrs_.localPosition = Vector3.New(0, var_14_0.y, var_14_0.z)
	end

	local var_14_1 = arg_14_0:IsGetReward(arg_14_1)

	for iter_14_0 = 1, 7 do
		local var_14_2 = arg_14_0:IsGetReward(iter_14_0)

		arg_14_0.btnItems[iter_14_0]:Refresh(arg_14_1, arg_14_0.cur_days, var_14_2)
	end
end

function var_0_0.Refresh(arg_15_0, arg_15_1)
	arg_15_0.curSelectDay = arg_15_1 or 1
	arg_15_0.got_reward = RedEnvelopeData:GetActivityData()

	arg_15_0:RefreshItems(arg_15_0:IsGetReward(arg_15_1))
	arg_15_0:RefreshItemAnim()

	local var_15_0 = arg_15_0.curSelectDay + 1000

	arg_15_0.hero_id = ActivitySpringRedEnvelopeCfg[var_15_0].letter_people
	arg_15_0.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_10/SandPlay_3_10/SandPlay_3_10_RedEnvelope/RedEnvelope_" .. arg_15_0.hero_id)

	SetActive(arg_15_0.talkGo_, false)
	SetActive(arg_15_0.characterGo_, false)
	arg_15_0:RefreshCharacterAnim()
	arg_15_0:RefreshTalkAnim(0.7)

	local var_15_1 = ActivityCfg[arg_15_0.activity_id]

	if var_15_1 then
		arg_15_0.titleText_.text = var_15_1.remark
	end

	arg_15_0:RefreshTimeText()
end

function var_0_0.RefreshCharacterAnim(arg_16_0)
	arg_16_0:StopCharacterAnimTimer()

	arg_16_0.characterAnimTimer_ = Timer.New(function()
		SetActive(arg_16_0.characterGo_, true)
		arg_16_0:StopCharacterAnimTimer()
	end, 0.2, -1)

	arg_16_0.characterAnimTimer_:Start()
end

function var_0_0.StopCharacterAnimTimer(arg_18_0)
	if arg_18_0.characterAnimTimer_ then
		arg_18_0.characterAnimTimer_:Stop()

		arg_18_0.characterAnimTimer_ = nil
	end
end

function var_0_0.RefreshTalkAnim(arg_19_0, arg_19_1)
	arg_19_0:StopTalkAnimTimer()

	arg_19_0.talkAnimTimer_ = Timer.New(function()
		SetActive(arg_19_0.talkGo_, true)

		local var_20_0 = arg_19_0.curSelectDay + 1000

		if arg_19_0:IsGetReward(arg_19_0.curSelectDay) then
			arg_19_0.talkTxt_.text = ActivitySpringRedEnvelopeCfg[var_20_0].letter_content
		else
			arg_19_0.talkTxt_.text = GetTips("ACTIVITY_SPRING_RED_ENVELOPE_CHOOSE_TIPS")
		end

		arg_19_0.talkAnim_:Play("UI_talk_cx")
		arg_19_0.talkAnim_:Update(0)
		arg_19_0:StopTalkAnimTimer()
	end, arg_19_1, -1)

	arg_19_0.talkAnimTimer_:Start()
end

function var_0_0.StopTalkAnimTimer(arg_21_0)
	if arg_21_0.talkAnimTimer_ then
		arg_21_0.talkAnimTimer_:Stop()

		arg_21_0.talkAnimTimer_ = nil
	end
end

function var_0_0.AddTimer(arg_22_0)
	arg_22_0:StopTimer()
	arg_22_0:RefreshTimeText()

	arg_22_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_22_0.stopTime_ then
			return
		end

		arg_22_0:RefreshTimeText()
	end, 1, -1)

	arg_22_0.timer_:Start()
end

function var_0_0.StopTimer(arg_24_0)
	if arg_24_0.timer_ then
		arg_24_0.timer_:Stop()

		arg_24_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeText(arg_25_0)
	arg_25_0.stopTime_ = ActivityData:GetActivityData(arg_25_0.activity_id).stopTime

	if arg_25_0.timeText_ then
		arg_25_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_25_0.stopTime_, true)
	end
end

function var_0_0.IsGetReward(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.got_reward) do
		if arg_26_1 == iter_26_1.id - 1000 then
			return true
		end
	end

	return false
end

function var_0_0.RefreshItems(arg_27_0, arg_27_1)
	for iter_27_0 = 1, 6 do
		arg_27_0.items_[iter_27_0]:RefreshView(arg_27_1, arg_27_0.got_reward)
	end
end

function var_0_0.OnBtnSignClick(arg_28_0, arg_28_1)
	arg_28_0.clickIndex = arg_28_1

	local var_28_0 = ActivitySpringRedEnvelopeCfg[arg_28_0.curSelectDay + 1000].stage_id

	if arg_28_0.activity_id and var_28_0 then
		RedEnvelopeAction.ReqSign(arg_28_0.activity_id, var_28_0, arg_28_0.clickIndex)
	end
end

function var_0_0.BtnDaysNoClick(arg_29_0, arg_29_1)
	for iter_29_0 = 1, 7 do
		arg_29_0["btn_" .. iter_29_0].enabled = arg_29_1
	end
end

function var_0_0.OnSignSuccess(arg_30_0, arg_30_1)
	arg_30_0:BtnDaysNoClick(false)
	manager.windowBar:HideBar()

	arg_30_0.got_reward = RedEnvelopeData:GetActivityData()

	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_0.got_reward) do
		if iter_30_1.id == arg_30_1.id then
			var_30_0 = iter_30_1

			break
		end
	end

	local var_30_1 = var_30_0.hero_reward

	arg_30_0.reward_list = {}

	for iter_30_2, iter_30_3 in pairs(var_30_1) do
		if iter_30_3.hero_id == 1 then
			arg_30_0.reward_list = iter_30_3.reward_list[1]

			break
		end
	end

	local var_30_2 = arg_30_0.curSelectDay + 1000

	arg_30_0.talkAnim_:Play("UI_talk_xs")
	arg_30_0.talkAnim_:Update(0)

	for iter_30_4 = 1, 6 do
		arg_30_0.items_[iter_30_4]:SetData(arg_30_0:IsGetReward(arg_30_0.curSelectDay), arg_30_0.got_reward)
	end

	RedEnvelopeData:SetIsFlipCardAnim(true)
	arg_30_0.items_[arg_30_1.location]:SetStarCtl(1)
	arg_30_0:SetHeadTimer(arg_30_1.location)
end

function var_0_0.SetHeadTimer(arg_31_0, arg_31_1)
	arg_31_0:StopSetHeadTimer()

	arg_31_0.setHeadTimer_ = Timer.New(function()
		for iter_32_0 = 1, #arg_31_0.items_ do
			if iter_32_0 == arg_31_1 then
				arg_31_0.items_[arg_31_1]:SetHeadCtl(0)
			else
				arg_31_0.items_[iter_32_0]:SetHeadCtl(1)
			end
		end

		arg_31_0:StopSetHeadTimer()
		arg_31_0:SetFlipTimer(arg_31_1)
	end, 1, -1)

	arg_31_0.setHeadTimer_:Start()
end

function var_0_0.StopSetHeadTimer(arg_33_0)
	if arg_33_0.setHeadTimer_ then
		arg_33_0.setHeadTimer_:Stop()

		arg_33_0.setHeadTimer_ = nil
	end
end

function var_0_0.OnClearSuccess(arg_34_0)
	arg_34_0.cur_days = RedEnvelopeData:GetCurDays()

	arg_34_0:RefreshBtnView(arg_34_0.curSelectDay)
end

function var_0_0.RefreshItemAnim(arg_35_0, arg_35_1)
	if RedEnvelopeData:GetIsFlipCardAnim() then
		for iter_35_0 = 1, 6 do
			arg_35_0.items_[iter_35_0]:RefreshAnim()
			arg_35_0.items_[iter_35_0]:RefreshMemeIcon(arg_35_1)
		end

		RedEnvelopeData:SetIsFlipCardAnim(false)
	end
end

function var_0_0.SetFlipTimer(arg_36_0, arg_36_1)
	arg_36_0:StopSetFlipTimer()

	arg_36_0.setFlipTimer_ = Timer.New(function()
		arg_36_0:RefreshItemAnim(arg_36_1)
		arg_36_0:RefreshTalkAnim(0.7)
		arg_36_0:StopSetFlipTimer()
		arg_36_0:SetRewardTimer(arg_36_1)
	end, 2, -1)

	arg_36_0.setFlipTimer_:Start()
end

function var_0_0.StopSetFlipTimer(arg_38_0)
	if arg_38_0.setFlipTimer_ then
		arg_38_0.setFlipTimer_:Stop()

		arg_38_0.setFlipTimer_ = nil
	end
end

function var_0_0.SetRewardTimer(arg_39_0, arg_39_1)
	arg_39_0:StopSetRewardTimer()

	local var_39_0 = GameSetting.envelope_rewardpop_times.value[1]

	arg_39_0.setRewardTimer_ = Timer.New(function()
		getReward(formatRewardCfgList({
			arg_39_0.reward_list
		}), nil, function()
			arg_39_0.items_[arg_39_1]:SetGetCtl(1)
			arg_39_0:BtnDaysNoClick(true)
			arg_39_0:UpdateBar()
			arg_39_0:RefreshBtnView(arg_39_0.curSelectDay)
		end)
		arg_39_0:StopSetRewardTimer()
	end, var_39_0, -1)

	arg_39_0.setRewardTimer_:Start()
end

function var_0_0.StopSetRewardTimer(arg_42_0)
	if arg_42_0.setRewardTimer_ then
		arg_42_0.setRewardTimer_:Stop()

		arg_42_0.setRewardTimer_ = nil
	end
end

function var_0_0.OnExit(arg_43_0)
	var_0_0.super.OnExit(arg_43_0)
	arg_43_0:StopTimer()
	arg_43_0:StopSetFlipTimer()
	arg_43_0:StopSetHeadTimer()
	arg_43_0:StopSetRewardTimer()
	arg_43_0:StopTalkAnimTimer()
	arg_43_0:StopCharacterAnimTimer()
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_43_0.onClearHandler)
	manager.notify:RemoveListener(ACTIVITY_RED_ENVELOPE_SIGN_SUCCESS, arg_43_0.onSignHandler)
	arg_43_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	arg_43_0:UnBindRedPoint()
end

function var_0_0.Dispose(arg_44_0)
	arg_44_0:RemoveAllListeners()

	for iter_44_0 = 1, #arg_44_0.items_ do
		arg_44_0.items_[iter_44_0]:Dispose()
	end

	for iter_44_1 = 1, #arg_44_0.btnItems do
		arg_44_0.btnItems[iter_44_1]:Dispose()
	end

	var_0_0.super.Dispose(arg_44_0)
end

return var_0_0
