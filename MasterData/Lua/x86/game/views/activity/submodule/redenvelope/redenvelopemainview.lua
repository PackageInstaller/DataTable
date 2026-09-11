local RedEnvelopeMainView = class("RedEnvelopeMainView", ReduxView)

function RedEnvelopeMainView:UIName()
	return "Widget/Version/CORGUI_3_10/SandPlay_3_10/SandPlay_3_10_RedEnvelope/RedEnvelopeMainUI"
end

function RedEnvelopeMainView:UIParent()
	return manager.ui.uiMain.transform
end

function RedEnvelopeMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RedEnvelopeMainView:InitUI()
	self:BindCfgUI()

	self.items_ = {}
	self.btnItems = {}
	self.activity_id = RedEnvelopeData:GetActivityId()
	self.sub_activity_list = ActivityCfg[self.activity_id].sub_activity_list
	self.maxDay_ = #self.sub_activity_list

	for iter_4_0 = 1, 6 do
		self.items_[iter_4_0] = RedEnvelopeItemView.New(self["itemGo_" .. iter_4_0], iter_4_0)

		self.items_[iter_4_0]:RegisterClickFunc(function(arg_5_0)
			self:OnBtnSignClick(arg_5_0)
		end)
	end

	for iter_4_1 = 1, 7 do
		self.btnItems[iter_4_1] = RedEnvelopeBtnView.New(self["btn_" .. iter_4_1], iter_4_1)
	end

	self.onSignHandler = handler(self, self.OnSignSuccess)
	self.onClearHandler = handler(self, self.OnClearSuccess)
end

function RedEnvelopeMainView:AddUIListener()
	for iter_6_0 = 1, 7 do
		self:AddBtnListener(self["btn_" .. iter_6_0], nil, function()
			if self.cur_days < iter_6_0 then
				ShowTips(string.format(GetTips("ACTIVITY_SPRING_RED_ENVELOPE_OPEN_TIPS"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivitySpringRedEnvelopeCfg[1000 + iter_6_0].sub_activity_id).startTime)))

				return
			elseif self.curSelectDay == iter_6_0 then
				return
			end

			RedEnvelopeData:SetCurSelectDay(iter_6_0)

			self.normal_select_day = -1

			self:Refresh(iter_6_0)
			self:RefreshBtnView(iter_6_0)
		end)
	end
end

function RedEnvelopeMainView:UpdateBar()
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

function RedEnvelopeMainView:OnEnter()
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(ACTIVITY_RED_ENVELOPE_SIGN_SUCCESS, self.onSignHandler)
	self:BindRedPoint()
	self:UpdateBar()

	self.cur_days = RedEnvelopeData:GetCurDays()

	if self.params_.isFirst then
		self.normal_select_day = RedEnvelopeData:GetNormalSelectDay()

		RedEnvelopeData:SetCurSelectDay(self.normal_select_day)

		self.params_.isFirst = false
	end

	if RedEnvelopeData:GetIsResetNormalSelect() then
		if self.normal_select_day > 0 then
			self.curSelectDay = self.normal_select_day or RedEnvelopeData:GetCurSelectDay()
		end
	else
		self.curSelectDay = RedEnvelopeData:GetCurSelectDay()
	end

	self:Refresh(self.curSelectDay)
	self:RefreshBtnView(self.curSelectDay)
	RedEnvelopeData:SetIsResetNormalSelect(true)
end

function RedEnvelopeMainView:BindRedPoint()
	for iter_12_0 = 1, #self.sub_activity_list do
		manager.redPoint:bindUIandKey(self["btn_" .. iter_12_0].transform, RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. self.sub_activity_list[iter_12_0])
	end
end

function RedEnvelopeMainView:UnBindRedPoint()
	for iter_13_0 = 1, #self.sub_activity_list do
		manager.redPoint:unbindUIandKey(self["btn_" .. iter_13_0].transform, RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. self.sub_activity_list[iter_13_0])
	end
end

function RedEnvelopeMainView:RefreshBtnView(arg_14_1)
	self.contentTrs_.localPosition = arg_14_1 > 4 and Vector3.New(-564.0015, self.contentTrs_.localPosition.y, self.contentTrs_.localPosition.z) or Vector3.New(0, self.contentTrs_.localPosition.y, self.contentTrs_.localPosition.z)

	local var_14_0 = self:IsGetReward(arg_14_1)

	for iter_14_0 = 1, 7 do
		self.btnItems[iter_14_0]:Refresh(arg_14_1, self.cur_days, (self:IsGetReward(iter_14_0)))
	end
