local CombineGameTaskView = class("CombineGameTaskView", ReduxView)

function CombineGameTaskView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfRewardsUI"
end

function CombineGameTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function CombineGameTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameTaskView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, CombineGameTaskItem)
	self.rewardController = ControllerUtil.GetController(self.gameObject_.transform, "reward")
end

function CombineGameTaskView:SetItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.taskList[arg_5_1], self.activityId)
end

function CombineGameTaskView:AddUIListener()
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

function CombineGameTaskView:OnEnter()
	if not ActivityData:GetActivityIsOpen((CombineGameData:GetDataByPara("activityId"))) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self.activityId = ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK

	self:AddEventListeners()
	self:UpdateView()
end

function CombineGameTaskView:UpdateView()
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
	self.rewardController:SetSelectedState(#TaskTools:GetCanGetActivityTaskList(self.activityId) > 0 and "true" or "false")
end

function CombineGameTaskView:GetTaskStatus(arg_12_1)
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

function CombineGameTaskView:BindRedPoint()
	return
end

function CombineGameTaskView:UnbindRedPoint()
	return
end

function CombineGameTaskView:AddEventListeners()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		self:UpdateView()
	end)
end

function CombineGameTaskView:OnExit()
	self:UnbindRedPoint()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function CombineGameTaskView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGameTaskView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	CombineGameTaskView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameTaskView
