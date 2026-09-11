local QWorldQuestItem = class("QWorldQuestItem", ReduxView)

function QWorldQuestItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldQuestItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.finishController_ = self.conEx_:GetController("finish")
end

function QWorldQuestItem:InitUI()
	self:BindCfgUI()
end

function QWorldQuestItem:AddUIListener()
	return
end

function QWorldQuestItem:SetData(arg_5_1)
	self.questId_ = arg_5_1

	self:RefreshUI()
end

function QWorldQuestItem:RefreshUI()
	self.objectiveText_.text = SandplayTaskCfg[self.questId_].task_target
	self.progressText_.text = QWorldQuestTool.GetQuestProgressText(self.questId_)

	self.finishController_:SetSelectedState(QWorldQuestTool.GetQuestStatus(self.questId_) == QWorldQuestConst.QUEST_STATUS.FINISH and "true" or "false")
end

function QWorldQuestItem:Dispose()
	QWorldQuestItem.super.Dispose(self)
end

return QWorldQuestItem
