local BlisterTaskView = class("BlisterTaskView", ReduxView)

function BlisterTaskView:UIName()
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_BlisterGameUI_QuestUI"
end

function BlisterTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function BlisterTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BlisterTaskView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, BlisterTaskItem)
	self.btnController_ = self.controller_:GetController("oneclick")
	self.onSubmitTaskHandle_ = handler(self, self.OnTaskRefresh)
	self.onSubmitTaskListHandle_ = handler(self, self.OnTaskRefresh)
end

function BlisterTaskView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.taskList_[arg_5_1])
end

function BlisterTaskView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.onClickBtn_, nil, function()
		TaskAction:SubmitTaskList(self.allRewards_)
	end)
end

function BlisterTaskView:OnTop()
	manager.windowBar:HideBar()
end

function BlisterTaskView:OnEnter()
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskListHandle_)

	self.taskActivityIdList_ = ActivityCfg[self.params_.taskActivityID].sub_activity_list

	self:UpdateList()
end

function BlisterTaskView:UpdateList()
	BlisterGameData:CheckRewardTaskList()

	self.taskList_ = BlisterGameData:GetTaskList()

	self.uiList_:StartScroll(#self.taskList_)

	self.allRewards_ = BlisterGameData:GetRewardTaskList()

	self.btnController_:SetSelectedState(tostring(#self.allRewards_ > 0))
end

function BlisterTaskView:OnTaskRefresh()
	BlisterGameData:CheckRewardTaskList()
	self:UpdateList()
end

function BlisterTaskView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskListHandle_)
	self:RemoveAllEventListener()
end

function BlisterTaskView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	BlisterTaskView.super.Dispose(self)
end

return BlisterTaskView
