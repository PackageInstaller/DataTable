local var_0_0 = class("PaChinKoMainView", ReduxView)

var_0_0.MODEL_STATE = {
	PRIZE = 3,
	INTERACTIVE = 2,
	IDLE = 1,
	OVER = 4
}

function var_0_0.UIName(arg_1_0)
	return PaChinKoTools.GetMainUIName(arg_1_0.params_.mainActivityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.showBubbleController_ = arg_3_0.uiControllerEx_:GetController("showBubble")
	arg_3_0.showMailController_ = arg_3_0.uiControllerEx_:GetController("showMail")
	arg_3_0.btnController_ = arg_3_0.uiSendControllerEx_:GetController("btn")
	arg_3_0.enoughController_ = arg_3_0.uiSendControllerEx_:GetController("enough")
	arg_3_0.rewardViewList_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.rewardViewList_[iter_3_0] = PaChinKoMainRewardList.New(arg_3_0[string.format("uiRewardList%s_", iter_3_0)], iter_3_0)
	end

	arg_3_0.paChinKoMainTriggerBox_ = PaChinKoMainTriggerBox.New(arg_3_0.uiTriggerGo_)
	arg_3_0.onFinishPachinkoHanlder_ = handler(arg_3_0, arg_3_0.OnFinishPachinko)
	arg_3_0.paChinKoControllerCom_ = arg_3_0.uiPlayContentGo_:GetComponent(typeof(pachinko.PaChinKoController))

	arg_3_0:LoadModel()
end

function var_0_0.OnEnter(arg_4_0)
	manager.ui:SetMainCamera("null")
	manager.ui:SetMainCameraPos(Vector3.zero)
	manager.ui:SetMainCameraRot(Vector3.zero)

	arg_4_0.activityID_ = arg_4_0.params_.mainActivityID

	SetActive(arg_4_0.paChinKoControllerCom_.m_ballGo, false)

	arg_4_0.readyLaunchFlag_ = true
	arg_4_0.skipLaunch_ = getData("paChinKo", "skipLaunch" .. arg_4_0.activityID_) or false
	arg_4_0.uiSkipLaunchToggle_.isOn = arg_4_0.skipLaunch_

	local var_4_0 = PaChinKoTools.GetCurrencyID(arg_4_0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_4_0
	})
	manager.windowBar:SetBarCanClick(var_4_0, true)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.rewardViewList_) do
		iter_4_1:OnEnter(arg_4_0.activityID_)
	end

	arg_4_0.uiIcon_.sprite = ItemTools.getItemLittleSprite(var_4_0)
	arg_4_0.uiNoticeText_.text = ""

	arg_4_0.paChinKoMainTriggerBox_:RefreshTrigger(arg_4_0.activityID_)
	arg_4_0:RefreshUI()
	arg_4_0:AddRandomTimer()
	arg_4_0:AddRandomBubbleTimer()
	manager.notify:RegistListener(PACHINKO_FINISH, arg_4_0.onFinishPachinkoHanlder_)
	SetActive(arg_4_0.heroModel_, true)
	arg_4_0:PlayModelAnimation(var_0_0.MODEL_STATE.IDLE)
	SetActive(arg_4_0.uiBubbleGo_, false)

	arg_4_0.playing_ = false

	for iter_4_2 = 1, 3 do
		SetActive(arg_4_0[string.format("rewardEffectGo%s_", iter_4_2)], false)
	end

	SetActive(arg_4_0.getAllRewardEffectGo_, false)

	if not PaChinKoTools.IsGetAllReward(arg_4_0.activityID_) and ItemTools.getItemNum(var_4_0) > 0 then
		SetActive(arg_4_0.uiBallGo_, true)
	else
		SetActive(arg_4_0.uiBallGo_, false)
	end

	manager.redPoint:bindUIandKey(arg_4_0.uiSendBtn_.transform, RedPointConst.ACTIVITY_PACHINKO .. "_" .. arg_4_0.activityID_)

	local var_4_1 = var_0_0.GetUICam():WorldToScreenPoint(arg_4_0.uiTouchBtn_.transform.position) - Vector3(0, arg_4_0.uiTouchBtn_.transform.rect.height / 2, 0)
	local var_4_2 = manager.ui.mainCameraCom_:ScreenToWorldPoint(var_4_1)
	local var_4_3 = PaChinKoUICfg.get_id_list_by_activity_id[arg_4_0.activityID_][1]
	local var_4_4 = PaChinKoUICfg[var_4_3]

	arg_4_0.heroModelTf_.localPosition = Vector3(var_4_2.x, var_4_4.posY, var_4_2.z)

	local var_4_5 = var_0_0.GetUICam():WorldToScreenPoint(arg_4_0.transform_.position - Vector3(0, 0, -2))
	local var_4_6 = manager.ui.mainCameraCom_:ScreenToWorldPoint(var_4_5)

	arg_4_0.uiBg1_.transform.parent = nil
	arg_4_0.uiBg1_.transform.localPosition = var_4_6
	arg_4_0.uiBg1_.transform.localScale = Vector3(0.5, 0.5, 1)

	SetActive(arg_4_0.uiBg1_, true)
