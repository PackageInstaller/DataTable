local PolyhedronTaskView = class("PolyhedronTaskView", ReduxView)

function PolyhedronTaskView:UIName()
	return "Widget/System/Polyhedron/PolyhedronTaskPopUI"
end

function PolyhedronTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function PolyhedronTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronTaskView:InitUI()
	self:BindCfgUI()

	self.taskListModule_ = CommonTaskListModule.New(self.comTaskList_)
	self.awardController_ = self.controller_:GetController("award")
end

function PolyhedronTaskView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		TaskTools:GetAllCanReciveTask(self.taskIDList_)
	end)
end

function PolyhedronTaskView:OnEnter()
	self.taskListModule_:OnEnter()

	self.activityID_ = PolyhedronData:GetActivityID()
	self.taskIDList_ = TaskTools:GetTaskIDList(TaskConst.TASK_TYPE.POLYHEDRON_RESIDENT_TASK)

	self:RegistEventListener(ACTIVITY_UPDATE, function(arg_10_0)
		if ActivityTemplateConst.POLYHEDRON_ACTIVITY == ActivityTools.GetActivityType(arg_10_0) then
			self.activityID_ = arg_10_0

			self:RefreshTaskList()
		end
	end)
	self:RefreshTaskList()
end

function PolyhedronTaskView:OnTop()
	self:RefreshReciveBtn()
end

function PolyhedronTaskView:RefreshReciveBtn()
	if #TaskTools:GetFinishTaskIDList(self.taskIDList_) > 0 then
		self.awardController_:SetSelectedState("show")
	else
		self.awardController_:SetSelectedState("close")
	end
end

function PolyhedronTaskView:RefreshTaskList()
	self.taskListModule_:RenderTypeTaskList(TaskConst.TASK_TYPE.POLYHEDRON_RESIDENT_TASK)
end

function PolyhedronTaskView:OnExit()
	self.taskListModule_:OnExit()
	self:RemoveAllEventListener()
end

function PolyhedronTaskView:Dispose()
	self.taskListModule_:Dispose()
	PolyhedronTaskView.super.Dispose(self)
end

return PolyhedronTaskView
