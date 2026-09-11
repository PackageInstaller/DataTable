local RecallSystemTaskView = class("RecallSystemTaskView", (import("game.views.recall.pages.RecallPageBase")))

function RecallSystemTaskView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function RecallSystemTaskView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, RecallSystemMissionItem)
end

function RecallSystemTaskView:IndexItem(arg_3_1, arg_3_2)
	arg_3_2:SetData(ActivityRecallData:GetDataByPara("taskList")[arg_3_1])
end

function RecallSystemTaskView:OnTop()
	return
end

function RecallSystemTaskView:UpdateView()
	ActivityRecallData:UpdateTaskData()
	ActivityRecallData:TaskSort()
	self.list_:StartScroll(#ActivityRecallData:GetDataByPara("taskList"))

	self.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("taskTime")
end

function RecallSystemTaskView:OnEnter()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.UpdateView))
	self:UpdateView()
end

function RecallSystemTaskView:OnExit()
	self:RemoveAllEventListener()

	self.handler_ = nil
end

function RecallSystemTaskView:Hide()
	RecallSystemTaskView.super.Hide(self)
end

function RecallSystemTaskView:Dispose()
	self:RemoveAllEventListener()

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RecallSystemTaskView.super.Dispose(self)
end

return RecallSystemTaskView