end

function var_0_0.OnExit(arg_5_0)
	SetActive(arg_5_0.uiBg1_, false)
	manager.redPoint:unbindUIandKey(arg_5_0.uiSendBtn_.transform, RedPointConst.ACTIVITY_PACHINKO .. "_" .. arg_5_0.activityID_)
	SetActive(arg_5_0.heroModel_, false)
	arg_5_0:StopRandomTimer()
	arg_5_0:StopBubbleTimer()
	arg_5_0:StopAnimatorTimer()
	arg_5_0:StopRandomBubbleTimer()
	arg_5_0:StopRewardEffectTimer()
	arg_5_0:StopLaunchTimer()
	manager.notify:RemoveListener(PACHINKO_FINISH, arg_5_0.onFinishPachinkoHanlder_)
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.rewardViewList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:DestroyModel()
	Object.Destroy(arg_6_0.uiBg1_)

	arg_6_0.uiBg1_ = nil
	arg_6_0.onFinishPachinkoHanlder_ = nil

	arg_6_0.paChinKoMainTriggerBox_:Dispose()

	arg_6_0.paChinKoMainTriggerBox_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.rewardViewList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.rewardViewList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.uiMailBtn_, nil, function()
		JumpTools.OpenPageByJump("paChinKoPop")
	end)
	arg_7_0:AddBtnListener(arg_7_0.uiTouchBtn_, nil, function()
		arg_7_0:OnClickModel()
	end)
	arg_7_0:AddBtnListener(arg_7_0.uiSendBtn_, nil, function()
		if arg_7_0.readyLaunchFlag_ == false then
			return
		end

		local var_10_0 = PaChinKoTools.GetCurrencyID(arg_7_0.activityID_)

		if ItemTools.getItemNum(var_10_0) <= 0 then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[var_10_0].name)))

			return
		end

		arg_7_0.readyLaunchFlag_ = false

		if arg_7_0.skipLaunch_ then
			arg_7_0:SendResult(0)
		else
			arg_7_0:AddLaunchTimer()
		end
	end)
	arg_7_0:AddToggleListener(arg_7_0.uiSkipLaunchToggle_, function(arg_11_0)
		arg_7_0.skipLaunch_ = arg_11_0

		saveData("paChinKo", "skipLaunch" .. arg_7_0.activityID_, arg_11_0)
	end)
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0:RefreshBtnState()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rewardViewList_) do
		iter_12_1:RefreshUI()
	end

	arg_12_0.paChinKoMainTriggerBox_:RefreshUI()

	if PaChinKoTools.IsClearLevelPrize(arg_12_0.activityID_, 1) then
		arg_12_0.showMailController_:SetSelectedState("true")
	else
		arg_12_0.showMailController_:SetSelectedState("false")
	end

	local var_12_0 = PaChinKoTools.GetCurrencyID(arg_12_0.activityID_)

	if ItemTools.getItemNum(var_12_0) > 0 then
		arg_12_0.enoughController_:SetSelectedState("true")
	else
		arg_12_0.enoughController_:SetSelectedState("false")
	end

	arg_12_0.launchAnimator_:Play("New State", -1, 0)
end

function var_0_0.OnFinishPachinko(arg_13_0, arg_13_1)
	Timer.New(function()
		SetActive(arg_13_0.paChinKoControllerCom_.m_ballGo, false)
		arg_13_0:SendResult(arg_13_1)
	end, 0.5, 1):Start()
