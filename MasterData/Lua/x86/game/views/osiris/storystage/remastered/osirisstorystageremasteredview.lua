local OsirisStoryStageRemasteredView = class("OsirisStoryStageRemasteredView", (import("game.views.osiris.storyStage.section.OsirisStoryStageView")))

function OsirisStoryStageRemasteredView:Init()
	OsirisStoryStageRemasteredView.super.Init(self)

	self.controller_ = ControllerUtil.GetController(self.transform_, "active")

	self.controller_:SetSelectedState("off")

	self.switchChapterView_ = SubPlotSwitchChapterView.New(self.chooseGo_, self.extraStoryBtn_)
	self.extraStoryView_ = SubPlotExtraStoryBtn.New(self.extraStoryGo_)
end

function OsirisStoryStageRemasteredView:OnEnter()
	OsirisStoryStageRemasteredView.super.OnEnter(self)
	self.switchChapterView_:OnEnter()
	self.extraStoryView_:OnEnter()
end

function OsirisStoryStageRemasteredView:OnExit()
	OsirisStoryStageRemasteredView.super.OnExit(self)
	self.switchChapterView_:OnExit()
	self.extraStoryView_:OnExit()
end

function OsirisStoryStageRemasteredView:Dispose()
	self.switchChapterView_:Dispose()

	self.switchChapterView_ = nil

	self.extraStoryView_:Dispose()

	self.extraStoryView_ = nil

	OsirisStoryStageRemasteredView.super.Dispose(self)
end

function OsirisStoryStageRemasteredView:RefreshData()
	self.chapterID_ = self.params_.chapterID == nil and BattleFieldData:GetCacheChapter(self.params_.chapterClientID) or self.params_.chapterID
	self.stageData_ = BattleStageData:GetStageData()
	self.stageList_ = ChapterCfg[self.chapterID_].section_id_list

	self.switchChapterView_:SetData(self.chapterID_)
	self.extraStoryView_:SetData(self.chapterID_)
end

function OsirisStoryStageRemasteredView:RefreshUI()
	self:RefreshMissionList()

	self.selectSection_ = BattleFieldData:GetCacheStage(self.chapterID_) or ChapterCfg[self.chapterID_].section_id_list[1]

	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	self:RefreshSelectItem()
	self.switchChapterView_:RefreshUI()
end

function OsirisStoryStageRemasteredView:GetSectionItemClass()
	return OsirisStoryStageRemasteredItem
end

function OsirisStoryStageRemasteredView:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

return OsirisStoryStageRemasteredView
