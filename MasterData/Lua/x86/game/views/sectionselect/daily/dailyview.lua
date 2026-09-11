local DailyView = class("DailyView", import("..SectionBaseView"))

function DailyView:Init()
	DailyView.super.Init(self)

	self.switchChapterView_ = SubPlotSwitchChapterView.New(self.chooseGo_, self.extraStoryBtn_)
	self.changeChapterHandler_ = handler(self, self.SwitchDailyChapter)
end

function DailyView:OnEnter()
	DailyView.super.OnEnter(self)
	self.switchChapterView_:OnEnter()
	manager.notify:RegistListener(CHANGE_CHAPTER, self.changeChapterHandler_)
end

function DailyView:OnExit()
	DailyView.super.OnExit(self)
	self.switchChapterView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, self.changeChapterHandler_)
	OperationRecorder.RecordStayView("STAY_VIEW_SECTION", self:GetStayTime(), self.chapterID_)
end

function DailyView:Dispose()
	DailyView.super.Dispose(self)

	self.changeChapterHandler_ = nil

	self.switchChapterView_:Dispose()

	self.switchChapterView_ = nil
end

function DailyView:IsOpenSectionInfo()
	return self:IsOpenRoute("dailySectionInfo")
end

function DailyView:GetSectionItemClass()
	return DailyItem
end

function DailyView:RefreshCustomData()
	self.switchChapterView_:SetData(self.chapterID_)
end

function DailyView:RefreshUI()
	DailyView.super.RefreshUI(self)

	local var_8_0 = getChapterClientCfgByChapterID(self.chapterID_).chapter_list
	local var_8_1 = #var_8_0 > 1

	if not self:IsOpenSectionInfo() and not self:IsOpenRoute("chapterSectionReward") and var_8_1 then
		SetActive(self.chooseGo_, true)
	else
		SetActive(self.chooseGo_, false)
	end

	if var_8_1 then
		self:RefreshChapterItemBtn()

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if self.chapterItem_[iter_8_0] then
				self.chapterItem_[iter_8_0]:SetData(iter_8_1)
			else
				self.chapterItem_[iter_8_0] = DailyChapterItemBtn.New(self, self.selectResourceItem_, self.selectResourcePanel_, iter_8_1)
			end
		end
	end

	self.switchChapterView_:RefreshUI()
	self:SwitchBG()
end

function DailyView:GetCfgName()
	return BattleDailyStageCfg
end

function DailyView:RefreshChapterItemBtn()
	self.selectResourceText_.text = GetI18NText(ChapterCfg[self.chapterID_].subhead)
end

function DailyView:SwitchDailyChapter(arg_11_1)
	local var_11_0 = getChapterClientCfgByChapterID(arg_11_1)
	local var_11_1 = BattleFieldData:GetCacheStage(arg_11_1) or GetI18NText(ChapterCfg[arg_11_1].section_id_list[1])

	if self.params_.section == var_11_1 then
		return
	end

	self.params_.chapterID = arg_11_1
	self.params_.section = var_11_1

	BattleFieldData:SetStageByClientID(var_11_0.id, var_11_1)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(var_11_0.id), var_11_0.id)
	self:RefreshData(arg_11_1)
	DailyView.super.RefreshUI(self)
	self:RefreshChapterItemBtn()
end

return DailyView
