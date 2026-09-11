local HodurHomeView = class("HodurHomeView", ReduxView)

function HodurHomeView:UIName()
	return "Widget/System/Activity_Hodur/Activity_Hodur_HomeUI"
end

function HodurHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function HodurHomeView:Init()
	self.mainlineItemList_ = {}

	self:InitUI()
	self:AddUIListener()
end

function HodurHomeView:InitUI()
	self:BindCfgUI()

	for iter_4_0, iter_4_1 in ipairs(ActivityHodurChapterCfg.get_id_list_by_chapter_type[HodurConst.CHAPTER_TYPE.MAINLINE]) do
		self.mainlineItemList_[iter_4_0] = HodurChapterItem.New(self["mainlineGo_" .. iter_4_0])
	end

	self.challengeItem_ = HodurChapterChallengeItem.New(self.challengeGo_)
end

function HodurHomeView:AddUIListener()
	self:AddBtnListener(self.taskBtn_, nil, function()
		LimitTimeTaskTools.JumpToLimitTimeTaskView(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	end)
	self:AddBtnListener(self.pointBtn_, nil, function()
		JumpTools.OpenPageByJump("/hodurTaskView")
	end)
end

function HodurHomeView:OnEnter()
	if not getData("activity_hodur", "first_enter") then
		saveData("activity_hodur", "first_enter", true)

		self.mainTimeline_.enabled = false
		self.bgTimeline_.enabled = true
	else
		self.mainTimeline_.enabled = true
		self.bgTimeline_.enabled = false
	end

	self:RefreshUI()
	self:RefreshLimitTime()
	self:BindRedPoint()
	HodurSystemData:UpdateTaskRedPoint()
end

function HodurHomeView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardRedRoot_.transform, RedPointConst.HODUR_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	manager.redPoint:bindUIandKey(self.pointBtnTrs_, RedPointConst.HODUR_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_HODUR_MAIN)
end

function HodurHomeView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardRedRoot_.transform, RedPointConst.HODUR_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	manager.redPoint:unbindUIandKey(self.pointBtnTrs_, RedPointConst.HODUR_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_HODUR_MAIN)
end

function HodurHomeView:RefreshLimitTime()
	local var_11_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK) then
		SetActive(self.rewardRedRoot_.gameObject, true)

		self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_11_0.stopTime)
	else
		SetActive(self.rewardRedRoot_.gameObject, false)
	end

	self:LimitStopTimer()

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK) then
				self.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_11_0.stopTime)
			elseif manager.time:GetServerTime() < var_11_0.startTime then
				self.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_11_0.startTime))
			elseif manager.time:GetServerTime() > var_11_0.stopTime then
				self.limitTimeTxt_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function HodurHomeView:RefreshUI()
	SetActive(self.unlockGo_, false)

	for iter_13_0, iter_13_1 in ipairs(ActivityHodurChapterCfg.get_id_list_by_chapter_type[HodurConst.CHAPTER_TYPE.MAINLINE]) do
		self.mainlineItemList_[iter_13_0]:SetData(iter_13_1)

		if iter_13_0 ~= 1 and HodurTools.GetChapterState(iter_13_1) == HodurConst.COMMON_STATE.UNLOCK and not getData("activity_hodur", "chapter_unlock" .. iter_13_1) then
			saveData("activity_hodur", "chapter_unlock" .. iter_13_1, true)
			self.mainlineItemList_[iter_13_0]:SetUnlockMode()
			SetActive(self.unlockGo_, true)

			self.aniTimer_ = Timer.New(function()
				if self.unlockAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1.1 then
					SetActive(self.unlockGo_, false)
					manager.audio:PlayEffect("minigame_activity_4_7", "minigame_activity_4_7_hodur_lock01", "")
					self.mainlineItemList_[iter_13_0]:PlayUnlockAnim()
					manager.ui:UIEventEnabled(true)

					if self.aniTimer_ then
						self.aniTimer_:Stop()

						self.aniTimer_ = nil
					end
				end
			end, 0.033, -1)

			self.aniTimer_:Start()
			manager.ui:UIEventEnabled(false)
		else
			Timer.New(function()
				self.mainlineItemList_[iter_13_0]:RefreshUI()
			end, 0, 1):Start()
		end
	end

	self.challengeItem_:SetData(ActivityHodurChapterCfg.get_id_list_by_chapter_type[HodurConst.CHAPTER_TYPE.CHALLENGE][1])

	if HodurTools.GetChapterState(4) == HodurConst.COMMON_STATE.UNLOCK and not getData("activity_hodur", "chapter_unlock" .. 4) then
		saveData("activity_hodur", "chapter_unlock" .. 4, true)
		self.challengeItem_:SetUnlockMode()
		SetActive(self.unlockGo_, true)

		self.aniTimer_ = Timer.New(function()
			if self.unlockAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1.1 then
				SetActive(self.unlockGo_, false)
				self.challengeItem_:PlayUnlockAnim()
				manager.ui:UIEventEnabled(true)

				if self.aniTimer_ then
					self.aniTimer_:Stop()

					self.aniTimer_ = nil
				end
			end
		end, 0.033, -1)

		self.aniTimer_:Start()
		manager.ui:UIEventEnabled(false)
		manager.audio:PlayEffect("minigame_activity_4_7", "minigame_activity_4_7_hodur_lock01", "")
	else
		Timer.New(function()
			self.challengeItem_:RefreshUI()
		end, 0, 1):Start()

		local var_13_0, var_13_1 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_HODUR_MAIN), self.taskProgressText_
	end

	var_13_1.text = var_13_0 .. "/" .. #AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN]

	self:RefreshChapter()
end

function HodurHomeView:RefreshChapter()
	for iter_18_0, iter_18_1 in ipairs(self.mainlineItemList_) do
		iter_18_1:RefreshUI()
	end

	self.challengeItem_:RefreshUI()
end

function HodurHomeView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HodurHomeView:OnBehind()
	manager.windowBar:HideBar()
end

function HodurHomeView:OnExit()
	self:UnbindRedPoint()
	self:LimitStopTimer()

	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end
end

function HodurHomeView:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function HodurHomeView:Dispose()
	self:LimitStopTimer()

	for iter_23_0, iter_23_1 in ipairs(self.mainlineItemList_) do
		iter_23_1:Dispose()
	end

	self.challengeItem_:Dispose()
	HodurHomeView.super.Dispose(self)
	self:RemoveAllListeners()
end

return HodurHomeView
