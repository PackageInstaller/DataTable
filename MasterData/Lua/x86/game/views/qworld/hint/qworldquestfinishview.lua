local QWorldQuestFinishView = class("QWorldQuestFinishView", QWorldHintBaseView)

function QWorldQuestFinishView:UIName()
	return "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_QuestClear"
end

function QWorldQuestFinishView:InitUI()
	self.typeController_ = self.conEx_:GetController("quest")
	self.seriesController_ = self.conEx_:GetController("series")
end

function QWorldQuestFinishView:SetData(arg_3_1)
	self.mainQuestId_ = arg_3_1
end

function QWorldQuestFinishView:RefreshUI()
	self.questExploreText_.text = SandplayTaskChapterCfg[SandplayTaskMainCfg[self.mainQuestId_].chapter_task_id] and GetTipsF("SANDPLAY_TIP_SERIES_COMPLETE", GetI18NText(SandplayTaskChapterCfg[SandplayTaskMainCfg[self.mainQuestId_].chapter_task_id].chapter_name)) or GetTips("ERROR_BAD_TEMPLATE")
end

return QWorldQuestFinishView
