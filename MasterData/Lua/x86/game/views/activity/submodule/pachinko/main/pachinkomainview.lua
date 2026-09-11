local PaChinKoMainView = class("PaChinKoMainView", ReduxView)

PaChinKoMainView.MODEL_STATE = {
	PRIZE = 3,
	INTERACTIVE = 2,
	IDLE = 1,
	OVER = 4
}

function PaChinKoMainView:UIName()
	return PaChinKoTools.GetMainUIName(self.params_.mainActivityID)
end

function PaChinKoMainView:UIParent()
	return manager.ui.uiMain.transform
end

function PaChinKoMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.showBubbleController_ = self.uiControllerEx_:GetController("showBubble")
	self.showMailController_ = self.uiControllerEx_:GetController("showMail")
	self.btnController_ = self.uiSendControllerEx_:GetController("btn")
	self.enoughController_ = self.uiSendControllerEx_:GetController("enough")
	self.rewardViewList_ = {}

	for iter_3_0 = 1, 3 do
		self.rewardViewList_[iter_3_0] = PaChinKoMainRewardList.New(self[string.format("uiRewardList%s_", iter_3_0)], iter_3_0)
	end

	self.paChinKoMainTriggerBox_ = PaChinKoMainTriggerBox.New(self.uiTriggerGo_)
	self.onFinishPachinkoHanlder_ = handler(self, self.OnFinishPachinko)
	self.paChinKoControllerCom_ = self.uiPlayContentGo_:GetComponent(typeof(pachinko.PaChinKoController))

	self:LoadModel()
end

function PaChinKoMainView:OnEnter()
	manager.ui:SetMainCamera("null")
	manager.ui:SetMainCameraPos(Vector3.zero)
	manager.ui:SetMainCameraRot(Vector3.zero)

	self.activityID_ = self.params_.mainActivityID

	SetActive(self.paChinKoControllerCom_.m_ballGo, false)

	self.readyLaunchFlag_ = true
	self.skipLaunch_ = getData("paChinKo", "skipLaunch" .. self.activityID_) or false
	self.uiSkipLaunchToggle_.isOn = self.skipLaunch_

	local var_4_0 = PaChinKoTools.GetCurrencyID(self.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_4_0
	})
	manager.windowBar:SetBarCanClick(var_4_0, true)

	for iter_4_0, iter_4_1 in ipairs(self.rewardViewList_) do
		iter_4_1:OnEnter(self.activityID_)
	end

	self.uiIcon_.sprite = ItemTools.getItemLittleSprite(var_4_0)
	self.uiNoticeText_.text = ""

	self.paChinKoMainTriggerBox_:RefreshTrigger(self.activityID_)
	self:RefreshUI()
	self:AddRandomTimer()
	self:AddRandomBubbleTimer()
	manager.notify:RegistListener(PACHINKO_FINISH, self.onFinishPachinkoHanlder_)
	SetActive(self.heroModel_, true)
	self:PlayModelAnimation(PaChinKoMainView.MODEL_STATE.IDLE)
	SetActive(self.uiBubbleGo_, false)

	self.playing_ = false

	for iter_4_2 = 1, 3 do
		SetActive(self[string.format("rewardEffectGo%s_", iter_4_2)], false)
	end

	SetActive(self.getAllRewardEffectGo_, false)

	if not PaChinKoTools.IsGetAllReward(self.activityID_) and ItemTools.getItemNum(var_4_0) > 0 then
		SetActive(self.uiBallGo_, true)
	else
		SetActive(self.uiBallGo_, false)
	end

	manager.redPoint:bindUIandKey(self.uiSendBtn_.transform, RedPointConst.ACTIVITY_PACHINKO .. "_" .. self.activityID_)

	local var_4_1 = PaChinKoMainView.GetUICam()

	self.heroModelTf_.localPosition = Vector3(var_4_1.x, PaChinKoUICfg[PaChinKoUICfg.get_id_list_by_activity_id[self.activityID_][1]].posY, manager.ui.mainCameraCom_:ScreenToWorldPoint(var_4_1:WorldToScreenPoint(self.uiTouchBtn_.transform.position) - Vector3(0, self.uiTouchBtn_.transform.rect.height / 2, 0)).z)
	self.uiBg1_.transform.parent = nil
	self.uiBg1_.transform.localPosition = manager.ui.mainCameraCom_:ScreenToWorldPoint((PaChinKoMainView.GetUICam():WorldToScreenPoint(self.transform_.position - Vector3(0, 0, -2))))
	self.uiBg1_.transform.localScale = Vector3(0.5, 0.5, 1)

	SetActive(self.uiBg1_, true)
