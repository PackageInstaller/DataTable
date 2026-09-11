local HellaStoryRemasteredView = class("HellaStoryRemasteredView", ReduxView)

function HellaStoryRemasteredView:UIName()
	return "Widget/System/Operation/ChapterSectionUI/HellaSelectStageUI"
end

function HellaStoryRemasteredView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaStoryRemasteredView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.switchController_ = ControllerUtil.GetController(self.goSwitch_.transform, "name")
	self.btnLockController_ = ControllerUtil.GetController(self.btnSwitch_.transform, "name")
	self.storyChapterView_ = {}
	self.stageItemList_ = {}
	self.scrollMoveView_ = ScrollMoveView.New(self, self.goScrollView_)
	self.scrollContenLineView_ = ScrollContentLineView.New(self.goLineItem_, self.goItemParent_, self:FindCom(typeof(RectTransform), nil, self.goStageItem_.transform).rect.width, 30, 4)
	self.controller_ = ControllerUtil.GetController(self.transform_, "active")

	self.controller_:SetSelectedState("off")

	self.extraStoryView_ = SubPlotExtraStoryBtn.New(self.extraStoryGo_)
end

function HellaStoryRemasteredView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	self:RefreshData()

	local var_4_0 = getChapterClientCfgByChapterID(self.selectChapterID_)

	if not getData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. var_4_0.id) then
		saveData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. var_4_0.id, 1)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_POLT_NEW_TAG, var_4_0.id), 0, RedPointStyle.SHOW_NEW_TAG)
	end

	local var_4_1 = ChapterClientCfg[var_4_0.id].chapter_list

	for iter_4_0 = 1, 3 do
		self.storyChapterView_[iter_4_0] = self.storyChapterView_[iter_4_0] or HellaStoryChapterView.New(self[string.format("chapterBtn%s_", iter_4_0)], var_4_1[iter_4_0])
	end

	for iter_4_1, iter_4_2 in pairs(self.storyChapterView_) do
		iter_4_2:OnEnter(self.selectChapterID_)
	end

	self:RefreshUI()
	BattleStageAction.ClickSubPlot(self.selectChapterID_)
	manager.notify:RegistListener(CHANGE_CHAPTER, self.changeChapterHandler_)
	self.extraStoryView_:OnEnter()
	manager.redPoint:bindUIandKey(self.transformRedPoint2_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, var_4_1[4]))
end

function HellaStoryRemasteredView:OnExit()
	manager.windowBar:HideBar()

	for iter_6_0, iter_6_1 in pairs(self.storyChapterView_) do
		iter_6_1:OnExit()
	end

	self.scrollMoveView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, self.changeChapterHandler_)
	self.extraStoryView_:OnExit()
	manager.redPoint:unbindUIandKey(self.transformRedPoint2_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, ChapterClientCfg[getChapterClientCfgByChapterID(self.selectChapterID_).id].chapter_list[4]))
end

function HellaStoryRemasteredView:OnUpdate()
	self:RefreshData()
	self:RefreshUI()

	for iter_7_0, iter_7_1 in pairs(self.storyChapterView_) do
		iter_7_1:OnUpdate(self.selectChapterID_)
	end
end

function HellaStoryRemasteredView:Dispose()
	self.extraStoryView_:Dispose()

	self.extraStoryView_ = nil

	HellaStoryRemasteredView.super.Dispose(self)

	for iter_8_0, iter_8_1 in pairs(self.storyChapterView_) do
		iter_8_1:Dispose()
	end

	for iter_8_2, iter_8_3 in pairs(self.stageItemList_) do
		iter_8_3:Dispose()
	end

	self.stageItemList_ = nil

	self.scrollContenLineView_:Dispose()

	self.scrollContenLineView_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
end

function HellaStoryRemasteredView:AddListeners()
	self:AddBtnListener(self.btnSwitch_, nil, function()
		local var_10_0 = getChapterClientCfgByChapterID(self.selectChapterID_)

		if table.keyof(var_10_0.chapter_list, self.selectChapterID_) < 4 then
			if BattleStageData:GetStageData()[ChapterCfg[var_10_0.chapter_list[4]].section_id_list[1]] == nil then
				ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), ChapterCfg[var_10_0.chapter_list[3]].subhead))

				return
			else
				local var_10_1 = var_10_0.chapter_list[4]

				BattleFieldData:SetStageByClientID(var_10_0.id, BattleFieldData:GetCacheStage(var_10_0.chapter_list[4]) or ChapterCfg[var_10_1].section_id_list[1])
				BattleFieldData:SetCacheChapterClient(getChapterToggle(var_10_0.id), var_10_0.id)
				BattleFieldData:SetSecondCacheChapter(getChapterToggle(var_10_0.id), self.selectChapterID_, var_10_0.id)
				BattleFieldData:SetCacheChapter(var_10_0.id, var_10_1)
				BattleStageAction.ClickSubPlot(var_10_1)
				JumpTools.Jump2SubPlot(var_10_0.id, true)
			end
		else
			local var_10_2 = BattleFieldData:GetSecondCacheChapter(getChapterToggle(var_10_0.id), var_10_0.id) or var_10_0.chapter_list[1]

			BattleFieldData:SetStageByClientID(var_10_0.id, BattleFieldData:GetCacheStage(var_10_2) or ChapterCfg[var_10_2].section_id_list[1])
			BattleFieldData:SetCacheChapterClient(getChapterToggle(var_10_0.id), var_10_0.id)
			BattleFieldData:SetCacheChapter(var_10_0.id, var_10_2)
			JumpTools.Jump2SubPlot(var_10_0.id, true)
		end
	end)
	self:AddBtnListener(self.btnWarChess_, nil, function()
		local var_11_0 = getChapterClientCfgByChapterID(self.selectChapterID_)

		JumpTools.OpenPageByJump("/subPlotChessView", {
			tag = ChessConst.SUBPLOT_TAG.HELLA
		})
	end)
