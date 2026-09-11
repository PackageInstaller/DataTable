local QWorldQuestCategory = class("QWorldQuestCategory", ReduxView)

function QWorldQuestCategory:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QWorldQuestCategory:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldQuestCategory:InitUI()
	self:BindCfgUI()

	self.typeController_ = self.conEx_:GetController("type")
end

function QWorldQuestCategory:AddUIListener()
	return
end

function QWorldQuestCategory:SetData(arg_5_1)
	if arg_5_1 == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
		self.typeController_:SetSelectedState("main")

		self.text_.text = GetTips("SANDPLAY_TASK_1")
	elseif arg_5_1 == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
		self.typeController_:SetSelectedState("side")

		self.text_.text = GetTips("SANDPLAY_TASK_2")
	elseif arg_5_1 == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
		self.typeController_:SetSelectedState("explore")

		self.text_.text = GetTips("SANDPLAY_TASK_3")
	end
end

function QWorldQuestCategory:Dispose()
	QWorldQuestCategory.super.Dispose(self)
end

return QWorldQuestCategory
