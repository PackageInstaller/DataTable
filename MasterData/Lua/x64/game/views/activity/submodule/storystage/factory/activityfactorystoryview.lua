local ActivityFactoryStoryView = class("ActivityFactoryStoryView", ReduxView)

function ActivityFactoryStoryView:UIName()
	return "UI/MardukUI/plot/MardukplotUI"
end

function ActivityFactoryStoryView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityFactoryStoryView:GetItemClass()
	return ActivityFactoryStoryItem
end

function ActivityFactoryStoryView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.stageItemList_ = {}
	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)
	self.storyChapterView_ = {}
	self.lineList_ = {}
end

function ActivityFactoryStoryView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	self:RegistEventListener(STAGE_ARCHIVE_RED_UPDATE, function()
		self:RefreshArchiveCollectBtn()
	end)
	manager.ui:SetMainCamera("null")
	self:RefreshData()
	self:RefreshUI()

	for iter_5_0, iter_5_1 in ipairs(ChapterClientCfg[6010004].chapter_list) do
		local var_5_0 = self[string.format("chapterGo%s_", iter_5_0)]

		if var_5_0 then
			self.storyChapterView_[iter_5_0] = self.storyChapterView_[iter_5_0] or ActivityFactoryStoryChapterItem.New(var_5_0, iter_5_1)
		end
	end

	for iter_5_2, iter_5_3 in pairs(self.storyChapterView_) do
		iter_5_3:OnEnter(self.chapterID_)
	end
end

function ActivityFactoryStoryView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	for iter_8_0, iter_8_1 in pairs(self.storyChapterView_) do
		iter_8_1:OnExit()
	end

	self.scrollMoveView_:OnExit()

	self.stopMove_ = false
end

function ActivityFactoryStoryView:OnTop()
	self.stopMove_ = false
end

function ActivityFactoryStoryView:OnUpdate()
	if self:IsOpenRoute("stageArchive") then
		self.stopMove_ = true

		return
	end

	self:RefreshData()
	self:RefreshUI()

	for iter_10_0, iter_10_1 in pairs(self.storyChapterView_) do
		iter_10_1:OnUpdate(self.chapterID_)
	end
end

function ActivityFactoryStoryView:Dispose()
	ActivityFactoryStoryView.super.Dispose(self)

	for iter_11_0, iter_11_1 in ipairs(self.lineList_) do
		iter_11_1:Dispose()
	end

	self.lineList_ = nil

	for iter_11_2, iter_11_3 in pairs(self.stageItemList_) do
		iter_11_3:Dispose()
	end

	self.stageItemList_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil

	for iter_11_4, iter_11_5 in pairs(self.storyChapterView_) do
		iter_11_5:Dispose()
	end

	self.storyChapterView_ = nil
end

function ActivityFactoryStoryView:AddListeners()
	if self.archiveCollectBtn_ then
		self:AddBtnListener(self.archiveCollectBtn_, nil, function()
			JumpTools.OpenPageByJump("stageArchiveCollect", {
				chapterID = self.chapterID_
			})
		end)
	end
end

function ActivityFactoryStoryView:RefreshData()
	if self.params_.chapterID == nil then
		self.chapterID_ = BattleFieldData:GetCacheChapter(ChapterClientCfg[self.params_.chapterClientID].id)

		if table.keyof(ChapterClientCfg[self.params_.chapterClientID].chapter_list, self.chapterID_) < 4 then
			self.chapterID_ = BattleFieldData:GetSecondCacheChapter(getChapterToggle(ChapterClientCfg[self.params_.chapterClientID].id), ChapterClientCfg[self.params_.chapterClientID].id) or ChapterClientCfg[self.params_.chapterClientID].chapter_list[1]
		end
	else
		self.chapterID_ = self.params_.chapterID
	end

	self.stageData_ = BattleStageData:GetStageData()
	self.stageList_ = ChapterCfg[self.chapterID_].section_id_list
	self.selectStageID_ = BattleFieldData:GetCacheStage(self.chapterID_) or self.stageList_[1]