end

function var_0_0.SendResult(arg_15_0, arg_15_1)
	PaChinKoAction.SendTriggerLevel(arg_15_0.activityID_, arg_15_1, function(arg_16_0)
		manager.ui:UIEventEnabled(true)

		local var_16_0 = PaChinKoSignCfg[arg_16_0]
		local var_16_1 = var_16_0.reward
		local var_16_2 = var_16_0.level
		local var_16_3 = PaChinKoTools.IsGetAllReward(arg_15_0.activityID_)

		if arg_15_1 == 0 then
			arg_15_0.paChinKoMainTriggerBox_:PlayEffect(var_16_2)
		end

		local function var_16_4()
			if var_16_3 then
				SetActive(arg_15_0.getAllRewardEffectGo_, false)
			end

			getReward(formatRewardCfgList({
				var_16_1
			}), nil, function()
				arg_15_0:RefreshUI()

				arg_15_0.readyLaunchFlag_ = true

				arg_15_0:RefreshRewardText(arg_16_0)

				local var_18_0 = PaChinKoTools.IsClearLevelPrize(arg_15_0.activityID_, var_16_2)

				if not var_16_3 and var_18_0 then
					local var_18_1 = GetTips(string.format("PACHINKO_LEVEL_REWARD_%s", var_16_2))

					ShowTips(string.format(GetTips("PACHINKO_LEVEL_CLEAR_TIPS"), var_18_1))
				end

				if var_18_0 then
					SetActive(arg_15_0[string.format("rewardEffectGo%s_", var_16_2)], true)
				end

				if var_16_2 == 1 then
					arg_15_0:AddRewardEffectTimer()
				end

				local var_18_2 = PaChinKoTools.GetCurrencyID(arg_15_0.activityID_)

				if not var_16_3 and ItemTools.getItemNum(var_18_2) > 0 then
					SetActive(arg_15_0.uiBallGo_, true)
				end

				arg_15_0:AddRandomTimer()
			end)
		end

		if var_16_3 then
			arg_15_0:PlayModelAnimation(var_0_0.MODEL_STATE.OVER, var_16_4)
			arg_15_0:PlayModelBubble(var_0_0.MODEL_STATE.OVER)
		else
			arg_15_0:PlayModelAnimation(var_0_0.MODEL_STATE.PRIZE, var_16_4)
			arg_15_0:PlayModelBubble(var_0_0.MODEL_STATE.PRIZE, var_16_2)
		end
	end)
end

function var_0_0.RefreshBtnState(arg_19_0)
	if PaChinKoTools.IsGetAllReward(arg_19_0.activityID_) then
		arg_19_0.btnController_:SetSelectedState("clear")
	else
		arg_19_0.btnController_:SetSelectedState("normal")
	end
end

function var_0_0.RefreshRewardText(arg_20_0, arg_20_1)
	local var_20_0 = PaChinKoSignCfg[arg_20_1]
	local var_20_1 = PaChinKoConst.LEVEL_TITLE_TEXT[var_20_0.level]
	local var_20_2 = PlayerData:GetPlayerInfo()

	arg_20_0.uiNoticeText_.text = string.format(GetTips(var_20_1), var_20_2.nick, var_20_0.reward_name)

	arg_20_0:ScrollText()
end