end

function PaChinKoMainView:OnExit()
	SetActive(self.uiBg1_, false)
	manager.redPoint:unbindUIandKey(self.uiSendBtn_.transform, RedPointConst.ACTIVITY_PACHINKO .. "_" .. self.activityID_)
	SetActive(self.heroModel_, false)
	self:StopRandomTimer()
	self:StopBubbleTimer()
	self:StopAnimatorTimer()
	self:StopRandomBubbleTimer()
	self:StopRewardEffectTimer()
	self:StopLaunchTimer()
	manager.notify:RemoveListener(PACHINKO_FINISH, self.onFinishPachinkoHanlder_)
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in ipairs(self.rewardViewList_) do
		iter_5_1:OnExit()
	end
end

function PaChinKoMainView:Dispose()
	self:DestroyModel()
	Object.Destroy(self.uiBg1_)

	self.uiBg1_ = nil
	self.onFinishPachinkoHanlder_ = nil

	self.paChinKoMainTriggerBox_:Dispose()

	self.paChinKoMainTriggerBox_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.rewardViewList_) do
		iter_6_1:Dispose()
	end

	self.rewardViewList_ = nil

	PaChinKoMainView.super.Dispose(self)
end

function PaChinKoMainView:AddListeners()
	self:AddBtnListener(self.uiMailBtn_, nil, function()
		JumpTools.OpenPageByJump("paChinKoPop")
	end)
	self:AddBtnListener(self.uiTouchBtn_, nil, function()
		self:OnClickModel()
	end)
	self:AddBtnListener(self.uiSendBtn_, nil, function()
		if self.readyLaunchFlag_ == false then
			return
		end

		local var_10_0 = PaChinKoTools.GetCurrencyID(self.activityID_)

		if ItemTools.getItemNum(var_10_0) <= 0 then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[var_10_0].name)))

			return
		end

		self.readyLaunchFlag_ = false

		if self.skipLaunch_ then
			self:SendResult(0)
		else
			self:AddLaunchTimer()
		end
	end)
	self:AddToggleListener(self.uiSkipLaunchToggle_, function(arg_11_0)
		self.skipLaunch_ = arg_11_0

		saveData("paChinKo", "skipLaunch" .. self.activityID_, arg_11_0)
	end)
end

function PaChinKoMainView:RefreshUI()
	self:RefreshBtnState()

	for iter_12_0, iter_12_1 in ipairs(self.rewardViewList_) do
		iter_12_1:RefreshUI()
	end

	self.paChinKoMainTriggerBox_:RefreshUI()

	if PaChinKoTools.IsClearLevelPrize(self.activityID_, 1) then
		self.showMailController_:SetSelectedState("true")
	else
		self.showMailController_:SetSelectedState("false")
	end

	if ItemTools.getItemNum((PaChinKoTools.GetCurrencyID(self.activityID_))) > 0 then
		self.enoughController_:SetSelectedState("true")
	else
		self.enoughController_:SetSelectedState("false")
	end

	self.launchAnimator_:Play("New State", -1, 0)
end

function PaChinKoMainView:OnFinishPachinko(arg_13_1)
	Timer.New(function()
		SetActive(self.paChinKoControllerCom_.m_ballGo, false)
		self:SendResult(arg_13_1)
	end, 0.5, 1):Start()
