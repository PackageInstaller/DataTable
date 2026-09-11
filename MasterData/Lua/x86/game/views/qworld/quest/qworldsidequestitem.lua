local QWorldSideQuestItem = class("QWorldSideQuestItem", ReduxView)

function QWorldSideQuestItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldSideQuestItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldSideQuestItem:InitUI()
	self:BindCfgUI()

	if self.conEx_ then
		self.finishController_ = self.conEx_:GetController("complete")
	end
end

function QWorldSideQuestItem:AddUIListener()
	return
end

function QWorldSideQuestItem:SetData(arg_5_1)
	self.questId_ = arg_5_1

	self:RefreshUI()
end

function QWorldSideQuestItem:RefreshUI()
	self.objectiveText_.text = SandplayTaskCfg[self.questId_].task_target
	self.progressText_.text = QWorldQuestTool.GetQuestProgressText(self.questId_)

	if self.finishController_ then
		self.finishController_:SetSelectedState(QWorldQuestTool.GetQuestStatus(self.questId_) == QWorldQuestConst.QUEST_STATUS.FINISH and "true" or "false")
	end
end

function QWorldSideQuestItem:GetAnimator()
	return self.ani_
end

function QWorldSideQuestItem:Dispose()
	QWorldSideQuestItem.super.Dispose(self)
end

return QWorldSideQuestItem
