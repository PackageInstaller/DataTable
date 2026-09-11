local LimitTaskListModule = class("LimitTaskListModule", ReduxView)

function LimitTaskListModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.itemClassModule = arg_1_2

	self:Init()
end

function LimitTaskListModule:InitContext()
	local var_2_0 = {
		taskList = {}
	}

	var_2_0.scrollHelper = LuaList.New(handler(self, self.OnRenderTask), self.taskList_ or self.m_list, self.itemClassModule or LimitTaskItem)
	self.constVar = var_2_0
end

function LimitTaskListModule:BuildContext()
	self.renderContext = {
		activityId = 0
	}
	self.constVar.taskList = {}
end

function LimitTaskListModule:Init()
	self:BindCfgUI()

	if self.controllers_ then
		self.onceController = self.controllers_:GetController("oneclick") or self.controllers_:GetController("once")
	end

	self:InitContext()
	self:AddUIListener()
end

function LimitTaskListModule:AddUIListener()
	local var_5_0 = self.oneClickBtn_ or self.oneKeyBtn_

	if var_5_0 then
		self:AddBtnListener(var_5_0, nil, function()
			self:OnOnceBtnClick()
		end)
	end
end

function LimitTaskListModule:RegisterTaskListChangedEvent(arg_7_1)
	self.constVar.changeEvent = arg_7_1
end

function LimitTaskListModule:RenderView(arg_8_1)
	self:BuildContext()

	self.renderContext.activityId = arg_8_1

	local var_8_0 = TaskData2:GetActivityTaskSortList(arg_8_1)

	self.constVar.taskList = var_8_0
	self.renderContext.taskCount = #var_8_0

	self.constVar.scrollHelper:StartScroll(self.renderContext.taskCount, 1)
	self:ShowOnce()
end

function LimitTaskListModule:RefreshView()
	self:RenderView(self.renderContext.activityId)
end

function LimitTaskListModule:OnEnter()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshView()
		self:OnTaskListChanged()
	end)
	self:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		self:RefreshView()
		self:OnTaskListChanged()
	end)
end

function LimitTaskListModule:OnExit()
	self:RemoveAllEventListener()
end

function LimitTaskListModule:Dispose()
	LimitTaskListModule.super.Dispose(self)
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	self.constVar.scrollHelper:Dispose()
end

function LimitTaskListModule:OnRenderTask(arg_15_1, arg_15_2)
	arg_15_2:RefreshTaskItem(self.constVar.taskList[arg_15_1].id)
	arg_15_2:RefreshIndex(arg_15_1)
end

function LimitTaskListModule:OnTaskListChanged()
	if self.constVar.changeEvent then
		self.constVar.changeEvent()
	end
end

function LimitTaskListModule:ShowOnce()
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(self.constVar.taskList) do
		if TaskData2:GetTaskProgress(iter_17_1.id) >= AssignmentCfg[iter_17_1.id].need and not TaskData2:GetTaskComplete(iter_17_1.id) then
			var_17_0 = var_17_0 + 1
		end
	end

	self:SetShowOnceState(var_17_0 > 0)
end

function LimitTaskListModule:SetShowOnceState(arg_18_1)
	if self.onceController then
		self.onceController:SetSelectedState(arg_18_1 and "show" or "hide")
	elseif self.oneKeyObj_ then
		SetActive(self.oneKeyObj_, arg_18_1)
	end
end

function LimitTaskListModule:OnOnceBtnClick()
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

return LimitTaskListModule
