local RogueCardGameRecordView = class("RogueCardGameRecordView", (import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonModule")))

function RogueCardGameRecordView:UIName()
	return "Widget/System/Activity_JokerCard/JokerCard_Com/Activity_JokerCard_RewardTrustUI"
end

function RogueCardGameRecordView:Init()
	self:InitUI()
	self:AddUIListener()
	self:SetActivityID()

	self.idList_ = self:GetLevelIDList()
	self.receiveList_ = {}
	self.showIdList_ = {}
	self.curLv_ = 0
	self.maxLv_ = 0
	self.onekeyController_ = self.mainControllerEx_:GetController("onekey")
	self.taskUpdateHandler_ = handler(self, self.TaskUpdate)
	self.levelLuaList_ = LuaList.New(handler(self, self.IndexItem), self.levelUilist_, RogueCardGameRecordTaskItem)
end

function RogueCardGameRecordView:SetActivityID()
	self.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_ROGUECARD_5_0
end

function RogueCardGameRecordView:GetLevelInfo()
	return TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_ROGUECARD_5_0), #self:GetLevelIDList()
end

function RogueCardGameRecordView:GetLevelIDList()
	return AssignmentCfg.get_id_list_by_activity_id[self.activityPointRewardActivityID_]
end

function RogueCardGameRecordView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self:OnOnceBtnClick()
	end)
end

function RogueCardGameRecordView:OnOnceBtnClick()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self.showIdList_) do
		if TaskData2:GetTaskProgress(iter_8_1.id) >= AssignmentCfg[iter_8_1.id].need and not TaskData2:GetTaskComplete(iter_8_1.id) then
			table.insert(var_8_0, iter_8_1.id)
		end
	end

	if #var_8_0 > 0 then
		TaskAction:SubmitTaskList(var_8_0)
	end
end

function RogueCardGameRecordView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.curLv_, self.maxLv_ = self:GetLevelInfo()

	if self.progressImg_ then
		self.progressImg_.fillAmount = self.curLv_ / self.maxLv_
	end

	self:UpdateView()
	self:BindRedPoint()
	self:UpdateBar()
end

function RogueCardGameRecordView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function RogueCardGameRecordView:OnTop()
	self:UpdateTimeTxt()
	self:StopUpdateTimer()

	self.updateTimer = Timer.New(function()
		self:UpdateTimeTxt()
	end, 1, -1)

	self.updateTimer:Start()
	RogueCardGameRecordView.super.OnTop(self)
end

function RogueCardGameRecordView:StopUpdateTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end
end

function RogueCardGameRecordView:UpdateTimeTxt()
	local var_15_0 = os.time()
	local var_15_1 = os.date("!*t", var_15_0 + os.difftime(var_15_0, os.time(os.date("!*t", var_15_0))))

	self.dayText_.text = string.format("%s/%s", var_15_1.month, var_15_1.day)
	self.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function RogueCardGameRecordView:OnExit()
	self:StopUpdateTimer()
	RogueCardGameRecordView.super.OnExit(self)
	manager.notify:RemoveListener(OSIRISPLAYGAME_UPDATE_TASK, self.taskUpdateHandler_)
end

function RogueCardGameRecordView:Dispose()
	self.taskUpdateHandler_ = nil

	self.super.Dispose(self)
end

function RogueCardGameRecordView:UpdateView()
	self.levelText_.text = self.curLv_ .. "/" .. self.maxLv_
	self.receiveList_ = {}
	self.showIdList_ = {}

	for iter_18_0, iter_18_1 in ipairs(self.idList_) do
		local var_18_0 = ""

		self.taskProgress = TaskData2:GetTaskProgress(iter_18_1)
		self.taskComplete_ = TaskData2:GetTaskComplete(iter_18_1)

		if self.taskComplete_ then
			var_18_0 = "complete"
		elseif self.taskProgress >= AssignmentCfg[iter_18_1].need then
			var_18_0 = "receive"

			table.insert(self.receiveList_, iter_18_1)
		else
			var_18_0 = "lock"
		end

		table.insert(self.showIdList_, {
			id = iter_18_1,
			ind = iter_18_0,
			state = var_18_0
		})
	end

	local var_18_1 = 0

	for iter_18_2, iter_18_3 in ipairs(self.showIdList_) do
		if iter_18_3.state == "receive" then
			var_18_1 = iter_18_2

			break
		end
	end

	if var_18_1 <= 0 then
		for iter_18_4, iter_18_5 in ipairs(self.showIdList_) do
			if iter_18_5.state == "lock" then
				var_18_1 = iter_18_4

				break
			end
		end
	end

	self.levelLuaList_:StartScroll(#self.showIdList_, var_18_1)
	self.onekeyController_:SetSelectedState(#self.receiveList_ > 0 and "true" or "false")
end

function RogueCardGameRecordView:TaskUpdate()
	self:GetLevelInfo()
	self:UpdateView()
end

function RogueCardGameRecordView:OnTaskListChange()
	self:TaskUpdate()
end

return RogueCardGameRecordView
