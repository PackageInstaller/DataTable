local var_0_0 = class("IchiBanRaffleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = arg_1_0.params_.activityID

	return IchiBanTools.GetCfg(var_1_0).raffle_prefab_path
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.hasNextCotroller_ = arg_3_0.uiControllerEx_:GetController("hasNext")
	arg_3_0.showCloseController_ = arg_3_0.uiControllerEx_:GetController("showClose")
	arg_3_0.itemList_ = {}
	arg_3_0.positionList_ = {}

	for iter_3_0 = 1, 4 do
		arg_3_0.itemList_[iter_3_0] = IchiBanRaffleItem.New(arg_3_0.uiCardItem_, arg_3_0.uiItemParent_)
	end

	arg_3_0.viewportTransform_ = arg_3_0.scrollView_.transform
	arg_3_0.tempVector3_ = Vector3.New(0, 0, 0)
	arg_3_0.tempVector2_ = Vector2.New(0, 0)
	arg_3_0.onCompletedRaffleHandler_ = handler(arg_3_0, arg_3_0.OnCompletedRaffle)
	arg_3_0.onAddGuideTimerHandler_ = handler(arg_3_0, arg_3_0.AddGuideTimer)
	arg_3_0.onStopGuideTimerHandler_ = handler(arg_3_0, arg_3_0.StopGuideTimer)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.raffleDataList_ = clone(IchiBanData:GetUISeqList(activityID))
	arg_4_0.finishCnt_ = 0
	arg_4_0.selectedIndex_ = 1
	arg_4_0.maxCnt_ = #IchiBanData:GetUISeqList(arg_4_0.activityID_)

	arg_4_0:RefreshViewContent()
	arg_4_0:RefreshUI()
	manager.notify:RegistListener(ICHIBAN_COMPLETED_RAFFLE, arg_4_0.onCompletedRaffleHandler_)
	manager.notify:RegistListener(ICHIBAN_RAFFLE_ADD_GUIDE_TIME, arg_4_0.onAddGuideTimerHandler_)
	manager.notify:RegistListener(ICHIBAN_RAFFLE_STOP_GUIDE_TIME, arg_4_0.onStopGuideTimerHandler_)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopGuideTimer()
	manager.notify:RemoveListener(ICHIBAN_COMPLETED_RAFFLE, arg_5_0.onCompletedRaffleHandler_)
	manager.notify:RemoveListener(ICHIBAN_RAFFLE_ADD_GUIDE_TIME, arg_5_0.onAddGuideTimerHandler_)
	manager.notify:RemoveListener(ICHIBAN_RAFFLE_STOP_GUIDE_TIME, arg_5_0.onStopGuideTimerHandler_)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.itemList_) do
		iter_5_1:OnExit()
	end

	arg_5_0:StopMoveTimer()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.onCompletedRaffleHandler_ = nil
	arg_6_0.onAddGuideTimerHandler_ = nil
	arg_6_0.onStopGuideTimerHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.itemList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.uiCloseBtn_, nil, function()
		IchiBanAction.ShowRewardList(arg_7_0.activityID_, function()
			arg_7_0:Back()
			manager.notify:Invoke(ICHIBAN_REFRESH)
		end)
	end)
	arg_7_0:AddBtnListener(arg_7_0.uiNextBtn_, nil, function()
		arg_7_0.selectedIndex_ = arg_7_0.selectedIndex_ + 1

		arg_7_0:RefreshUI()
		manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_next", "")
	end)
	arg_7_0:AddBtnListener(arg_7_0.uiSkipBtn_, nil, function()
		IchiBanAction.ShowRewardList(arg_7_0.activityID_, function()
			arg_7_0:Back()
			manager.notify:Invoke(ICHIBAN_REFRESH)
		end)
	end)
end

function var_0_0.RefreshUI(arg_13_0)
	SetActive(arg_13_0.uiGuideGo_, false)
	arg_13_0.uiAnimator_:Play("ActivityIchibanKujiGameUI03", 0)
	arg_13_0:ChangeSelectItem()
	arg_13_0:RefreshItemPosition()
	arg_13_0:RefreshBtn()
	arg_13_0:RefreshText()
	arg_13_0:AddGuideTimer()
end