end

function ActivityFactoryStoryView:RefreshUI()
	if not self.stopMove_ then
		self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	end

	local var_15_0 = ChapterCfg[self.chapterID_]
	local var_15_1 = 0
	local var_15_2 = 0

	for iter_15_0, iter_15_1 in pairs(ChapterCfg[self.chapterID_].section_id_list) do
		if self.stageData_[iter_15_1] then
			var_15_1 = var_15_1 + 1

			if self.stageData_[iter_15_1].clear_times > 0 then
				var_15_2 = var_15_2 + 1
			end
		end
	end

	for iter_15_2 = #self.stageItemList_, var_15_1 + 1, -1 do
		self.stageItemList_[iter_15_2]:OnExit()
	end

	for iter_15_3 = 1, var_15_1 do
		if self.stageItemList_[iter_15_3] == nil then
			self.stageItemList_[iter_15_3] = self:GetItemClass().New(self.sectionItem_, self.content_)
		end

		self.stageItemList_[iter_15_3]:SetData(self.stageList_[iter_15_3], self.chapterID_)
	end

	self:RefreshSelectItem()

	self.nameText_.text = GetI18NText(var_15_0.subhead)
	self.finishCntText_.text = string.format("%s/%s", var_15_2, #var_15_0.section_id_list)

	self:CreateLineItemList(var_15_1)
	self:RefreshArchiveCollectBtn()
end

function ActivityFactoryStoryView:RefreshSelectItem()
	for iter_16_0, iter_16_1 in pairs(self.stageItemList_) do
		iter_16_1:SelectorItem(self.selectStageID_)
	end
end

function ActivityFactoryStoryView:GetScrollWidth()
	local var_17_0 = self.stageList_[1]

	for iter_17_0, iter_17_1 in ipairs(self.stageList_) do
		if not self.stageData_[iter_17_1] then
			break
		end

		var_17_0 = iter_17_1
	end

	return (BattleActivityStoryStageCfg[var_17_0] or nil) and (BattleActivityStoryStageCfg[var_17_0].position[1] or 0)
end

function ActivityFactoryStoryView:GetScrollPos()
	return (BattleActivityStoryStageCfg[self.selectStageID_] or nil) and (BattleActivityStoryStageCfg[self.selectStageID_].position[1] or 0)
end

function ActivityFactoryStoryView:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function ActivityFactoryStoryView:AddTimer()
	self.stopTime_ = ActivityData:GetActivityData(ChapterCfg[self.chapterID_].activity_id).stopTime

	self:StopTimer()

	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityFactoryStoryView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityFactoryStoryView:CreateLineItemList(arg_23_1)
	for iter_23_0, iter_23_1 in pairs(self.lineList_) do
		iter_23_1:Show(false)
	end

	for iter_23_2 = 2, arg_23_1 do
		local var_23_0 = self.stageItemList_[iter_23_2]:GetLocalPosition() + Vector3(-130, 0, 0)
		local var_23_2 = self.stageItemList_[iter_23_2 - 1]:GetLocalPosition() + Vector3(130, 0, 0)

		self.lineList_[1] = self.lineList_[1] or self:GetLineClass().New(self.lineGo_, self.content_, 3)

		self.lineList_[1]:Show(true)
		self.lineList_[1]:RefreshUI(var_23_2, var_23_0)
	end
end

function ActivityFactoryStoryView:RefreshArchiveCollectBtn()
	if self.archiveCollectBtn_ then
		SetActive(self.archiveCollectBtn_.gameObject, StageTools.IsNeedStageArchiveEntrace(self.chapterID_))
		manager.redPoint:SetRedPointIndependent(self.archiveCollectBtn_.transform, StageTools.IsHavedStageArchiveRedInChapter(self.chapterID_))
	end
end

function ActivityFactoryStoryView:GetLineClass()
	return SectionSingleLineItem
end

return ActivityFactoryStoryView