end

function RedEnvelopeMainView:Refresh(arg_15_1)
	self.curSelectDay = arg_15_1 or 1
	self.got_reward = RedEnvelopeData:GetActivityData()

	self:RefreshItems(self:IsGetReward(arg_15_1))
	self:RefreshItemAnim()

	self.hero_id = ActivitySpringRedEnvelopeCfg[self.curSelectDay + 1000].letter_people
	self.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_10/SandPlay_3_10/SandPlay_3_10_RedEnvelope/RedEnvelope_" .. self.hero_id)

	SetActive(self.talkGo_, false)
	SetActive(self.characterGo_, false)
	self:RefreshCharacterAnim()
	self:RefreshTalkAnim(0.7)

	if ActivityCfg[self.activity_id] then
		self.titleText_.text = ActivityCfg[self.activity_id].remark
	end

	self:RefreshTimeText()
end

function RedEnvelopeMainView:RefreshCharacterAnim()
	self:StopCharacterAnimTimer()

	self.characterAnimTimer_ = Timer.New(function()
		SetActive(self.characterGo_, true)
		self:StopCharacterAnimTimer()
	end, 0.2, -1)

	self.characterAnimTimer_:Start()
end

function RedEnvelopeMainView:StopCharacterAnimTimer()
	if self.characterAnimTimer_ then
		self.characterAnimTimer_:Stop()

		self.characterAnimTimer_ = nil
	end
end

function RedEnvelopeMainView:RefreshTalkAnim(arg_19_1)
	self:StopTalkAnimTimer()

	self.talkAnimTimer_ = Timer.New(function()
		SetActive(self.talkGo_, true)

		self.talkTxt_.text = self:IsGetReward(self.curSelectDay) and ActivitySpringRedEnvelopeCfg[self.curSelectDay + 1000].letter_content or GetTips("ACTIVITY_SPRING_RED_ENVELOPE_CHOOSE_TIPS")

		self.talkAnim_:Play("UI_talk_cx")
		self.talkAnim_:Update(0)
		self:StopTalkAnimTimer()
	end, arg_19_1, -1)

	self.talkAnimTimer_:Start()
end

function RedEnvelopeMainView:StopTalkAnimTimer()
	if self.talkAnimTimer_ then
		self.talkAnimTimer_:Stop()

		self.talkAnimTimer_ = nil
	end
end

function RedEnvelopeMainView:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function RedEnvelopeMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RedEnvelopeMainView:RefreshTimeText()
	self.stopTime_ = ActivityData:GetActivityData(self.activity_id).stopTime

	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

