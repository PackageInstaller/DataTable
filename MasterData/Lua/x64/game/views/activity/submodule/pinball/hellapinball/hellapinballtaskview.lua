local HellaPinballTaskView = class("HellaPinballTaskView", (import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonModule")))

function HellaPinballTaskView:UIName()
	return "Widget/System/Activity_Hel/Com/Activity_Hel_RewardTrustUI"
end

function HellaPinballTaskView:Init()
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
	self.levelLuaList_ = LuaList.New(handler(self, self.IndexItem), self.levelUilist_, HellaPinballTaskCommonItem)
	self.progressControlller_ = self.progressControllerEx_:GetController("progress")
end

function HellaPinballTaskView:SetActivityID()
	self.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_HELLA_PINBALL_MAIN
end

function HellaPinballTaskView:GetLevelInfo()
	return PinballData:GetRoleLevel(), #AssignmentCfg.get_id_list_by_activity_id[self.activityPointRewardActivityID_]
end

function HellaPinballTaskView:GetLevelIDList()
	return AssignmentCfg.get_id_list_by_activity_id[self.activityPointRewardActivityID_]
end

function HellaPinballTaskView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self:OnOnceBtnClick()
	end)
end

function HellaPinballTaskView:OnOnceBtnClick()
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

function HellaPinballTaskView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.curLv_, self.maxLv_ = self:GetLevelInfo()

	self:UpdateView()
	self:BindRedPoint()
	self:UpdateBar()
end

function HellaPinballTaskView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function HellaPinballTaskView:OnExit()
	HellaPinballTaskView.super.OnExit(self)
	manager.notify:RemoveListener(OSIRISPLAYGAME_UPDATE_TASK, self.taskUpdateHandler_)
end

function HellaPinballTaskView:Dispose()
	self.taskUpdateHandler_ = nil

	self.super.Dispose(self)
end

function HellaPinballTaskView:UpdateView()
	self.progress_ = PinballData:GetStageFinishProgress()
	self.progressSlider_.value = self.progress_

	if self.progress_ < 0.42 then
		self.progressControlller_:SetSelectedState("yellow")
	elseif self.progress_ < 0.67 then
		self.progressControlller_:SetSelectedState("orange")
	elseif self.progress_ < 1 then
		self.progressControlller_:SetSelectedState("red")
	else
		self.progressControlller_:SetSelectedState("green")
	end

	self.levelText_.text = math.floor(self.progress_ * 100) .. "%"
	self.receiveList_ = {}
	self.showIdList_ = {}

	for iter_14_0, iter_14_1 in ipairs(self.idList_) do
		local var_14_0 = ""

		self.taskProgress = TaskData2:GetTaskProgress(iter_14_1)
		self.taskComplete_ = TaskData2:GetTaskComplete(iter_14_1)

		if self.taskComplete_ then
			var_14_0 = "complete"
		elseif self.taskProgress >= AssignmentCfg[iter_14_1].need then
			var_14_0 = "receive"

			table.insert(self.receiveList_, iter_14_1)
		else
			var_14_0 = "lock"
		end

		table.insert(self.showIdList_, {
			id = iter_14_1,
			ind = iter_14_0,
			state = var_14_0
		})
	end

	local var_14_1 = 0

	for iter_14_2, iter_14_3 in ipairs(self.showIdList_) do
		if iter_14_3.state == "receive" then
			var_14_1 = iter_14_2

			break
		end
	end

	if var_14_1 <= 0 then
		for iter_14_4, iter_14_5 in ipairs(self.showIdList_) do
			if iter_14_5.state == "lock" then
				var_14_1 = iter_14_4

				break
			end
		end
	end

	self.levelLuaList_:StartScroll(#self.showIdList_, var_14_1)
	self.onekeyController_:SetSelectedState(#self.receiveList_ > 0 and "true" or "false")
end

function HellaPinballTaskView:TaskUpdate()
	self:GetLevelInfo()
	self:UpdateView()
end

function HellaPinballTaskView:OnTaskListChange()
	self:TaskUpdate()
end

return HellaPinballTaskView
