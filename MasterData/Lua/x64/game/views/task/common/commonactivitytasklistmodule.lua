local CommonActivityTaskListModule = class("CommonActivityTaskListModule", ReduxView)

function CommonActivityTaskListModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CommonActivityTaskListModule:InitContext()
	local var_2_0 = {
		taskList = {}
	}

	var_2_0.scrollHelper = LuaList.New(handler(self, self.OnRenderTask), self.taskList_ or self.m_list, CommonActivityTaskItem)
	self.constVar = var_2_0
end

function CommonActivityTaskListModule:BuildContext()
	self.renderContext = {
		activityId = 0
	}
	self.constVar.taskList = {}
end

function CommonActivityTaskListModule:Init()
	self:BindCfgUI()

	if self.controllers_ then
		self.onceController = self.controllers_:GetController("oneclick") or self.controllers_:GetController("once")
		self.clearController = self.controllers_:GetController("clear")
	end

	self:InitContext()
	self:AddUIListener()
end

function CommonActivityTaskListModule:AddUIListener()
	local var_5_0 = self.oneClickBtn_ or self.oneKeyBtn_

	if var_5_0 then
		self:AddBtnListener(var_5_0, nil, function()
			self:OnOnceBtnClick()
		end)
	end
end

function CommonActivityTaskListModule:RegisterTaskListChangedEvent(arg_7_1)
	self.constVar.changeEvent = arg_7_1
end

function CommonActivityTaskListModule:RenderView(arg_8_1)
	self:BuildContext()

	self.renderContext.activityId = arg_8_1

	local var_8_0 = TaskData2:GetActivityTaskSortList(arg_8_1)

	self.constVar.taskList = var_8_0
	self.renderContext.taskCount = #var_8_0

	self.constVar.scrollHelper:StartScroll(self.renderContext.taskCount, 1)
	self:ShowOnce()
end

function CommonActivityTaskListModule:RefreshView()
	self:RenderView(self.renderContext.activityId)
end

function CommonActivityTaskListModule:OnEnter()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshView()
		self:OnTaskListChanged()
	end)
	self:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		self:RefreshView()
		self:OnTaskListChanged()
	end)
end

function CommonActivityTaskListModule:OnExit()
	self:RemoveAllEventListener()
end

function CommonActivityTaskListModule:Dispose()
	CommonActivityTaskListModule.super.Dispose(self)
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	self.constVar.scrollHelper:Dispose()
end

function CommonActivityTaskListModule:OnRenderTask(arg_15_1, arg_15_2)
	arg_15_2:RefreshTaskItem(self.constVar.taskList[arg_15_1].id, arg_15_1)
end

function CommonActivityTaskListModule:OnTaskListChanged()
	if self.constVar.changeEvent then
		self.constVar.changeEvent()
	end
end

function CommonActivityTaskListModule:ShowOnce()
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(self.constVar.taskList) do
		if TaskData2:GetTaskProgress(iter_17_1.id) >= AssignmentCfg[iter_17_1.id].need and not TaskData2:GetTaskComplete(iter_17_1.id) then
			var_17_0 = var_17_0 + 1
		end
	end

	self:SetShowOnceState(var_17_0 > 0)
end

function CommonActivityTaskListModule:SetShowOnceState(arg_18_1)
	if self.onceController then
		self.onceController:SetSelectedState(arg_18_1 and "show" or "hide")
	elseif self.clearController then
		self.clearController:SetSelectedState(arg_18_1 and "true" or "false")
	elseif self.oneKeyObj_ then
		SetActive(self.oneKeyObj_, arg_18_1)
	end
end

function CommonActivityTaskListModule:OnOnceBtnClick()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(self.constVar.taskList) do
		if TaskData2:GetTaskProgress(iter_19_1.id) >= AssignmentCfg[iter_19_1.id].need and not TaskData2:GetTaskComplete(iter_19_1.id) then
			table.insert(var_19_0, iter_19_1.id)
		end
	end

	if #var_19_0 > 0 then
		TaskAction:SubmitTaskList(var_19_0)
	end
end

return CommonActivityTaskListModule
