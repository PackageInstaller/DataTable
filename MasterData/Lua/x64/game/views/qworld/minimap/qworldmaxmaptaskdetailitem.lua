local QWorldMaxMapTaskDetailItem = class("QWorldMaxMapTaskDetailItem", ReduxView)

function QWorldMaxMapTaskDetailItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldMaxMapTaskDetailItem:Init()
	self:BindCfgUI()

	self.finishController_ = self.m_controller:GetController("compelet")
end

function QWorldMaxMapTaskDetailItem:SetData(arg_3_1)
	self.questId_ = arg_3_1

	self:RefreshUI()
end

function QWorldMaxMapTaskDetailItem:RefreshUI()
	self.m_text.text = SandplayTaskCfg[self.questId_].task_target

	self.finishController_:SetSelectedState(QWorldQuestTool.GetQuestStatus(self.questId_) == QWorldQuestConst.QUEST_STATUS.FINISH and "true" or "false")
end

return QWorldMaxMapTaskDetailItem