end

function HellaStoryRemasteredView:RefreshData()
	if self.params_.chapterID == nil then
		self.selectChapterID_ = BattleFieldData:GetCacheChapter(ChapterClientCfg[self.params_.chapterClientID].id)

		if table.keyof(ChapterClientCfg[self.params_.chapterClientID].chapter_list, self.selectChapterID_) < 4 then
			local var_12_0 = BattleFieldData:GetSecondCacheChapter(getChapterToggle(ChapterClientCfg[self.params_.chapterClientID].id), self.params_.chapterClientID)

			self.selectChapterID_ = table.keyof(ChapterClientCfg[self.params_.chapterClientID].chapter_list, var_12_0) and var_12_0 or ChapterClientCfg[self.params_.chapterClientID].chapter_list[1]
		end
	else
		self.selectChapterID_ = self.params_.chapterID
	end

	self.stageData_ = BattleStageData:GetStageData()
	self.stageList_ = ChapterCfg[self.selectChapterID_].section_id_list

	self.extraStoryView_:SetData(self.selectChapterID_)
end

function HellaStoryRemasteredView:RefreshUI()
	self.selectStageID_ = BattleFieldData:GetCacheStage(self.selectChapterID_) or ChapterCfg[self.selectChapterID_].section_id_list[1]

	self:RefreshStageList()
	self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	self:RefreshSwitchBtn()
	self:RefreshSelectItem()
	self:RefreshChapterPanel()
	self:RefreshRedPoint()
end

function HellaStoryRemasteredView:RefreshSwitchBtn()
	local var_14_0 = getChapterClientCfgByChapterID(self.selectChapterID_)

	if table.keyof(var_14_0.chapter_list, self.selectChapterID_) < 4 then
		self.switchController_:SetSelectedState("1")

		self.text_1.text = GetTips("FRONT_CHAPTER")
		self.text_2.text = GetTips("AFTER_CHAPTER")
		self.text_3.text = GetTips("AFTER_CHAPTER")
		self.titleText_.text = GetTips("FRONT_CHAPTER")
	else
		self.switchController_:SetSelectedState("2")

		self.text_1.text = GetTips("AFTER_CHAPTER")
		self.text_2.text = GetTips("FRONT_CHAPTER")
		self.text_3.text = GetTips("FRONT_CHAPTER")
		self.titleText_.text = GetTips("AFTER_CHAPTER")
	end

	if BattleStageData:GetStageData()[ChapterCfg[var_14_0.chapter_list[4]].section_id_list[1]] == nil then
		self.btnLockController_:SetSelectedState("false")
	else
		self.btnLockController_:SetSelectedState("true")
	end
end

function HellaStoryRemasteredView:RefreshChapterPanel()
	if table.keyof(ChapterClientCfg[getChapterClientCfgByChapterID(self.selectChapterID_).id].chapter_list, self.selectChapterID_) > 3 then
		SetActive(self.goChapterPanel1_, false)
	else
		SetActive(self.goChapterPanel1_, true)
	end
end

function HellaStoryRemasteredView:GetScrollWidth()
	local var_16_0 = self.stageList_[1]

	for iter_16_0, iter_16_1 in ipairs(self.stageList_) do
		if not self.stageData_[iter_16_1] then
			break
		end

		var_16_0 = iter_16_1
	end

	return (BattleActivityStoryStageCfg[var_16_0] or nil) and (BattleActivityStoryStageCfg[var_16_0].position[1] or 0)
end

function HellaStoryRemasteredView:GetScrollPos()
	return (BattleActivityStoryStageCfg[self.selectStageID_] or nil) and (BattleActivityStoryStageCfg[self.selectStageID_].position[1] or 0)
end

function HellaStoryRemasteredView:RefreshStageList()
	for iter_18_0 = 1, #self.stageItemList_ do
		self.stageItemList_[iter_18_0]:Show(false)
	end

	local var_18_0 = BattleStageData:GetStageData()

	for iter_18_1 = 1, #self.stageList_ do
		if iter_18_1 == 1 or var_18_0[self.stageList_[iter_18_1]] then
			self.stageItemList_[iter_18_1] = self.stageItemList_[iter_18_1] or self:GetStageItemClass().New(self.goStageItem_, self.goItemParent_)

			self.stageItemList_[iter_18_1]:SetData(self.stageList_[iter_18_1], self.selectChapterID_)
		end
	end

	self.scrollContenLineView_:CreateLineItemList(self.stageData_, self.stageList_, self.stageItemList_)
end

function HellaStoryRemasteredView:RefreshSelectItem()
	for iter_19_0, iter_19_1 in pairs(self.stageItemList_) do
		iter_19_1:SelectorItem(self.selectStageID_)
	end
end

function HellaStoryRemasteredView:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function HellaStoryRemasteredView:GetStageItemClass()
	return HellaStoryRemasteredItem
end

function HellaStoryRemasteredView:RefreshRedPoint()
	local var_22_0 = getChapterClientCfgByChapterID(self.selectChapterID_).chapter_list

	if table.keyof(var_22_0, self.selectChapterID_) < 4 then
		if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, var_22_0[4])) == 1 and BattleStageData:GetSubPlotRedPointFlag(var_22_0[4]) ~= 1 then
			SetActive(self.transformRedPoint2_.gameObject, true)

			return
		end
	end

	SetActive(self.transformRedPoint2_.gameObject, false)
end

return HellaStoryRemasteredView
