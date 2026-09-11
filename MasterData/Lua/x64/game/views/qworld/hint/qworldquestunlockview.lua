local QWorldQuestUnlockView = class("QWorldQuestUnlockView", QWorldHintBaseView)

function QWorldQuestUnlockView:UIName()
	return "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_QuestUnlock"
end

function QWorldQuestUnlockView:InitUI()
	self.typeController_ = self.conEx_:GetController("quest")

	self:AddBtnListener(self.trackBtn_, nil, function()
		if self.mainQuestId_ == QWorldQuestTool.GetMainQuestTrackingId() then
			return
		end

		QWorldQuestAction.UpdateTrackingMainQuestId(self.mainQuestId_, function()
			QWorldQuestAction.SendUpdateQuestTrackToSdk(self.mainQuestId_, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
		end)
	end)
end

function QWorldQuestUnlockView:SetData(arg_5_1)
	self.mainQuestId_ = arg_5_1
end

function QWorldQuestUnlockView:RefreshUI()
	local var_6_0 = SandplayTaskMainCfg[self.mainQuestId_]

	if SandplayTaskMainCfg[self.mainQuestId_].main_task_type == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
		self.typeController_:SetSelectedState("main")
	elseif SandplayTaskMainCfg[self.mainQuestId_].main_task_type == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
		self.typeController_:SetSelectedState("side")
	elseif SandplayTaskMainCfg[self.mainQuestId_].main_task_type == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
		self.typeController_:SetSelectedState("explore")
	end

	self.questText_.text = var_6_0.title
	self.trackText_.text = GetTips("SANDPLAY_TIP_TRACK")
end

return QWorldQuestUnlockView
