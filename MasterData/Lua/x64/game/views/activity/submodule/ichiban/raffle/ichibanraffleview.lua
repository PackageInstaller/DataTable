local IchiBanRaffleView = class("IchiBanRaffleView", ReduxView)

function IchiBanRaffleView:UIName()
	return IchiBanTools.GetCfg(self.params_.activityID).raffle_prefab_path
end

function IchiBanRaffleView:UIParent()
	return manager.ui.uiPop.transform
end

function IchiBanRaffleView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.hasNextCotroller_ = self.uiControllerEx_:GetController("hasNext")
	self.showCloseController_ = self.uiControllerEx_:GetController("showClose")
	self.itemList_ = {}
	self.positionList_ = {}

	for iter_3_0 = 1, 4 do
		self.itemList_[iter_3_0] = IchiBanRaffleItem.New(self.uiCardItem_, self.uiItemParent_)
	end

	self.viewportTransform_ = self.scrollView_.transform
	self.tempVector3_ = Vector3.New(0, 0, 0)
	self.tempVector2_ = Vector2.New(0, 0)
	self.onCompletedRaffleHandler_ = handler(self, self.OnCompletedRaffle)
	self.onAddGuideTimerHandler_ = handler(self, self.AddGuideTimer)
	self.onStopGuideTimerHandler_ = handler(self, self.StopGuideTimer)
end

function IchiBanRaffleView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.raffleDataList_ = clone(IchiBanData:GetUISeqList(activityID))
	self.finishCnt_ = 0
	self.selectedIndex_ = 1
	self.maxCnt_ = #IchiBanData:GetUISeqList(self.activityID_)

	self:RefreshViewContent()
	self:RefreshUI()
	manager.notify:RegistListener(ICHIBAN_COMPLETED_RAFFLE, self.onCompletedRaffleHandler_)
	manager.notify:RegistListener(ICHIBAN_RAFFLE_ADD_GUIDE_TIME, self.onAddGuideTimerHandler_)
	manager.notify:RegistListener(ICHIBAN_RAFFLE_STOP_GUIDE_TIME, self.onStopGuideTimerHandler_)
end

function IchiBanRaffleView:OnExit()
	self:StopGuideTimer()
	manager.notify:RemoveListener(ICHIBAN_COMPLETED_RAFFLE, self.onCompletedRaffleHandler_)
	manager.notify:RemoveListener(ICHIBAN_RAFFLE_ADD_GUIDE_TIME, self.onAddGuideTimerHandler_)
	manager.notify:RemoveListener(ICHIBAN_RAFFLE_STOP_GUIDE_TIME, self.onStopGuideTimerHandler_)

	for iter_5_0, iter_5_1 in pairs(self.itemList_) do
		iter_5_1:OnExit()
	end

	self:StopMoveTimer()
end

function IchiBanRaffleView:Dispose()
	self.onCompletedRaffleHandler_ = nil
	self.onAddGuideTimerHandler_ = nil
	self.onStopGuideTimerHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.itemList_ = nil

	IchiBanRaffleView.super.Dispose(self)
end

function IchiBanRaffleView:AddListeners()
	self:AddBtnListener(self.uiCloseBtn_, nil, function()
		IchiBanAction.ShowRewardList(self.activityID_, function()
			self:Back()
			manager.notify:Invoke(ICHIBAN_REFRESH)
		end)
	end)
	self:AddBtnListener(self.uiNextBtn_, nil, function()
		self.selectedIndex_ = self.selectedIndex_ + 1

		self:RefreshUI()
		manager.audio:PlayEffect("minigame_activity_4_8", "minigame_activity_4_8_ichi_next", "")
	end)
	self:AddBtnListener(self.uiSkipBtn_, nil, function()
		IchiBanAction.ShowRewardList(self.activityID_, function()
			self:Back()
			manager.notify:Invoke(ICHIBAN_REFRESH)
		end)
	end)
end

