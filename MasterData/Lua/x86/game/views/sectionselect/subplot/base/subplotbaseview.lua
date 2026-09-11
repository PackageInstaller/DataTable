local SubPlotBaseView = class("SubPlotBaseView", ReduxView)

function SubPlotBaseView:UIName()
	return "UI/MardukUI/hera/HeraStoryUI"
end

function SubPlotBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function SubPlotBaseView:Init()
	self:BindCfgUI()

	self.stageItemList_ = {}
	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)
	self.changeChapterHandler_ = handler(self, self.ChangeChapter)
end

function SubPlotBaseView:OnEnter()
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
	manager.ui:SetMainCamera("null")
	self:RefreshData()
	self:RefreshUI()
	manager.notify:RegistListener(CHANGE_CHAPTER, self.changeChapterHandler_)
	BattleStageAction.ClickSubPlot(self.chapterID_)
end

function SubPlotBaseView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self.scrollMoveView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, self.changeChapterHandler_)
end

function SubPlotBaseView:Dispose()
	self.changeChapterHandler_ = nil

	SubPlotBaseView.super.Dispose(self)

	for iter_7_0, iter_7_1 in pairs(self.stageItemList_) do
		iter_7_1:Dispose()
	end

	self.stageItemList_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
end

function SubPlotBaseView:OnUpdate()
	self:RefreshData()
	self:RefreshUI()
end

function SubPlotBaseView:ChangeChapter(arg_9_1)
	local var_9_0 = getChapterClientCfgByChapterID(arg_9_1)
	local var_9_1 = BattleFieldData:GetCacheStage(arg_9_1) or ChapterCfg[arg_9_1].section_id_list[1]

	if self.params_.section == var_9_1 then
		return
	end

	self.params_.chapterID = arg_9_1
	self.params_.section = var_9_1

	BattleFieldData:SetStageByClientID(var_9_0.id, var_9_1)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(var_9_0.id), var_9_0.id)
	BattleFieldAction.ChangeSelectChapterID(arg_9_1)
	JumpTools.Jump2SubPlot(var_9_0.id, true)
end

function SubPlotBaseView:RefreshData()
	self.chapterID_ = BattleFieldData:GetCacheChapter(self.params_.chapterClientID)
	self.stageData_ = BattleStageData:GetStageData()
	self.stageList_ = ChapterCfg[self.chapterID_].section_id_list
	self.selectStageID_ = BattleFieldData:GetCacheStage(self.chapterID_) or ChapterCfg[self.chapterID_].section_id_list[1]
end

function SubPlotBaseView:RefreshUI()
	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))

	for iter_11_0 = 1, #self.stageItemList_ do
		self.stageItemList_[iter_11_0]:Show(false)
	end

	local var_11_0 = BattleStageData:GetStageData()

	for iter_11_1 = 1, #self.stageList_ do
		if iter_11_1 == 1 or var_11_0[self.stageList_[iter_11_1]] then
			self.stageItemList_[iter_11_1] = self.stageItemList_[iter_11_1] or self:GetItemClass().New(self.sectionItem_, self.content_)

			self.stageItemList_[iter_11_1]:SetData(self.stageList_[iter_11_1], self.chapterID_)
		end
	end

	self:RefreshSelectItem()
end

function SubPlotBaseView:RefreshSelectItem()
	for iter_12_0, iter_12_1 in pairs(self.stageItemList_) do
		iter_12_1:SelectorItem(self.selectStageID_)
	end
end

function SubPlotBaseView:GetItemClass()
	return SubPlotBaseItem
end

function SubPlotBaseView:GetScrollWidth()
	local var_14_0 = self.stageList_[1]

	for iter_14_0, iter_14_1 in ipairs(self.stageList_) do
		if not self.stageData_[iter_14_1] then
			break
		end

		var_14_0 = iter_14_1
	end

	local var_14_1 = self:GetCfgName()[var_14_0]

	return (var_14_1 or nil) and (var_14_1.position[1] or 0)
end

function SubPlotBaseView:GetScrollPos()
	local var_15_0 = self:GetCfgName()[self.selectStageID_]

	return (var_15_0 or nil) and (var_15_0.position[1] or 0)
end

function SubPlotBaseView:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function SubPlotBaseView:SwitchBG()
	local var_17_0 = ChapterCfg[self.chapterID_]

	if ChapterCfg[self.chapterID_].bg ~= "" then
		self.bgImage_.sprite = pureGetSpriteWithoutAtlas(var_17_0.bg)
	end

	SetActive(self.bgImage_.gameObject, var_17_0.bg ~= "")
end

function SubPlotBaseView:GetCfgName()
	return BattleActivityStoryStageCfg
end

return SubPlotBaseView
