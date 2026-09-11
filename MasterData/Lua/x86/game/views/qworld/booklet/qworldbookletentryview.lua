local QWorldBookletEntryView = class("QWorldBookletEntryView", ReduxView)

function QWorldBookletEntryView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_CollectBookMainUI"
end

function QWorldBookletEntryView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldBookletEntryView:Init()
	self:InitUI()
	self:AddUIListener()

	self.rewardBtnActive_ = true
	self.curLv_ = 0
	self.maxLv_ = 0
	self.ndnavigationController_ = self.mainControllerEx_:GetController("ndnavigation")
	self.seaWarfareTitle_.text = SandPlaySystemCfg[QWorldSystemConst.SEA_WARFARE].name
	self.seaWarfareTitle_2.text = SandPlaySystemCfg[QWorldSystemConst.SEA_WARFARE].name
	self.bookNameText.text = QWorldBookletTools.GetBookletSystemName()
	self.bookNameText_.text = QWorldBookletTools.GetBookletSystemName()
end

function QWorldBookletEntryView:InitUI()
	self:BindCfgUI()
end

function QWorldBookletEntryView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/quanZhouLimitTimeTaskView", {
			activityID = ActivityConst.ACTIVITY_QUANZHOU_TASK
		})
	end)
	self:AddBtnListener(self.mainBtn_, nil, function()
		JumpTools.OpenPageByJump("/qWorldBookletMain")
	end)
	self:AddBtnListener(self.sailingBtn_, nil, function()
		if not self.seawarfareUnlock_ then
			ShowTips("GOON_STORY_TO_GET")

			return
		end

		SeaWarfareTools.GotoChallengeStage()
	end)
end