function IchiBanRaffleView:RefreshUI()
	SetActive(self.uiGuideGo_, false)
	self.uiAnimator_:Play("ActivityIchibanKujiGameUI03", 0)
	self:ChangeSelectItem()
	self:RefreshItemPosition()
	self:RefreshBtn()
	self:RefreshText()
	self:AddGuideTimer()
end

function IchiBanRaffleView:RefreshText()
	self.uiTipsText_.text = string.format(GetTips("ICHIBAN_RAFFLE_TIPS"), self.maxCnt_ - self.finishCnt_)

	self.hasNextCotroller_:SetSelectedState(tostring(self.finishCnt_ < self.maxCnt_))
end

function IchiBanRaffleView:RefreshBtn()
	SetActive(self.uiBtnsGo_, false)
	self.showCloseController_:SetSelectedState(tostring(self.selectedIndex_ >= self.maxCnt_))
end

function IchiBanRaffleView:OnCompletedRaffle()
	self.uiAnimator_:Play("Card_finish", 0)

	self.finishCnt_ = self.finishCnt_ + 1

	self:RefreshText()
	self:AddAnimatorTimer()
end

function IchiBanRaffleView:AddAnimatorTimer()
	self:StopAnimatorTimer()

	self.animatorTimer_ = FrameTimer.New(function()
		if self.uiAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime > 1 then
			self:StopAnimatorTimer()
			SetActive(self.uiBtnsGo_, true)
		end
	end, 1, -1)

	self.animatorTimer_:Start()
end

function IchiBanRaffleView:StopAnimatorTimer()
	if self.animatorTimer_ then
		self.animatorTimer_:Stop()

		self.animatorTimer_ = nil
	end
end

function IchiBanRaffleView:RefreshViewContent()
	local var_20_0 = 0

	for iter_20_0 = 1, self.maxCnt_ do
		var_20_0 = var_20_0 + 1

		if self.positionList_[iter_20_0] == nil then
			self.positionList_[iter_20_0] = Vector3.New(self.layoutGroup_.padding.left + (self.uiCardItemTf_.rect.width + self.layoutGroup_.spacing) * (iter_20_0 - 1) + self.uiCardItemTf_.rect.width / 2, 0, 0)
		end
	end

	if var_20_0 <= 3 then
		var_20_0 = 3
	end

	self.tempVector2_.x = self.layoutGroup_.padding.left + self.uiCardItemTf_.rect.width * var_20_0 + self.layoutGroup_.spacing * (var_20_0 - 1) + self.layoutGroup_.padding.right - self.viewportTransform_.rect.width
	self.tempVector2_.y = self.uiItemparentTf_.sizeDelta.y
	self.uiItemparentTf_.sizeDelta = self.tempVector2_
	self.uiItemparentTf_.anchoredPosition = Vector3(self.viewportTransform_.rect.width / 2 - self.uiCardItemTf_.rect.width / 2 - self.layoutGroup_.padding.left, 0, 0)
end

function IchiBanRaffleView:GetItemPositionX(arg_21_1)
	return -self.positionList_[arg_21_1].x + self.viewportTransform_.rect.width / 2
end

function IchiBanRaffleView:ChangeSelectItem()
	self:AddMoveTimer((self:GetItemPositionX(self.selectedIndex_)))
end