end

function PaChinKoMainView:SendResult(arg_15_1)
	PaChinKoAction.SendTriggerLevel(self.activityID_, arg_15_1, function(arg_16_0)
		manager.ui:UIEventEnabled(true)

		local var_16_0 = PaChinKoSignCfg[arg_16_0].reward
		local var_16_1 = PaChinKoSignCfg[arg_16_0].level
		local var_16_2 = PaChinKoTools.IsGetAllReward(self.activityID_)

		if arg_15_1 == 0 then
			self.paChinKoMainTriggerBox_:PlayEffect(PaChinKoSignCfg[arg_16_0].level)
		end

		local function var_16_3()
			if var_16_2 then
				SetActive(self.getAllRewardEffectGo_, false)
			end

			getReward(formatRewardCfgList({
				var_16_0
			}), nil, function()
				self:RefreshUI()

				self.readyLaunchFlag_ = true

				self:RefreshRewardText(arg_16_0)

				local var_18_0 = PaChinKoTools.IsClearLevelPrize(self.activityID_, var_16_1)

				if not var_16_2 and var_18_0 then
					ShowTips(string.format(GetTips("PACHINKO_LEVEL_CLEAR_TIPS"), (GetTips(string.format("PACHINKO_LEVEL_REWARD_%s", var_16_1)))))
				end

				if var_18_0 then
					SetActive(self[string.format("rewardEffectGo%s_", var_16_1)], true)
				end

				if var_16_1 == 1 then
					self:AddRewardEffectTimer()
				end

				if not var_16_2 and ItemTools.getItemNum((PaChinKoTools.GetCurrencyID(self.activityID_))) > 0 then
					SetActive(self.uiBallGo_, true)
				end

				self:AddRandomTimer()
			end)
		end

		if var_16_2 then
			self:PlayModelAnimation(PaChinKoMainView.MODEL_STATE.OVER, var_16_3)
			self:PlayModelBubble(PaChinKoMainView.MODEL_STATE.OVER)
		else
			self:PlayModelAnimation(PaChinKoMainView.MODEL_STATE.PRIZE, var_16_3)
			self:PlayModelBubble(PaChinKoMainView.MODEL_STATE.PRIZE, PaChinKoSignCfg[arg_16_0].level)
		end
	end)
end

function PaChinKoMainView:RefreshBtnState()
	if PaChinKoTools.IsGetAllReward(self.activityID_) then
		self.btnController_:SetSelectedState("clear")
	else
		self.btnController_:SetSelectedState("normal")
	end
end

function PaChinKoMainView:RefreshRewardText(arg_20_1)
	self.uiNoticeText_.text = string.format(GetTips(PaChinKoConst.LEVEL_TITLE_TEXT[PaChinKoSignCfg[arg_20_1].level]), PlayerData:GetPlayerInfo().nick, PaChinKoSignCfg[arg_20_1].reward_name)

	self:ScrollText()
end