function RedEnvelopeMainView:IsGetReward(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(self.got_reward) do
		if arg_26_1 == iter_26_1.id - 1000 then
			return true
		end
	end

	return false
end

function RedEnvelopeMainView:RefreshItems(arg_27_1)
	for iter_27_0 = 1, 6 do
		self.items_[iter_27_0]:RefreshView(arg_27_1, self.got_reward)
	end
end

function RedEnvelopeMainView:OnBtnSignClick(arg_28_1)
	self.clickIndex = arg_28_1

	if self.activity_id and ActivitySpringRedEnvelopeCfg[self.curSelectDay + 1000].stage_id then
		RedEnvelopeAction.ReqSign(self.activity_id, ActivitySpringRedEnvelopeCfg[self.curSelectDay + 1000].stage_id, self.clickIndex)
	end
end

function RedEnvelopeMainView:BtnDaysNoClick(arg_29_1)
	for iter_29_0 = 1, 7 do
		self["btn_" .. iter_29_0].enabled = arg_29_1
	end
end

function RedEnvelopeMainView:OnSignSuccess(arg_30_1)
	self:BtnDaysNoClick(false)
	manager.windowBar:HideBar()

	self.got_reward = RedEnvelopeData:GetActivityData()

	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(self.got_reward) do
		if iter_30_1.id == arg_30_1.id then
			var_30_0 = iter_30_1

			break
		end
	end

	self.reward_list = {}

	for iter_30_2, iter_30_3 in pairs(var_30_0.hero_reward) do
		if iter_30_3.hero_id == 1 then
			self.reward_list = iter_30_3.reward_list[1]

			break
		end
	end

	self.talkAnim_:Play("UI_talk_xs")
	self.talkAnim_:Update(0)

	for iter_30_4 = 1, 6 do
		self.items_[iter_30_4]:SetData(self:IsGetReward(self.curSelectDay), self.got_reward)
	end

	RedEnvelopeData:SetIsFlipCardAnim(true)
	self.items_[arg_30_1.location]:SetStarCtl(1)
	self:SetHeadTimer(arg_30_1.location)
end

function RedEnvelopeMainView:SetHeadTimer(arg_31_1)
	self:StopSetHeadTimer()

	self.setHeadTimer_ = Timer.New(function()
		for iter_32_0 = 1, #self.items_ do
			if iter_32_0 == arg_31_1 then
				self.items_[arg_31_1]:SetHeadCtl(0)
			else
				self.items_[iter_32_0]:SetHeadCtl(1)
			end
		end

		self:StopSetHeadTimer()
		self:SetFlipTimer(arg_31_1)
	end, 1, -1)

	self.setHeadTimer_:Start()
end

function RedEnvelopeMainView:StopSetHeadTimer()
	if self.setHeadTimer_ then
		self.setHeadTimer_:Stop()

		self.setHeadTimer_ = nil
	end
end

function RedEnvelopeMainView:OnClearSuccess()
	self.cur_days = RedEnvelopeData:GetCurDays()

	self:RefreshBtnView(self.curSelectDay)
end

function RedEnvelopeMainView:RefreshItemAnim(arg_35_1)
	if RedEnvelopeData:GetIsFlipCardAnim() then
		for iter_35_0 = 1, 6 do
			self.items_[iter_35_0]:RefreshAnim()
			self.items_[iter_35_0]:RefreshMemeIcon(arg_35_1)
		end

		RedEnvelopeData:SetIsFlipCardAnim(false)
	end
end

function RedEnvelopeMainView:SetFlipTimer(arg_36_1)
	self:StopSetFlipTimer()

	self.setFlipTimer_ = Timer.New(function()
		self:RefreshItemAnim(arg_36_1)
		self:RefreshTalkAnim(0.7)
		self:StopSetFlipTimer()
		self:SetRewardTimer(arg_36_1)
	end, 2, -1)

	self.setFlipTimer_:Start()
end

function RedEnvelopeMainView:StopSetFlipTimer()
	if self.setFlipTimer_ then
		self.setFlipTimer_:Stop()

		self.setFlipTimer_ = nil
	end
end

function RedEnvelopeMainView:SetRewardTimer(arg_39_1)
	self:StopSetRewardTimer()

	self.setRewardTimer_ = Timer.New(function()
		getReward(formatRewardCfgList({
			self.reward_list
		}), nil, function()
			self.items_[arg_39_1]:SetGetCtl(1)
			self:BtnDaysNoClick(true)
			self:UpdateBar()
			self:RefreshBtnView(self.curSelectDay)
		end)
		self:StopSetRewardTimer()
	end, GameSetting.envelope_rewardpop_times.value[1], -1)

	self.setRewardTimer_:Start()
end

function RedEnvelopeMainView:StopSetRewardTimer()
	if self.setRewardTimer_ then
		self.setRewardTimer_:Stop()

		self.setRewardTimer_ = nil
	end
end

function RedEnvelopeMainView:OnExit()
	RedEnvelopeMainView.super.OnExit(self)
	self:StopTimer()
	self:StopSetFlipTimer()
	self:StopSetHeadTimer()
	self:StopSetRewardTimer()
	self:StopTalkAnimTimer()
	self:StopCharacterAnimTimer()
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RemoveListener(ACTIVITY_RED_ENVELOPE_SIGN_SUCCESS, self.onSignHandler)
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()
end

function RedEnvelopeMainView:Dispose()
	self:RemoveAllListeners()

	for iter_44_0 = 1, #self.items_ do
		self.items_[iter_44_0]:Dispose()
	end

	for iter_44_1 = 1, #self.btnItems do
		self.btnItems[iter_44_1]:Dispose()
	end

	RedEnvelopeMainView.super.Dispose(self)
end

return RedEnvelopeMainView
