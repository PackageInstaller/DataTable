local RogueCardGameHomeView = class("RogueCardGameHomeView", ReduxView)

function RogueCardGameHomeView:UIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_HomeUI"
end

function RogueCardGameHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function RogueCardGameHomeView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RogueCardGameHomeView:InitUI()
	self:BindCfgUI()

	self.challengeCon_ = self.challengeController_:GetController("Challenge")
	self.stateCon_ = self.stateController_:GetController("state")
	self.skinCon_ = self.skinController_:GetController("state")
	self.items_ = {}
	self.onRefreshDLCHandler = handler(self, self.OnRefreshDLC)
end

function RogueCardGameHomeView:AddUIListeners()
	self:AddBtnListener(self.forumBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameForumView")
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_ROGUECARD_TASK
		})
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("rogueCardGameSkinDLCPopView")
	end)
	self:AddBtnListener(self.recordBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameIllustratedView")
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameChallengeSelectView")
	end)
	self:AddBtnListener(self.challengeLock_, nil, function()
		ShowTips((GetI18NText(ConditionCfg[1270101].desc)))
	end)
	self:AddBtnListener(self.illustratedBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameRecordView")
	end)
end

function RogueCardGameHomeView:StopUpdateTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end
end

function RogueCardGameHomeView:UpdateTimeTxt()
	local var_14_0 = os.time()
	local var_14_1 = os.date("!*t", var_14_0 + os.difftime(var_14_0, os.time(os.date("!*t", var_14_0))))

	self.dayText_.text = string.format("%s/%s", var_14_1.month, var_14_1.day)
	self.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function RogueCardGameHomeView:OnEnter()
	RogueCardGameHomeView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK)
	manager.redPoint:bindUIandKey(self.illustratedBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_RESIDENT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_5_0)
	manager.redPoint:bindUIandKey(self.skinBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onRefreshDLCHandler)
	manager.redPoint:bindUIandKey(self.recordBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED)
	self:IsOpenGuide()
	self:BindRedPoint()

	if self.params_.isHome then
		self.progressAnim_.enabled = true

		if self.playableGo_ and self.playableGo_.playableAsset then
			TimelineTools.PlayTimelineWithCallback(self.playableGo_, self.playableGo_.playableAsset, function()
				self.forumBtn_.enabled = true
				self.rewardBtn_.enabled = true
				self.skinBtn_.enabled = true
				self.recordBtn_.enabled = true
				self.challengeBtn_.enabled = true
				self.challengeLock_.enabled = true
				self.illustratedBtn_.enabled = true
			end)
		end

		self.playableGo_:Play()
		self:BtnTimer()

		self.params_.isHome = nil
	else
		self.progressAnim_.enabled = false
		self.forumBtn_.enabled = true
		self.rewardBtn_.enabled = true
		self.skinBtn_.enabled = true
		self.recordBtn_.enabled = true
		self.challengeBtn_.enabled = true
		self.challengeLock_.enabled = true
		self.illustratedBtn_.enabled = true
	end

	self:RefreshView()
end

function RogueCardGameHomeView:BtnTimer()
	self:StopBtnTimer()

	self.btnTimer = FrameTimer.New(function()
		self.forumBtn_.enabled = false
		self.rewardBtn_.enabled = false
		self.skinBtn_.enabled = false
		self.recordBtn_.enabled = false
		self.challengeBtn_.enabled = false
		self.challengeLock_.enabled = false
		self.illustratedBtn_.enabled = false

		self:StopBtnTimer()
	end, 3, -1)

	self.btnTimer:Start()
end

function RogueCardGameHomeView:StopBtnTimer()
	if self.btnTimer then
		self.btnTimer:Stop()

		self.btnTimer = nil
	end
end

function RogueCardGameHomeView:IsOpenGuide()
	self:StopTimer()

	self.openingTimer = FrameTimer.New(function()
		if manager.guide:IsPlaying() then
			self.playableGo_.enabled = false
		else
			self.playableGo_.enabled = true

			self:StopTimer()
		end
	end, 1, -1)

	self.openingTimer:Start()
