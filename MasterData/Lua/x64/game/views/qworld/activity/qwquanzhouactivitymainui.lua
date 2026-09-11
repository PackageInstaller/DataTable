ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local QWActivityMainUI = class("QWActivityMainUI", ActivityMainBasePanel)

function QWActivityMainUI:GetUIName()
	return "Widget/Version/V4_0_1_QuanZhouUI_Com/QuanZhou_MainUI/QuanZhou_MainUI"
end

function QWActivityMainUI:isHasLeftTimeDes()
	return true
end

function QWActivityMainUI:OnEnter()
	QWActivityMainUI.super.OnEnter(self)
	self:AddEventListeners()
	self:UpdatePreview()
	self:RefreshUI()

	self.rewardBtnActive_ = true

	manager.redPoint:bindUIandKey(self.m_entrustBtn.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
	manager.redPoint:bindUIandKey(self.btnReward_.transform, RedPointConst.QUANZHOU_LIMIT_TASK_ALL)
end

function QWActivityMainUI:OnExit()
	QWActivityMainUI.super.OnExit(self)
	self:StopAwardTimer()
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.m_entrustBtn.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
	manager.redPoint:unbindUIandKey(self.btnReward_.transform, RedPointConst.QUANZHOU_LIMIT_TASK_ALL)
end

function QWActivityMainUI:AddListeners()
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		self:EnterQWorld()
	end)
	self:AddBtnListener(self.btnReward_, nil, function()
		JumpTools.OpenPageByJump("/quanZhouLimitTimeTaskView", {
			activityID = ActivityConst.ACTIVITY_QUANZHOU_TASK
		})
	end)
	self:BindHelpBtn("QUANZHOU_DESC")
end

function QWActivityMainUI:AddEventListeners()
	self:RegistEventListener(ACTIVITY_RED_ENVELOPE_NEW_DAY, function()
		self:RefreshUI()
	end)
end

function QWActivityMainUI:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function QWActivityMainUI:RefreshUI()
	self.entrustBtnTxt_.text = GetTips("BATTLE_READY_2")

	self:AwardRemainTime()
end

function QWActivityMainUI:AwardRemainTime()
	local var_12_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_QUANZHOU_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_QUANZHOU_TASK) then
		self.remainTime_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
	else
		if manager.time:GetServerTime() < var_12_0.startTime then
			self.remainTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_12_0.startTime))
		elseif manager.time:GetServerTime() > var_12_0.stopTime then
			self.remainTime_.text = GetTips("TIME_OVER")
		end

		if self.rewardBtnActive_ then
			SetActive(self.btnReward_.gameObject, false)

			self.rewardBtnActive_ = false
		end
	end

	self:StopAwardTimer()

	if self.awardTimer_ == nil then
		self.awardTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_QUANZHOU_TASK) then
				self.remainTime_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
			else
				if manager.time:GetServerTime() < var_12_0.startTime then
					self.remainTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_12_0.startTime))
				elseif manager.time:GetServerTime() > var_12_0.stopTime then
					self.remainTime_.text = GetTips("TIME_OVER")
				end

				if self.rewardBtnActive_ then
					SetActive(self.btnReward_.gameObject, false)

					self.rewardBtnActive_ = false
				end
			end
		end, 1, -1)
	end

	self.awardTimer_:Start()

	self.taskAnimator_.enabled = false

	for iter_12_0, iter_12_1 in ipairs(ActivityCfg[ActivityConst.ACTIVITY_QUANZHOU_TASK].sub_activity_list) do
		for iter_12_2, iter_12_3 in pairs(TaskTools:GetActivityTaskList(iter_12_1) or {}) do
			if iter_12_3.progress >= AssignmentCfg[iter_12_3.id].need and iter_12_3.complete_flag < 1 then
				self.taskAnimator_.enabled = true

				break
			end
		end
	end
end

function QWActivityMainUI:StopAwardTimer()
	if self.awardTimer_ then
		self.awardTimer_:Stop()

		self.awardTimer_ = nil
	end
end

function QWActivityMainUI:EnterQWorld()
	local var_15_0 = SandPlayMapCfg[QWorldMgr:GetActivityMap(self.activityID_)]
	local var_15_1 = var_15_0 and var_15_0.story_id

	if not (var_15_0 and var_15_0.story_id) or var_15_1 == 0 or manager.story:IsStoryPlayed(var_15_1) then
		LaunchQWorld(false, self.activityID_)
	else
		manager.story:StartStoryById(var_15_1, function()
			LaunchQWorld(false, self.activityID_)
		end)
	end
end

return QWActivityMainUI
