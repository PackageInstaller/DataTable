local CommonTaskListModule = class("CommonTaskListModule", ReduxView)

function CommonTaskListModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CommonTaskListModule:InitContext()
	local var_2_0 = {
		taskList = {}
	}

	var_2_0.scrollHelper = LuaList.New(handler(self, self.OnRenderTask), self.taskList_ or self.m_list, CommonTaskItemModule)
	self.constVar = var_2_0
	self.RenderType = {
		Type = 2,
		Activity = 1,
		OriginTask = 3,
		None = 0
	}
end

function CommonTaskListModule:BuildContext()
	self.renderContext = {
		taskCount = 0,
		activityId = 0,
		taskType = 0,
		renderType = self.RenderType.None
	}
	self.constVar.taskList = {}
end

function CommonTaskListModule:Init()
	self:BindCfgUI()
	self:InitContext()
end

function CommonTaskListModule:RegisterTaskListChangedEvent(arg_5_1)
	self.constVar.changeEvent = arg_5_1
end

function CommonTaskListModule:GetActivityTaskList(arg_6_1, arg_6_2)
	if arg_6_2 < 0 then
		return
	end

	TaskData2:AddActivityTaskToList(self, arg_6_1)

	for iter_6_0, iter_6_1 in ipairs((ActivityTools.GetAllTaskSubActivityID(arg_6_1))) do
		CommonTaskListModule.GetActivityTaskList(self, iter_6_1, arg_6_2 - 1)
	end
end

function CommonTaskListModule:RenderActivityTaskList(arg_7_1)
	self:BuildContext()

	self.renderContext.renderType = self.RenderType.Activity
	self.renderContext.activityId = arg_7_1

	local var_7_0 = {}

	CommonTaskListModule.GetActivityTaskList(var_7_0, arg_7_1, 1)
	TaskData2:SortTaskInfo(var_7_0)

	self.constVar.taskList = var_7_0
	self.renderContext.taskCount = #var_7_0

	self:RenderView()
end

function CommonTaskListModule:RenderTypeTaskList(arg_8_1)
	self:BuildContext()

	self.renderContext.renderType = self.RenderType.Type
	self.renderContext.taskType = arg_8_1

	local var_8_0 = TaskData2:GetTypedTaskSortList(arg_8_1)

	self.constVar.taskList = var_8_0
	self.renderContext.taskCount = #var_8_0

	self:RenderView()
end

function CommonTaskListModule:RenderView()
	self.constVar.scrollHelper:StartScroll(self.renderContext.taskCount, 1)
end

function CommonTaskListModule:RefreshView()
	if self.renderContext.renderType == self.RenderType.Type then
		self:RenderTypeTaskList(self.renderContext.taskType)
	elseif self.renderContext.renderType == self.RenderType.Activity then
		self:RenderActivityTaskList(self.renderContext.activityId)
	end
end

function CommonTaskListModule:OnEnter()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshView()
		self:OnTaskListChanged()
	end)
	self:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		self:RefreshView()
		self:OnTaskListChanged()
	end)
end

function CommonTaskListModule:OnExit()
	self:RemoveAllEventListener()
end

function CommonTaskListModule:Dispose()
	self:RemoveAllEventListener()
	self.constVar.scrollHelper:Dispose()
	CommonTaskListModule.super.Dispose(self)
end

function CommonTaskListModule:OnRenderTask(arg_16_1, arg_16_2)
	arg_16_2:RefreshTaskItem(self.constVar.taskList[arg_16_1].id, arg_16_1)
end

function CommonTaskListModule:OnTaskListChanged()
	if self.constVar.changeEvent then
		self.constVar.changeEvent()
	end
end

return CommonTaskListModule
