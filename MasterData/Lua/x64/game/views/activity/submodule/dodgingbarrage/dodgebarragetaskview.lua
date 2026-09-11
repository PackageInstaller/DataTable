local DodgeBarrageTaskView = class("DodgeBarrageTaskView", ReduxView)

function DodgeBarrageTaskView:UIName()
	return "Widget/Version/ShashwatUI_3_7/ShashwatUI_3_7_BarrageUI/ShashwatUI_3_7_RewardPopUI"
end

function DodgeBarrageTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function DodgeBarrageTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DodgeBarrageTaskView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, DodgeBarrageTaskItem)
	self.btnController_ = self.btnCon_:GetController("state")
	self.onSubmitTaskHandle_ = handler(self, self.OnTaskRefresh)
	self.onSubmitTaskListHandle_ = handler(self, self.OnTaskRefresh)
end

function DodgeBarrageTaskView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.taskList_[arg_5_1])
end

function DodgeBarrageTaskView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnReceiveAll_, nil, function()
		TaskAction:SubmitTaskList(self.allRewards_)
	end)
end

function DodgeBarrageTaskView:OnTop()
	manager.windowBar:HideBar()
end

function DodgeBarrageTaskView:OnEnter()
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskListHandle_)

	self.activityId_ = DodgeBarrageData:GetActivityId()

	self:UpdateList()
end

function DodgeBarrageTaskView:UpdateList()
	self.taskList_ = DodgeBarrageData:GetTaskList()

	self.uiList_:StartScroll(#self.taskList_)

	self.allRewards_ = DodgeBarrageData:GetRewardTaskList()

	self.btnController_:SetSelectedState(#self.allRewards_ <= 0 and "hide" or "show")
end

function DodgeBarrageTaskView:OnTaskRefresh()
	DodgeBarrageData:CheckRewardTaskList()
	self:UpdateList()
end

function DodgeBarrageTaskView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskListHandle_)
	self:RemoveAllEventListener()
end

function DodgeBarrageTaskView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	DodgeBarrageTaskView.super.Dispose(self)
end

return DodgeBarrageTaskView