function var_0_0.RandomRewardText(arg_21_0)
	local var_21_0 = PaChinKoTextCfg.get_id_list_by_type[2]
	local var_21_1 = var_21_0[math.random(1, #var_21_0)]
	local var_21_2 = PaChinKoTextCfg[var_21_1]

	arg_21_0.uiNoticeText_.text = string.format(GetTips("PACHINKO_RANDOM_CONGRATS"), var_21_2.hero, var_21_2.prize)

	arg_21_0:ScrollText()
end

function var_0_0.ScrollText(arg_22_0)
	arg_22_0.uiNoticeTf_.localPosition = Vector3.New(500, arg_22_0.uiNoticeTf_.localPosition.y, 0)

	local var_22_0 = (arg_22_0.uiScollTextParent_.sizeDelta.x + arg_22_0.uiNoticeTf_.sizeDelta.x) * -1

	arg_22_0:RemoveTween()

	arg_22_0.tween_ = LeanTween.moveLocalX(arg_22_0.uiNoticeTf_.gameObject, var_22_0, var_22_0 / -200):setOnComplete(LuaHelper.VoidAction(function()
		arg_22_0:RemoveTween()
	end))
end

function var_0_0.RemoveTween(arg_24_0)
	if arg_24_0.tween_ then
		arg_24_0.tween_:setOnComplete(nil)
		LeanTween.cancel(arg_24_0.tween_.id)

		arg_24_0.tween_ = nil
	end
end

function var_0_0.AddRandomTimer(arg_25_0)
	arg_25_0:StopRandomTimer()

	arg_25_0.randomTimer_ = Timer.New(function()
		if math.random(0, 99) > 50 then
			arg_25_0:RandomRewardText()
		end

		arg_25_0:AddRandomTimer()
	end, 7, 1)

	arg_25_0.randomTimer_:Start()
end

function var_0_0.StopRandomTimer(arg_27_0)
	if arg_27_0.randomTimer_ then
		arg_27_0.randomTimer_:Stop()

		arg_27_0.randomTimer_ = nil
	end
end

function var_0_0.AddRandomBubbleTimer(arg_28_0)
	arg_28_0:StopRandomBubbleTimer()

	arg_28_0.randomBubbleTimer_ = Timer.New(function()
		arg_28_0:StopRandomBubbleTimer()
		arg_28_0:OnClickModel()
	end, 3, 1)

	arg_28_0.randomBubbleTimer_:Start()
end

function var_0_0.StopRandomBubbleTimer(arg_30_0)
	if arg_30_0.randomBubbleTimer_ then
		arg_30_0.randomBubbleTimer_:Stop()

		arg_30_0.randomBubbleTimer_ = nil
	end
end

function var_0_0.AddBubbleTimer(arg_31_0)
	arg_31_0:StopBubbleTimer()
	SetActive(arg_31_0.uiBubbleGo_, true)

	arg_31_0.bubbleTimer_ = Timer.New(function()
		arg_31_0:StopBubbleTimer()
		SetActive(arg_31_0.uiBubbleGo_, false)
	end, 2, 1)

	arg_31_0.bubbleTimer_:Start()
end

function var_0_0.StopBubbleTimer(arg_33_0)
	if arg_33_0.bubbleTimer_ then
		arg_33_0.bubbleTimer_:Stop()

		arg_33_0.bubbleTimer_ = nil
	end
end

function var_0_0.LoadModel(arg_34_0)
	local var_34_0 = arg_34_0.params_.mainActivityID
	local var_34_1 = PaChinKoUICfg.get_id_list_by_activity_id[var_34_0][1]
	local var_34_2 = PaChinKoUICfg[var_34_1]
	local var_34_3 = BackHomeHeroSkinCfg[var_34_2.character].model

	arg_34_0.heroModel_ = Object.Instantiate(Asset.Load("CharDorm/" .. var_34_3))
	arg_34_0.heroModelTf_ = arg_34_0.heroModel_.transform
	arg_34_0.heroModelTf_.eulerAngles = Vector3(var_34_2.rotation[1], var_34_2.rotation[2], var_34_2.rotation[3])
	arg_34_0.heroModelTf_.localScale = Vector3(var_34_2.scale[1], var_34_2.scale[2], var_34_2.scale[3])
	arg_34_0.animator_ = arg_34_0.heroModel_:GetComponent(typeof(Animator))
end

function var_0_0.DestroyModel(arg_35_0)
	Object.Destroy(arg_35_0.heroModel_)

	arg_35_0.heroModel_ = nil
end

function var_0_0.PlayModelAnimation(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == var_0_0.MODEL_STATE.IDLE then
		arg_36_0.animator_:CrossFade("stand", 0.3, -1, 0)
		arg_36_0.animator_:Update(0)
		arg_36_0:AddRandomBubbleTimer()
	elseif arg_36_1 == var_0_0.MODEL_STATE.INTERACTIVE then
		arg_36_0.playing_ = true

		arg_36_0.animator_:Play("happy02", -1, 0)
	elseif arg_36_1 == var_0_0.MODEL_STATE.PRIZE then
		arg_36_0.playing_ = true

		arg_36_0.animator_:Play("happy01", -1, 0)
	elseif arg_36_1 == var_0_0.MODEL_STATE.OVER then
		arg_36_0.playing_ = true

		arg_36_0.animator_:Play("happy01", -1, 0)
		SetActive(arg_36_0.getAllRewardEffectGo_, true)
	end

	if arg_36_2 then
		arg_36_0:AddAnimatorTimer(arg_36_2)
	end
end

function var_0_0.PlayModelBubble(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0

	arg_37_0:StopRandomBubbleTimer()

	if arg_37_1 == var_0_0.MODEL_STATE.IDLE then
		-- block empty
	elseif arg_37_1 == var_0_0.MODEL_STATE.INTERACTIVE then
		if PaChinKoTools.IsGetAllReward(arg_37_0.activityID_) then
			var_37_0 = PaChinKoTools.GetBubbleText(var_0_0.MODEL_STATE.OVER)
		else
			var_37_0 = PaChinKoTools.GetBubbleText(arg_37_1)
		end
	elseif arg_37_1 == var_0_0.MODEL_STATE.PRIZE then
		var_37_0 = PaChinKoTools.GetBubbleText(arg_37_1, arg_37_2)
	elseif arg_37_1 == var_0_0.MODEL_STATE.OVER then
		var_37_0 = PaChinKoTools.GetBubbleText(arg_37_1)
	end

	if var_37_0 then
		arg_37_0.uiBubbleText_.text = var_37_0

		arg_37_0:AddBubbleTimer()
	end
end

function var_0_0.AddAnimatorTimer(arg_38_0, arg_38_1)
	arg_38_0:StopAnimatorTimer()

	arg_38_0.animatorTimer_ = FrameTimer.New(function()
		if arg_38_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_38_0.playing_ = false

			arg_38_0:StopAnimatorTimer()
			arg_38_0:PlayModelAnimation(var_0_0.MODEL_STATE.IDLE)
			arg_38_1()
		end
	end, 1, -1)

	arg_38_0.animatorTimer_:Start()
end

function var_0_0.StopAnimatorTimer(arg_40_0)
	if arg_40_0.animatorTimer_ then
		arg_40_0.animatorTimer_:Stop()

		arg_40_0.animatorTimer_ = nil
	end
end

function var_0_0.AddRewardEffectTimer(arg_41_0)
	arg_41_0:StopRewardEffectTimer()
	arg_41_0.rewardEffectAnimator_:Play("UI_1_finsh", -1, 0)
	arg_41_0.rewardEffectAnimator_:Update(0)

	arg_41_0.rewardEffectTimer_ = Timer.New(function()
		arg_41_0:StopRewardEffectTimer()
		JumpTools.OpenPageByJump("paChinKoPop")
	end, 1.2, 1)

	arg_41_0.rewardEffectTimer_:Start()
end

function var_0_0.StopRewardEffectTimer(arg_43_0)
	if arg_43_0.rewardEffectTimer_ then
		arg_43_0.rewardEffectTimer_:Stop()

		arg_43_0.rewardEffectTimer_ = nil
	end
end

function var_0_0.AddLaunchTimer(arg_44_0)
	arg_44_0:StopLaunchTimer()
	arg_44_0.launchAnimator_:Play("UI_spring_cx", -1, 0)
	manager.ui:UIEventEnabled(false)
	arg_44_0.btnController_:SetSelectedState("grey")

	arg_44_0.launchTimer_ = FrameTimer.New(function()
		if arg_44_0.launchAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_44_0:StopLaunchTimer()
			SetActive(arg_44_0.uiBallGo_, false)
			Timer.New(function()
				arg_44_0.paChinKoControllerCom_:StartGame(PaChinKoTools.GetBallOffset(arg_44_0.activityID_))
			end, 0.5, 1):Start()
		end
	end, 1, -1)

	arg_44_0.launchTimer_:Start()
end

function var_0_0.StopLaunchTimer(arg_47_0)
	if arg_47_0.launchTimer_ then
		arg_47_0.launchTimer_:Stop()

		arg_47_0.launchTimer_ = nil
	end
end

function var_0_0.OnClickModel(arg_48_0)
	if arg_48_0.playing_ == true then
		return
	end

	arg_48_0:PlayModelAnimation(var_0_0.MODEL_STATE.INTERACTIVE, function()
		return
	end)
	arg_48_0:PlayModelBubble(var_0_0.MODEL_STATE.INTERACTIVE)
end

return var_0_0
