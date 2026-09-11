local SummerStoryRemasteredView = class("SummerStoryRemasteredView", (import("game.views.activity.Submodule.storyStage.summer.stage.mainStory.SummerStageMainView")))

function SummerStoryRemasteredView:GetStageItemClass()
	return SummerStoryRemasteredItem
end

function SummerStoryRemasteredView:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function SummerStoryRemasteredView:Init()
	SummerStoryRemasteredView.super.Init(self)

	self.controller_ = ControllerUtil.GetController(self.transform_, "active")

	self.controller_:SetSelectedState("off")
end

function SummerStoryRemasteredView:RefreshData()
	self.chapterID_ = self.params_.chapterID == nil and BattleFieldData:GetCacheChapter(ChapterClientCfg[self.params_.chapterClientID].id) or self.params_.chapterID
	self.stageData_ = BattleStageData:GetStageData()
	self.stageList_ = ChapterCfg[self.chapterID_].section_id_list
end

function SummerStoryRemasteredView:RefreshUI()
	self.selectStageID_ = BattleFieldData:GetCacheStage(self.chapterID_) or ChapterCfg[self.chapterID_].section_id_list[1]

	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	self:RefreshSelectItem()
end

function SummerStoryRemasteredView:RefreshStageList()
	for iter_6_0 = 1, #self.stageItem_ do
		self.stageItem_[iter_6_0]:Show(false)
	end

	local var_6_0 = BattleStageData:GetStageData()

	for iter_6_1 = 1, #self.stageList_ do
		if iter_6_1 == 1 or var_6_0[self.stageList_[iter_6_1]] then
			self.stageItem_[iter_6_1] = self.stageItem_[iter_6_1] or self:GetStageItemClass().New(self.itemGo_, self.content_)

			self.stageItem_[iter_6_1]:SetData(self.stageList_[iter_6_1], self.chapterID_)
		end
	end
end

return SummerStoryRemasteredView
