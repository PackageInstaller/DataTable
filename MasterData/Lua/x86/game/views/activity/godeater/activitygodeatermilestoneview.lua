CommonTaskPopView = import("game.views.task.pop.CommonTaskPopView")

local ActivityGodEaterMilestoneView = class("ActivityGodEaterMilestoneView", CommonTaskPopView)

function ActivityGodEaterMilestoneView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Bounty/V4_2_GodEaterUI_Bounty_QuestPopUI"
end

function ActivityGodEaterMilestoneView:Init()
	ActivityGodEaterMilestoneView.super.Init(self)

	self.btnControlller = self.v4_2_godeaterui_bounty_questpopuiControllerexcollection_:GetController("onekey")
end

function ActivityGodEaterMilestoneView:OnEnter()
	ActivityGodEaterMilestoneView.super.OnEnter(self)
	self:ResortList()
	self.constVar.taskListModule:RegisterTaskListChangedEvent(function()
		self:ResortList()
		GodEaterAction.UpdateRedPoint()
		self:UpdateOnekey()
	end)

	self.timer = Timer.New(function()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GODEATER_MAIN_KEY) then
			JumpTools.OpenPageByJump("/ActivityGodEaterGameMainView", {
				activity_id = ActivityConst.ACTIVITY_GODEATER_MAIN_KEY
			})
			ShowTips(GetTips("TIME_OVER"))

			return
		end
	end, 1)

	self:UpdateOnekey()
end

function ActivityGodEaterMilestoneView:ResortList()
	if self.data.activityId == ActivityConst.ACTIVITY_CIVILIZATION then
		return
	end

	table.sort(self.constVar.taskListModule.constVar.taskList, function(arg_7_0, arg_7_1)
		return arg_7_0.id < arg_7_1.id
	end)

	local var_6_0 = 1
	local var_6_1 = false
	local var_6_2 = 1
	local var_6_3 = {}

	for iter_6_0, iter_6_1 in ipairs(self.constVar.taskListModule.constVar.taskList) do
		if AssignmentCfg[iter_6_1.id].type == 3002 then
			table.insert(var_6_3, iter_6_1)
		end
	end

	self.constVar.taskListModule.constVar.taskList = var_6_3

	for iter_6_2, iter_6_3 in ipairs(self.constVar.taskListModule.constVar.taskList) do
		if iter_6_3.progress < AssignmentCfg[iter_6_3.id].need and iter_6_3.complete_flag == 0 and not false then
			var_6_2 = iter_6_2
		end

		if AssignmentCfg[iter_6_3.id].need <= iter_6_3.progress and iter_6_3.complete_flag == 0 and not var_6_1 then
			var_6_0 = iter_6_2
			var_6_1 = true
		end
	end

	self.constVar.taskListModule.constVar.scrollHelper:StartScroll(#self.constVar.taskListModule.constVar.taskList, (not var_6_1 or nil) and var_6_2)
end

function ActivityGodEaterMilestoneView:UpdateOnekey()
	if self.data.activityId == ActivityConst.ACTIVITY_CIVILIZATION then
		self.titleText_ = GetTips("GODEATER_CIVILIZATION_TASK_NAME")

		SetActive(self.titleGo_, false)
		SetActive(self.taskGo_, true)
	else
		self.titleText_ = GetTips("GODEATER_TASK_NAME")

		SetActive(self.titleGo_, true)
		SetActive(self.taskGo_, false)
	end

	self.oneKeyList = {}

	for iter_8_0, iter_8_1 in ipairs(self.constVar.taskListModule.constVar.taskList) do
		if iter_8_1.progress >= AssignmentCfg[iter_8_1.id].need and iter_8_1.complete_flag == 0 then
			table.insert(self.oneKeyList, iter_8_1.id)
		end
	end

	self.btnControlller:SetSelectedState(#self.oneKeyList > 0 and "true" or "false")
end

function ActivityGodEaterMilestoneView:OnExit()
	ActivityGodEaterMilestoneView.super.OnExit(self)
	self:StopTimer()
end

function ActivityGodEaterMilestoneView:AddUIListener()
	ActivityGodEaterMilestoneView.super.AddUIListener(self)
	self:AddBtnListener(self.btn01Btn_, nil, function()
		TaskAction:SubmitTaskList(self.oneKeyList)
	end)
	self:AddBtnListener(self.btn_backBtn_, nil, function()
		self:Back()
	end)
end

function ActivityGodEaterMilestoneView:Dispose()
	ActivityGodEaterMilestoneView.super.Dispose(self)
end

function ActivityGodEaterMilestoneView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityGodEaterMilestoneView
