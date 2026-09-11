local HodurChapterSettlementView = class("HodurChapterSettlementView", ReduxView)

function HodurChapterSettlementView:UIName()
	return "Widget/System/Activity_Hodur/Activity_Hodur_GameOverPopUI"
end

function HodurChapterSettlementView:UIParent()
	return manager.ui.uiMain.transform
end

function HodurChapterSettlementView:Init()
	self.stageItemList_ = {}
	self.chapterID_ = self.params_.chapter_id or 1

	self:InitUI()
	self:AddUIListener()
end

function HodurChapterSettlementView:InitUI()
	self:BindCfgUI()
end

function HodurChapterSettlementView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:BackFunc()
	end)
end

function HodurChapterSettlementView:OnEnter()
	self:RefreshUI()
end

function HodurChapterSettlementView:RefreshUI()
	for iter_8_0 = 1, #ActivityHodurChapterCfg[self.chapterID_].stage_list do
		self.stageItemList_[iter_8_0] = self.stageItemList_[iter_8_0] or HodurMainlineSettlementItem.New((Object.Instantiate(self.stageItem_, self.itenContentTrs_)))

		self.stageItemList_[iter_8_0]:SetData(ActivityHodurChapterCfg[self.chapterID_].stage_list[iter_8_0][1])
		self.stageItemList_[iter_8_0]:SetActive(true)
	end

	for iter_8_1 = #ActivityHodurChapterCfg[self.chapterID_].stage_list + 1, #self.stageItemList_ do
		self.stageItemList_[iter_8_1]:SetActive(false)
	end
end

function HodurChapterSettlementView:OnTop()
	manager.windowBar:HideBar()
	manager.windowBar:RegistBackCallBack(function()
		self:BackFunc()
	end)
end

function HodurChapterSettlementView:BackFunc()
	if HodurTools.GetChapterState(self.chapterID_) == HodurConst.COMMON_STATE.PASS and not getData("activity_hodur", "hodur_story" .. ActivityHodurChapterCfg[self.chapterID_].story_id) and StoryCfg[ActivityHodurChapterCfg[self.chapterID_].story_id] then
		saveData("activity_hodur", "hodur_story" .. ActivityHodurChapterCfg[self.chapterID_].story_id, true)
		manager.story:StartStoryById(ActivityHodurChapterCfg[self.chapterID_].story_id, function()
			HodurTools.GotoMainlineView()
		end)
	else
		HodurTools.GotoMainlineView()
	end
end

function HodurChapterSettlementView:OnBehind()
	manager.windowBar:HideBar()
end

function HodurChapterSettlementView:OnExit()
	return
end

function HodurChapterSettlementView:Dispose()
	for iter_15_0 = 1, #self.stageItemList_ do
		self.stageItemList_[iter_15_0]:Dispose()
	end

	HodurChapterSettlementView.super.Dispose(self)
	self:RemoveAllListeners()
end

return HodurChapterSettlementView