function var_0_0.RefreshText(arg_14_0)
	arg_14_0.uiTipsText_.text = string.format(GetTips("ICHIBAN_RAFFLE_TIPS"), arg_14_0.maxCnt_ - arg_14_0.finishCnt_)

	arg_14_0.hasNextCotroller_:SetSelectedState(tostring(arg_14_0.finishCnt_ < arg_14_0.maxCnt_))
end

function var_0_0.RefreshBtn(arg_15_0)
	SetActive(arg_15_0.uiBtnsGo_, false)
	arg_15_0.showCloseController_:SetSelectedState(tostring(arg_15_0.selectedIndex_ >= arg_15_0.maxCnt_))
end

function var_0_0.OnCompletedRaffle(arg_16_0)
	arg_16_0.uiAnimator_:Play("Card_finish", 0)

	arg_16_0.finishCnt_ = arg_16_0.finishCnt_ + 1

	arg_16_0:RefreshText()
	arg_16_0:AddAnimatorTimer()
end

function var_0_0.AddAnimatorTimer(arg_17_0)
	arg_17_0:StopAnimatorTimer()

	arg_17_0.animatorTimer_ = FrameTimer.New(function()
		if arg_17_0.uiAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime > 1 then
			arg_17_0:StopAnimatorTimer()
			SetActive(arg_17_0.uiBtnsGo_, true)
		end
	end, 1, -1)

	arg_17_0.animatorTimer_:Start()
end

function var_0_0.StopAnimatorTimer(arg_19_0)
	if arg_19_0.animatorTimer_ then
		arg_19_0.animatorTimer_:Stop()

		arg_19_0.animatorTimer_ = nil
	end
end

function var_0_0.RefreshViewContent(arg_20_0)
	local var_20_0 = arg_20_0.uiCardItemTf_.rect.width
	local var_20_1 = arg_20_0.layoutGroup_.spacing
	local var_20_2 = arg_20_0.layoutGroup_.padding.left
	local var_20_3 = arg_20_0.layoutGroup_.padding.right
	local var_20_4 = 0

	for iter_20_0 = 1, arg_20_0.maxCnt_ do
		var_20_4 = var_20_4 + 1

		if arg_20_0.positionList_[iter_20_0] == nil then
			arg_20_0.positionList_[iter_20_0] = Vector3.New(var_20_2 + (var_20_0 + var_20_1) * (iter_20_0 - 1) + var_20_0 / 2, 0, 0)
		end
	end

	if var_20_4 <= 3 then
		var_20_4 = 3
	end

	local var_20_5 = var_20_2 + var_20_0 * var_20_4 + var_20_1 * (var_20_4 - 1) + var_20_3 - arg_20_0.viewportTransform_.rect.width

	arg_20_0.tempVector2_.x = var_20_5
	arg_20_0.tempVector2_.y = arg_20_0.uiItemparentTf_.sizeDelta.y
	arg_20_0.uiItemparentTf_.sizeDelta = arg_20_0.tempVector2_
	arg_20_0.uiItemparentTf_.anchoredPosition = Vector3(arg_20_0.viewportTransform_.rect.width / 2 - var_20_0 / 2 - var_20_2, 0, 0)
end