function IchiBanRaffleView:AddMoveTimer(arg_23_1)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		self:RefreshItemPosition()

		self.tempVector3_.x = arg_23_1
		self.tempVector3_.y = self.uiItemparentTf_.localPosition.y
		self.tempVector3_.z = self.uiItemparentTf_.localPosition.z

		local var_24_0 = Vector3.Lerp(self.uiItemparentTf_.localPosition, self.tempVector3_, GameSetting.chapter_velocity_times.value[1] * 2 * math.pow(self.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if GameSetting.chapter_scroll_min_length.value[1] > math.abs(self.uiItemparentTf_.localPosition.x - var_24_0.x) then
			local var_24_1 = arg_23_1 - self.uiItemparentTf_.localPosition.x

			if GameSetting.chapter_scroll_min_length.value[1] < math.abs(arg_23_1 - self.uiItemparentTf_.localPosition.x) then
				var_24_1 = GameSetting.chapter_scroll_min_length.value[1] * var_24_1 / math.abs(var_24_1)
			end

			var_24_0.x = var_24_0.x + var_24_1
		end

		self.uiItemparentTf_.localPosition = var_24_0

		if math.abs(self.uiItemparentTf_.localPosition.x - arg_23_1) <= GameSetting.chapter_stop_min_length.value[1] then
			self.scrollView_:StopMovement()

			self.uiItemparentTf_.localPosition = self.tempVector3_

			self:StopMoveTimer()
		end
	end, 1, -1)

	self.moveTimer_:Start()
end

function IchiBanRaffleView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function IchiBanRaffleView:RefreshItemPosition()
	local var_26_0, var_26_1 = self:CalcStartToEndIndex()
	local var_26_2 = {}
	local var_26_3 = {}

	for iter_26_0 = var_26_0, var_26_1 do
		local var_26_4 = self:IsDisplayItem(iter_26_0)

		if var_26_4 then
			self.itemList_[var_26_4]:SetIndex(iter_26_0, self.selectedIndex_ == iter_26_0, self.activityID_)
			self.itemList_[var_26_4]:SetLocalPosition(self.positionList_[iter_26_0])
			table.insert(var_26_2, var_26_4)
		else
			table.insert(var_26_3, iter_26_0)
		end
	end

	for iter_26_1, iter_26_2 in ipairs(var_26_3) do
		for iter_26_3, iter_26_4 in ipairs(self.itemList_) do
			if not table.keyof(var_26_2, iter_26_3) then
				table.insert(var_26_2, iter_26_3)
				iter_26_4:SetIndex(iter_26_2, self.selectedIndex_ == iter_26_2, self.activityID_)
				iter_26_4:SetLocalPosition(self.positionList_[iter_26_2])

				break
			end
		end
	end

	for iter_26_5 = 1, #self.itemList_ do
		if not table.keyof(var_26_2, iter_26_5) then
			self.itemList_[iter_26_5]:Show(false)
		end
	end
end

function IchiBanRaffleView:CalcStartToEndIndex()
	local var_27_0 = 1
	local var_27_1 = 1

	for iter_27_0 = 1, self.maxCnt_ do
		if self.positionList_[iter_27_0].x + self.uiItemparentTf_.localPosition.x + self.uiCardItemTf_.rect.width / 2 < 0 then
			var_27_0 = iter_27_0
		end

		if self.positionList_[iter_27_0].x + self.uiItemparentTf_.localPosition.x + self.uiCardItemTf_.rect.width / 2 >= 0 and self.viewportTransform_.rect.width >= self.positionList_[iter_27_0].x + self.uiItemparentTf_.localPosition.x - self.uiCardItemTf_.rect.width / 2 then
			var_27_1 = iter_27_0
		end
	end

	if var_27_1 < var_27_0 then
		var_27_1 = var_27_0
	end

	return var_27_0, var_27_1
end

function IchiBanRaffleView:IsDisplayItem(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(self.itemList_) do
		if arg_28_1 == iter_28_1:GetIndex() then
			return iter_28_0
		end
	end
end

function IchiBanRaffleView:AddGuideTimer()
	self:StopGuideTimer()

	self.guideTimer_ = Timer.New(function()
		self:StopGuideTimer()
		SetActive(self.uiGuideGo_, true)
	end, 2, 1)

	self.guideTimer_:Start()
end

function IchiBanRaffleView:StopGuideTimer()
	SetActive(self.uiGuideGo_, false)

	if self.guideTimer_ then
		self.guideTimer_:Stop()

		self.guideTimer_ = nil
	end
end

return IchiBanRaffleView
