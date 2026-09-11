local SubPlotSectionView = class("SubPlotSectionView", import("..SectionBaseView"))

function SubPlotSectionView:Init()
	SubPlotSectionView.super.Init(self)

	self.changeChapterHandler_ = handler(self, self.ChangeChapter)
	self.stopMoveHandler_ = handler(self, self.StopMove)
end

function SubPlotSectionView:OnEnter()
	SubPlotSectionView.super.OnEnter(self)
	manager.notify:RegistListener(CHANGE_CHAPTER, self.changeChapterHandler_)
	manager.notify:RegistListener(CHAPTER_SCROLL_STOP, self.stopMoveHandler_)
	BattleStageAction.ClickSubPlot(self.chapterID_)
end

function SubPlotSectionView:OnExit()
	manager.notify:RemoveListener(CHAPTER_SCROLL_STOP, self.stopMoveHandler_)
	SubPlotSectionView.super.OnExit(self)
	manager.notify:RemoveListener(CHANGE_CHAPTER, self.changeChapterHandler_)
end

function SubPlotSectionView:ChangeChapter(arg_4_1)
	local var_4_0 = getChapterClientCfgByChapterID(arg_4_1)
	local var_4_1 = BattleFieldData:GetCacheStage(arg_4_1) or ChapterCfg[arg_4_1].section_id_list[1]

	if self.params_.section == var_4_1 and var_4_1 then
		return
	end

	self.params_.chapterID = arg_4_1
	self.params_.section = var_4_1

	BattleFieldData:SetStageByClientID(var_4_0.id, var_4_1)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(var_4_0.id), var_4_0.id)
	BattleFieldAction.ChangeSelectChapterID(arg_4_1)
	JumpTools.Jump2SubPlot(var_4_0.id, true)
end

function SubPlotSectionView:RefreshData()
	SubPlotSectionView.super.RefreshData(self)
end

function SubPlotSectionView:RefreshUI()
	SubPlotSectionView.super.RefreshUI(self)
	self:SwitchBG()
	self:RefreshText()
end

function SubPlotSectionView:StopMove()
	self.stopMove_ = true
end

function SubPlotSectionView:RefreshText()
	SetActive(self.titleGo_, true)

	self.chapterNameText_.text = ChapterCfg[self.chapterID_].subhead
end

function SubPlotSectionView:GetSectionItemClass()
	return SubPlotSectionItem
end

function SubPlotSectionView:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function SubPlotSectionView:GetCfgName()
	return BattleActivityStoryStageCfg
end

function SubPlotSectionView:Dispose()
	self.stopMoveHandler_ = nil
	self.changeChapterHandler_ = nil

	SubPlotSectionView.super.Dispose(self)
end

return SubPlotSectionView
