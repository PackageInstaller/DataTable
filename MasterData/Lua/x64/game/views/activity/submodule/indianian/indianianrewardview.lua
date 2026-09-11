local IndiaNianRewardView = class("IndiaNianRewardView", ReduxView)

function IndiaNianRewardView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfRewardsUI"
end

function IndiaNianRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function IndiaNianRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IndiaNianRewardView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, CombineGameTaskItem)
end

function IndiaNianRewardView:SetItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.taskList[arg_5_1], self.activityId)
	arg_5_2:HideBar()
end

function IndiaNianRewardView:AddUIListener()
	self:AddBtnListener(self.allGetBtn_, nil, function()
		local var_7_0 = TaskTools:GetCanGetActivityTaskList(self.activityId)

		if #var_7_0 <= 0 then
			return
		end

		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			table.insert(var_7_1, iter_7_1.id)
		end

		TaskAction:SubmitTaskList(var_7_1)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function IndiaNianRewardView:OnEnter()
	self.activityId = IndiaNianData:GetActivityID()

	self:AddEventListeners()
	self:UpdateView()
end

function IndiaNianRewardView:UpdateView()
	self.taskList = {}

	table.insertto(self.taskList, AssignmentCfg.get_id_list_by_activity_id[self.activityId], 1)
	table.sort(self.taskList, function(arg_11_0, arg_11_1)
		local var_11_0 = self:GetTaskStatus(arg_11_0)
		local var_11_1 = self:GetTaskStatus(arg_11_1)

		if var_11_0 ~= var_11_1 then
			return var_11_0 < var_11_1
		end

		local var_11_2 = AssignmentCfg[arg_11_0]
		local var_11_3 = AssignmentCfg[arg_11_1]

		if AssignmentCfg[arg_11_0].type ~= AssignmentCfg[arg_11_1].type then
			return var_11_2.type < var_11_3.type
		end

		return var_11_2.id < var_11_3.id
	end)
	self.list:StartScroll(#self.taskList)
	SetActive(self.oneKeyGo_, #TaskTools:GetCanGetActivityTaskList(self.activityId) > 0)
end

function IndiaNianRewardView:GetTaskStatus(arg_12_1)
	local var_12_0 = TaskData2:GetTask(arg_12_1)

	if not var_12_0 then
		return 0
	end

	local var_12_1 = var_12_0.progress

	if var_12_0 ~= nil and TaskData2:GetTaskComplete(arg_12_1) then
		return 3
	elseif var_12_1 >= AssignmentCfg[arg_12_1].need then
		return 1
	else
		return 2
	end
end

function IndiaNianRewardView:BindRedPoint()
	return
end

function IndiaNianRewardView:UnbindRedPoint()
	return
end

function IndiaNianRewardView:AddEventListeners()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		self:UpdateView()
	end)
end

function IndiaNianRewardView:OnExit()
	self:UnbindRedPoint()
	self:RemoveAllEventListener()
end

function IndiaNianRewardView:OnTop()
	return
end

function IndiaNianRewardView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	IndiaNianRewardView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return IndiaNianRewardView
