local CommonTaskPopView = class("CommonTaskPopView", ReduxView)

function CommonTaskPopView:UIName()
	if self.params_.prefab then
		return self.params_.prefab
	end

	return "Widget/Common/Pop/CommonTask"
end

function CommonTaskPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CommonTaskPopView:InitModule(arg_3_1)
	local var_3_0 = nullable(self.constVar, "taskListModule")

	if arg_3_1 then
		local var_3_1 = CommonActivityTaskListModule or CommonTaskListModule

		if var_3_0 and var_3_0.class ~= var_3_1 then
			var_3_0:Dispose()

			var_3_0 = nil
		end

		if var_3_0 == nil then
			self.constVar.taskListModule = var_3_1.New(self.taskListModule_ or self.m_taskList or self.gameObject_)
		end
	end
end

function CommonTaskPopView:InitContext()
	self.constVar = {
		taskIdList = {}
	}

	self:InitModule(self.params_.activityId)
end

function CommonTaskPopView:BuildContext()
	self.data = {
		activityId = self.params_.activityId,
		taskType = self.params_.taskType
	}
end

function CommonTaskPopView:Init()
	self:BindCfgUI()
	self:InitContext()
	self:AddUIListener()
end

function CommonTaskPopView:OnEnter()
	self:BuildContext()
	self.constVar.taskListModule:OnEnter()

	if self.data.activityId then
		self.constVar.taskListModule:RenderView(self.data.activityId)
	elseif self.data.taskType then
		self.constVar.taskListModule:RenderTypeTaskList(self.data.taskType)
	end
end

function CommonTaskPopView:OnExit()
	self.constVar.taskListModule:OnExit()
end

function CommonTaskPopView:Dispose()
	CommonTaskPopView.super.Dispose(self)
	self.constVar.taskListModule:Dispose()
	CommonTaskPopView.super.Dispose(self)
end

function CommonTaskPopView:AddUIListener()
	local var_10_0 = self.backBtn_ or self.m_mask

	if var_10_0 then
		self:AddBtnListener(var_10_0, nil, function()
			self:Back()
		end)
	end
end

function CommonTaskPopView:Cacheable()
	return false
end

function CommonTaskPopView:OnExitInput()
	JumpTools.Back()

	return true
end

return CommonTaskPopView