function var_0_0.GetItemPositionX(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.uiItemparentTf_.localPosition

	return -arg_21_0.positionList_[arg_21_1].x + arg_21_0.viewportTransform_.rect.width / 2
end

function var_0_0.ChangeSelectItem(arg_22_0)
	local var_22_0 = arg_22_0:GetItemPositionX(arg_22_0.selectedIndex_)

	arg_22_0:AddMoveTimer(var_22_0)
end

function var_0_0.AddMoveTimer(arg_23_0, arg_23_1)
	arg_23_0:StopMoveTimer()

	arg_23_0.moveTimer_ = FrameTimer.New(function()
		arg_23_0:RefreshItemPosition()

		local var_24_0 = arg_23_0.uiItemparentTf_.localPosition
		local var_24_1 = GameSetting.chapter_velocity_times.value[1] * 2 * math.pow(arg_23_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_23_0.tempVector3_.x = arg_23_1
		arg_23_0.tempVector3_.y = var_24_0.y
		arg_23_0.tempVector3_.z = var_24_0.z

		local var_24_2 = Vector3.Lerp(var_24_0, arg_23_0.tempVector3_, var_24_1)
		local var_24_3 = GameSetting.chapter_scroll_min_length.value[1]

		if var_24_3 > math.abs(var_24_0.x - var_24_2.x) then
			local var_24_4 = arg_23_1 - var_24_0.x

			if var_24_3 < math.abs(var_24_4) then
				var_24_4 = var_24_3 * var_24_4 / math.abs(var_24_4)
			end

			var_24_2.x = var_24_2.x + var_24_4
		end

		arg_23_0.uiItemparentTf_.localPosition = var_24_2

		if math.abs(var_24_0.x - arg_23_1) <= GameSetting.chapter_stop_min_length.value[1] then
			arg_23_0.scrollView_:StopMovement()

			arg_23_0.uiItemparentTf_.localPosition = arg_23_0.tempVector3_

			arg_23_0:StopMoveTimer()
		end
	end, 1, -1)

	arg_23_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_25_0)
	if arg_25_0.moveTimer_ then
		arg_25_0.moveTimer_:Stop()

		arg_25_0.moveTimer_ = nil
	end
end

function var_0_0.RefreshItemPosition(arg_26_0)
	local var_26_0, var_26_1 = arg_26_0:CalcStartToEndIndex()
	local var_26_2 = {}
	local var_26_3 = {}

	for iter_26_0 = var_26_0, var_26_1 do
		local var_26_4 = arg_26_0:IsDisplayItem(iter_26_0)

		if var_26_4 then
			arg_26_0.itemList_[var_26_4]:SetIndex(iter_26_0, arg_26_0.selectedIndex_ == iter_26_0, arg_26_0.activityID_)
			arg_26_0.itemList_[var_26_4]:SetLocalPosition(arg_26_0.positionList_[iter_26_0])
			table.insert(var_26_2, var_26_4)
		else
			table.insert(var_26_3, iter_26_0)
		end
	end

	for iter_26_1, iter_26_2 in ipairs(var_26_3) do
		for iter_26_3, iter_26_4 in ipairs(arg_26_0.itemList_) do
			if not table.keyof(var_26_2, iter_26_3) then
				table.insert(var_26_2, iter_26_3)
				iter_26_4:SetIndex(iter_26_2, arg_26_0.selectedIndex_ == iter_26_2, arg_26_0.activityID_)
				iter_26_4:SetLocalPosition(arg_26_0.positionList_[iter_26_2])

				break
			end
		end
	end

	for iter_26_5 = 1, #arg_26_0.itemList_ do
		if not table.keyof(var_26_2, iter_26_5) then
			arg_26_0.itemList_[iter_26_5]:Show(false)
		end
	end
end

function var_0_0.CalcStartToEndIndex(arg_27_0)
	local var_27_0 = arg_27_0.viewportTransform_.rect.width
	local var_27_1 = arg_27_0.uiCardItemTf_.rect.width / 2
	local var_27_2 = 1
	local var_27_3 = 1
	local var_27_4 = arg_27_0.uiItemparentTf_.localPosition.x

	for iter_27_0 = 1, arg_27_0.maxCnt_ do
		local var_27_5 = arg_27_0.positionList_[iter_27_0].x + var_27_4

		if var_27_5 + var_27_1 < 0 then
			var_27_2 = iter_27_0
		end

		if var_27_5 + var_27_1 >= 0 and var_27_0 >= var_27_5 - var_27_1 then
			var_27_3 = iter_27_0
		end
	end

	if var_27_3 < var_27_2 then
		var_27_3 = var_27_2
	end

	return var_27_2, var_27_3
end

function var_0_0.IsDisplayItem(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.itemList_) do
		if arg_28_1 == iter_28_1:GetIndex() then
			return iter_28_0
		end
	end
end

function var_0_0.AddGuideTimer(arg_29_0)
	arg_29_0:StopGuideTimer()

	arg_29_0.guideTimer_ = Timer.New(function()
		arg_29_0:StopGuideTimer()
		SetActive(arg_29_0.uiGuideGo_, true)
	end, 2, 1)

	arg_29_0.guideTimer_:Start()
end

function var_0_0.StopGuideTimer(arg_31_0)
	SetActive(arg_31_0.uiGuideGo_, false)

	if arg_31_0.guideTimer_ then
		arg_31_0.guideTimer_:Stop()

		arg_31_0.guideTimer_ = nil
	end
end

return var_0_0