function QWorldBookletEntryView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
	QWorldMgr:GetQWorldPerformMgr():ForceStopPlayerPerform(nil, true)
	QWorldMgr:EnableCamera(QWorldCameraFlag.FocusPlayer, "", QWorldCameraLayer.FocusPlayer)
	QWorldLuaBridge.HidePlayer(false)
	QWorldLuaBridge.EnterPlayerFocus(true)
	self:RefreshBookletPart()

	local var_9_0 = getData("QWorldBookletAnimData", "EntrySeaUnlockAnimHasPlayed") or 0

	self.seawarfareUnlock_ = SeaWarfareTools.IsSystemUnLock()

	if self.seawarfareUnlock_ then
		if var_9_0 == 1 then
			self.ndnavigationController_:SetSelectedState("unlock")
		else
			saveData("QWorldBookletAnimData", "EntrySeaUnlockAnimHasPlayed", 1)
			self.ndnavigationController_:SetSelectedState("lock")

			local var_9_1

			var_9_1 = FrameTimer.New(function()
				var_9_1:Stop()

				if self.ndnavigationController_ then
					self.ndnavigationController_:SetSelectedState("unlock")
				end
			end, 20, 1)

			;(nil):Start()
		end
	else
		self.ndnavigationController_:SetSelectedState("lock")
	end

	self:AwardRemainTime()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.QUANZHOU_LIMIT_TASK_ALL)
	manager.redPoint:bindUIandKey(self.bookletStageTrs_, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
end

function QWorldBookletEntryView:RefreshBookletPart()
	self.curLv_, self.maxLv_ = QWorldBookletTools.GetNdLevelInfo()
	self.mainLvText.text = self.curLv_ .. "<size=60>/" .. self.maxLv_ .. "</size>"
	self.mainLvText_.text = self.curLv_ .. "<size=60>/" .. self.maxLv_ .. "</size>"
	self.curStage_ = QWorldData:GetNowPhaseId()

	local var_12_0 = getData("QWorldBookletAnimData", "EntryViewStage") or 1

	if var_12_0 < self.curStage_ then
		saveData("QWorldBookletAnimData", "EntryViewStage", self.curStage_)

		self.stageImg_.spriteAsync = QuanzhouPhaseCfg[var_12_0].pic
		self.nextImg_.spriteAsync = QuanzhouPhaseCfg[self.curStage_].pic
		self.stageIconImg_.spriteAsync = QuanzhouPhaseCfg[var_12_0].icon
		self.nextIconImg_.spriteAsync = QuanzhouPhaseCfg[self.curStage_].icon
		self.stageNameText_.text = QuanzhouPhaseCfg[var_12_0].name
		self.nextNameText_.text = QuanzhouPhaseCfg[self.curStage_].name

		self.changePD_:Play()
		SetActive(self.yanhuaGo_, false)
		SetActive(self.yanhuaNextGo_, false)

		if self.curStage_ == 4 then
			local var_12_1

			var_12_1 = FrameTimer.New(function()
				var_12_1:Stop()

				if self.yanhuaNextGo_ then
					SetActive(self.yanhuaNextGo_, true)
				end
			end, 45, 1)

			;(nil):Start()
		end
	else
		SetActive(self.nextGo_, false)

		self.stageImg_.spriteAsync = QuanzhouPhaseCfg[self.curStage_].pic
		self.stageIconImg_.spriteAsync = QuanzhouPhaseCfg[self.curStage_].icon
		self.stageNameText_.text = QuanzhouPhaseCfg[self.curStage_].name

		self.normalPD_:Play()
		SetActive(self.yanhuaGo_, self.curStage_ == 4)
	end

	self.taskAnimator_.enabled = false

	for iter_12_0, iter_12_1 in ipairs(ActivityCfg[ActivityConst.ACTIVITY_QUANZHOU_TASK].sub_activity_list) do
		for iter_12_2, iter_12_3 in pairs(TaskTools:GetActivityTaskList(iter_12_1) or {}) do
			if iter_12_3.progress >= AssignmentCfg[iter_12_3.id].need and iter_12_3.complete_flag < 1 then
				self.taskAnimator_.enabled = true

				break
			end
		end
	end

	self:AwardRemainTime()
end

function QWorldBookletEntryView:AwardRemainTime()
	local var_14_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_QUANZHOU_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_QUANZHOU_TASK) then
		self.rewardTimeText_.text = manager.time:GetLostTimeStr2(var_14_0.stopTime)
	else
		if manager.time:GetServerTime() < var_14_0.startTime then
			self.rewardTimeText_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_14_0.startTime))
		elseif manager.time:GetServerTime() > var_14_0.stopTime then
			self.rewardTimeText_.text = GetTips("TIME_OVER")
		end

		if self.rewardBtnActive_ then
			SetActive(self.rewardBtn_.gameObject, false)

			self.rewardBtnActive_ = false
		end
	end

	self:StopAwardTimer()

	if self.awardTimer_ == nil then
		self.awardTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_QUANZHOU_TASK) then
				self.rewardTimeText_.text = manager.time:GetLostTimeStr2(var_14_0.stopTime)
			else
				if manager.time:GetServerTime() < var_14_0.startTime then
					self.rewardTimeText_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_14_0.startTime))
				elseif manager.time:GetServerTime() > var_14_0.stopTime then
					self.rewardTimeText_.text = GetTips("TIME_OVER")
				end

				if self.rewardBtnActive_ then
					SetActive(self.rewardBtn_.gameObject, false)

					self.rewardBtnActive_ = false
				end
			end
		end, 1, -1)
	end

	self.awardTimer_:Start()
end

function QWorldBookletEntryView:StopAwardTimer()
	if self.awardTimer_ then
		self.awardTimer_:Stop()

		self.awardTimer_ = nil
	end
end

function QWorldBookletEntryView:OnExit()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.QUANZHOU_LIMIT_TASK_ALL)
	manager.redPoint:unbindUIandKey(self.bookletStageTrs_, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
	self:StopAwardTimer()
	QWorldMgr:ExitFocusCamera()
	QWorldLuaBridge.EnterPlayerFocus(false)
	self:StopAwardTimer()
	manager.windowBar:HideBar()
end

function QWorldBookletEntryView:Dispose()
	QWorldBookletEntryView.super.Dispose(self)
end

return QWorldBookletEntryView
