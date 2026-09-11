local MoonCakeTaskView = class("MoonCakeTaskView", ReduxView)

function MoonCakeTaskView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeTaskUI"
end

function MoonCakeTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function MoonCakeTaskView:Init()
	self.needAdaptRight_ = true

	self:InitUI()
	self:AddUIListener()
end

function MoonCakeTaskView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, MoonCakeTaskItem)
	self.taskUpdateHandler_ = handler(self, self.UpdateData)
	self.allReceiveController_ = ControllerUtil.GetController(self.transform_, "allReceive")
	self.selectController_ = ControllerUtil.GetController(self.stage1PanelTrans_, "select")
	self.stageController_ = ControllerUtil.GetController(self.transform_, "stage")
end

function MoonCakeTaskView:AddUIListener()
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(self.taskDataList_) do
			if iter_6_1.progress < AssignmentCfg[iter_6_1.id].need or iter_6_1.complete_flag >= 1 then
				break
			end

			var_6_0[#var_6_0 + 1] = iter_6_1.id
		end

		TaskAction:SubmitTaskList(var_6_0)
	end)
	self:AddBtnListener(self.activityTaskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.taskType_ == 1 then
			return
		end

		self:RefreshUI(1)
	end)
	self:AddBtnListener(self.playTaskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.taskType_ == 2 then
			return
		end

		self:RefreshUI(2)
	end)
end

function MoonCakeTaskView:Dispose()
	self.taskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	MoonCakeTaskView.super.Dispose(self)
end

function MoonCakeTaskView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.stage_ = self.params_.stage

	self.stageController_:SetSelectedIndex(self.stage_ - 1)

	self.taskActivityIDList_ = ActivityCfg[self.activityID_].sub_activity_list

	self:RefreshUI(1)
	self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	self:BindRedPoint()
end

function MoonCakeTaskView:OnExit()
	self.taskType_ = nil

	self:RemoveAllEventListener()
	self:UnBindRedPoint()
end

function MoonCakeTaskView:RefreshUI(arg_12_1)
	self.taskType_ = arg_12_1

	self.selectController_:SetSelectedIndex(arg_12_1 - 1)

	self.taskActivityID_ = self.taskActivityIDList_[self.taskType_]
	self.taskDataList_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self.scrollHelper_:StartScroll(#self.taskDataList_)
	self:RefreshReceiveBtn()
end

function MoonCakeTaskView:RefreshReceiveBtn()
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(self.taskDataList_) do
		if iter_13_1.progress >= AssignmentCfg[iter_13_1.id].need and iter_13_1.complete_flag < 1 then
			var_13_0 = 1

			break
		end
	end

	self.allReceiveController_:SetSelectedIndex(var_13_0)
end

function MoonCakeTaskView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.taskDataList_[arg_14_1].id, self.taskActivityID_)
end

function MoonCakeTaskView:UpdateData()
	self:RefreshUI(self.taskType_)

	if self.tempReceiveTaskID_ then
		self.tempReceiveTaskID_ = nil
		self.dropRewardList_ = {}

		local var_15_0 = {}

		for iter_15_0, iter_15_1 in ipairs(AssignmentCfg[self.tempReceiveTaskID_].reward) do
			if iter_15_1[1] == 30051 or iter_15_1[1] == 30052 then
				table.insert(var_15_0, {
					item_info = {
						id = iter_15_1[1],
						num = iter_15_1[2]
					},
					use_list = {}
				})
			end
		end

		CommonAction.TryToUseItem(var_15_0)
	end
end

function MoonCakeTaskView:BindRedPoint()
	if self.stage_ == 1 then
		manager.redPoint:bindUIandKey(self.activityTaskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskActivityIDList_[1])))
		manager.redPoint:bindUIandKey(self.playTaskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskActivityIDList_[2])))
	else
		manager.redPoint:bindUIandKey(self.activityTaskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskActivityIDList_[1])))
	end
end

function MoonCakeTaskView:UnBindRedPoint()
	if self.stage_ == 1 then
		manager.redPoint:unbindUIandKey(self.activityTaskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskActivityIDList_[1])))
		manager.redPoint:unbindUIandKey(self.playTaskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskActivityIDList_[2])))
	else
		manager.redPoint:unbindUIandKey(self.activityTaskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskActivityIDList_[1])))
	end
end

return MoonCakeTaskView