end

function RogueCardGameHomeView:StopTimer()
	if self.openingTimer then
		self.openingTimer:Stop()

		self.openingTimer = nil
	end
end

function RogueCardGameHomeView:RefreshView()
	if RogueCardGameTools.IsCompleteForum() then
		self.challengeCon_:SetSelectedIndex(1)
	else
		self.challengeCon_:SetSelectedIndex(0)
	end

	self.recordNum_.text = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_ROGUECARD_5_0) .. "/" .. #AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ROGUECARD_5_0]

	self:AddTimer()
	self:RefreshDLCState()
end

function RogueCardGameHomeView:RefreshDLCState()
	local var_24_1 = 0
	local var_24_2 = false

	for iter_24_0, iter_24_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ROGUECARD_SKIN] or {}) do
		local var_24_3 = TaskData2:GetTaskProgress(iter_24_1) >= AssignmentCfg[iter_24_1].need

		if TaskData2:GetTaskComplete(iter_24_1) then
			var_24_1 = var_24_1 + 1
		elseif var_24_3 then
			var_24_2 = true
		end
	end

	if var_24_1 == 2 then
		self.skinCon_:SetSelectedIndex(2)
	elseif var_24_2 then
		self.skinCon_:SetSelectedIndex(1)
	else
		self.skinCon_:SetSelectedIndex(0)
	end
end

function RogueCardGameHomeView:OnRefreshDLC()
	self:RefreshDLCState()
end

function RogueCardGameHomeView:AddTimer()
	self:taskStopTimer()

	local var_26_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUECARD_TASK)
	local var_26_1 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUECARD_SKIN)

	self.taskTimeText_.text = manager.time:GetLostTimeStr(var_26_0.stopTime, true)
	self.skinTimeText_.text = manager.time:GetLostTimeStr(var_26_1.stopTime, true)

	SetActive(self.rewardGo_, var_26_0.stopTime >= manager.time:GetServerTime())
	SetActive(self.dlcGo_, var_26_1.stopTime >= manager.time:GetServerTime())

	self.tasktimer_ = Timer.New(function()
		self.taskTimeText_.text = manager.time:GetLostTimeStr(var_26_0.stopTime, true)
		self.skinTimeText_.text = manager.time:GetLostTimeStr(var_26_1.stopTime, true)
	end, 1, -1)

	self.tasktimer_:Start()
end

function RogueCardGameHomeView:taskStopTimer()
	if self.tasktimer_ then
		self.tasktimer_:Stop()

		self.tasktimer_ = nil
	end
end

function RogueCardGameHomeView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RogueCardGameHomeView:BindRedPoint()
	return
end

function RogueCardGameHomeView:UnBindRedPoint()
	return
end

function RogueCardGameHomeView:OnTop()
	self.forumBtn_.enabled = true
	self.rewardBtn_.enabled = true
	self.skinBtn_.enabled = true
	self.recordBtn_.enabled = true
	self.challengeBtn_.enabled = true
	self.challengeLock_.enabled = true
	self.illustratedBtn_.enabled = true

	self:UpdateTimeTxt()
	self:StopUpdateTimer()

	self.updateTimer = Timer.New(function()
		self:UpdateTimeTxt()
	end, 1, -1)

	self.updateTimer:Start()
	self:UpdateBar()
end

function RogueCardGameHomeView:OnExit()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK)
	manager.redPoint:unbindUIandKey(self.illustratedBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_RESIDENT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_5_0)
	manager.redPoint:unbindUIandKey(self.skinBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onRefreshDLCHandler)
	manager.redPoint:unbindUIandKey(self.recordBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED)
	manager.windowBar:HideBar()
	TimelineTools.StopAllCallBack()
	self:taskStopTimer()
	self:StopUpdateTimer()
	self:StopTimer()
	self:StopBtnTimer()
	self:UnBindRedPoint()
	RogueCardGameHomeView.super.OnExit(self)
end

function RogueCardGameHomeView:Dispose()
	self:RemoveAllListeners()
	RogueCardGameHomeView.super.Dispose(self)
end

return RogueCardGameHomeView