function PaChinKoMainView:RandomRewardText()
	local var_21_0 = PaChinKoTextCfg[PaChinKoTextCfg.get_id_list_by_type[2][math.random(1, #PaChinKoTextCfg.get_id_list_by_type[2])]]

	self.uiNoticeText_.text = string.format(GetTips("PACHINKO_RANDOM_CONGRATS"), var_21_0.hero, var_21_0.prize)

	self:ScrollText()
end

function PaChinKoMainView:ScrollText()
	self.uiNoticeTf_.localPosition = Vector3.New(500, self.uiNoticeTf_.localPosition.y, 0)

	self:RemoveTween()

	self.tween_ = LeanTween.moveLocalX(self.uiNoticeTf_.gameObject, (self.uiScollTextParent_.sizeDelta.x + self.uiNoticeTf_.sizeDelta.x) * -1, (self.uiScollTextParent_.sizeDelta.x + self.uiNoticeTf_.sizeDelta.x) * -1 / -200):setOnComplete(LuaHelper.VoidAction(function()
		self:RemoveTween()
	end))
end

function PaChinKoMainView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnComplete(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function PaChinKoMainView:AddRandomTimer()
	self:StopRandomTimer()

	self.randomTimer_ = Timer.New(function()
		if math.random(0, 99) > 50 then
			self:RandomRewardText()
		end

		self:AddRandomTimer()
	end, 7, 1)

	self.randomTimer_:Start()
end

function PaChinKoMainView:StopRandomTimer()
	if self.randomTimer_ then
		self.randomTimer_:Stop()

		self.randomTimer_ = nil
	end
end

function PaChinKoMainView:AddRandomBubbleTimer()
	self:StopRandomBubbleTimer()

	self.randomBubbleTimer_ = Timer.New(function()
		self:StopRandomBubbleTimer()
		self:OnClickModel()
	end, 3, 1)

	self.randomBubbleTimer_:Start()
end

function PaChinKoMainView:StopRandomBubbleTimer()
	if self.randomBubbleTimer_ then
		self.randomBubbleTimer_:Stop()

		self.randomBubbleTimer_ = nil
	end
end

function PaChinKoMainView:AddBubbleTimer()
	self:StopBubbleTimer()
	SetActive(self.uiBubbleGo_, true)

	self.bubbleTimer_ = Timer.New(function()
		self:StopBubbleTimer()
		SetActive(self.uiBubbleGo_, false)
	end, 2, 1)

	self.bubbleTimer_:Start()
end

function PaChinKoMainView:StopBubbleTimer()
	if self.bubbleTimer_ then
		self.bubbleTimer_:Stop()

		self.bubbleTimer_ = nil
	end
end

function PaChinKoMainView:LoadModel()
	self.heroModel_ = Object.Instantiate(Asset.Load("CharDorm/" .. BackHomeHeroSkinCfg[PaChinKoUICfg[PaChinKoUICfg.get_id_list_by_activity_id[self.params_.mainActivityID][1]].character].model))
	self.heroModelTf_ = self.heroModel_.transform
	self.heroModelTf_.eulerAngles = Vector3(PaChinKoUICfg[PaChinKoUICfg.get_id_list_by_activity_id[self.params_.mainActivityID][1]].rotation[1], PaChinKoUICfg[PaChinKoUICfg.get_id_list_by_activity_id[self.params_.mainActivityID][1]].rotation[2], PaChinKoUICfg[PaChinKoUICfg.get_id_list_by_activity_id[self.params_.mainActivityID][1]].rotation[3])
	self.heroModelTf_.localScale = Vector3(PaChinKoUICfg[PaChinKoUICfg.get_id_list_by_activity_id[self.params_.mainActivityID][1]].scale[1], PaChinKoUICfg[PaChinKoUICfg.get_id_list_by_activity_id[self.params_.mainActivityID][1]].scale[2], PaChinKoUICfg[PaChinKoUICfg.get_id_list_by_activity_id[self.params_.mainActivityID][1]].scale[3])
	self.animator_ = self.heroModel_:GetComponent(typeof(Animator))
end

function PaChinKoMainView:DestroyModel()
	Object.Destroy(self.heroModel_)

	self.heroModel_ = nil
end

function PaChinKoMainView:PlayModelAnimation(arg_36_1, arg_36_2)
	if arg_36_1 == PaChinKoMainView.MODEL_STATE.IDLE then
		self.animator_:CrossFade("stand", 0.3, -1, 0)
		self.animator_:Update(0)
		self:AddRandomBubbleTimer()
	elseif arg_36_1 == PaChinKoMainView.MODEL_STATE.INTERACTIVE then
		self.playing_ = true

		self.animator_:Play("happy02", -1, 0)
	elseif arg_36_1 == PaChinKoMainView.MODEL_STATE.PRIZE then
		self.playing_ = true

		self.animator_:Play("happy01", -1, 0)
	elseif arg_36_1 == PaChinKoMainView.MODEL_STATE.OVER then
		self.playing_ = true

		self.animator_:Play("happy01", -1, 0)
		SetActive(self.getAllRewardEffectGo_, true)
	end

	if arg_36_2 then
		self:AddAnimatorTimer(arg_36_2)
	end
end

function PaChinKoMainView:PlayModelBubble(arg_37_1, arg_37_2)
	local var_37_0

	self:StopRandomBubbleTimer()

	if arg_37_1 == PaChinKoMainView.MODEL_STATE.IDLE then
		-- block empty
	elseif arg_37_1 == PaChinKoMainView.MODEL_STATE.INTERACTIVE then
		var_37_0 = PaChinKoTools.IsGetAllReward(self.activityID_) and PaChinKoTools.GetBubbleText(PaChinKoMainView.MODEL_STATE.OVER) or PaChinKoTools.GetBubbleText(arg_37_1)
	elseif arg_37_1 == PaChinKoMainView.MODEL_STATE.PRIZE then
		var_37_0 = PaChinKoTools.GetBubbleText(arg_37_1, arg_37_2)
	elseif arg_37_1 == PaChinKoMainView.MODEL_STATE.OVER then
		var_37_0 = PaChinKoTools.GetBubbleText(arg_37_1)
	end

	if var_37_0 then
		self.uiBubbleText_.text = var_37_0

		self:AddBubbleTimer()
	end
end

function PaChinKoMainView:AddAnimatorTimer(arg_38_1)
	self:StopAnimatorTimer()

	self.animatorTimer_ = FrameTimer.New(function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self.playing_ = false

			self:StopAnimatorTimer()
			self:PlayModelAnimation(PaChinKoMainView.MODEL_STATE.IDLE)
			arg_38_1()
		end
	end, 1, -1)

	self.animatorTimer_:Start()
end

function PaChinKoMainView:StopAnimatorTimer()
	if self.animatorTimer_ then
		self.animatorTimer_:Stop()

		self.animatorTimer_ = nil
	end
end

function PaChinKoMainView:AddRewardEffectTimer()
	self:StopRewardEffectTimer()
	self.rewardEffectAnimator_:Play("UI_1_finsh", -1, 0)
	self.rewardEffectAnimator_:Update(0)

	self.rewardEffectTimer_ = Timer.New(function()
		self:StopRewardEffectTimer()
		JumpTools.OpenPageByJump("paChinKoPop")
	end, 1.2, 1)

	self.rewardEffectTimer_:Start()
end

function PaChinKoMainView:StopRewardEffectTimer()
	if self.rewardEffectTimer_ then
		self.rewardEffectTimer_:Stop()

		self.rewardEffectTimer_ = nil
	end
end

function PaChinKoMainView:AddLaunchTimer()
	self:StopLaunchTimer()
	self.launchAnimator_:Play("UI_spring_cx", -1, 0)
	manager.ui:UIEventEnabled(false)
	self.btnController_:SetSelectedState("grey")

	self.launchTimer_ = FrameTimer.New(function()
		if self.launchAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self:StopLaunchTimer()
			SetActive(self.uiBallGo_, false)
			Timer.New(function()
				self.paChinKoControllerCom_:StartGame(PaChinKoTools.GetBallOffset(self.activityID_))
			end, 0.5, 1):Start()
		end
	end, 1, -1)

	self.launchTimer_:Start()
end

function PaChinKoMainView:StopLaunchTimer()
	if self.launchTimer_ then
		self.launchTimer_:Stop()

		self.launchTimer_ = nil
	end
end

function PaChinKoMainView:OnClickModel()
	if self.playing_ == true then
		return
	end

	self:PlayModelAnimation(PaChinKoMainView.MODEL_STATE.INTERACTIVE, function()
		return
	end)
	self:PlayModelBubble(PaChinKoMainView.MODEL_STATE.INTERACTIVE)
end

return PaChinKoMainView
