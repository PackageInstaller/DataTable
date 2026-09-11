local SectionBaseView = class("SectionBaseView", ReduxView)
local BattleConst = import("game.const.BattleConst")
local JumpTools = import("game.tools.JumpTools")

function SectionBaseView:UIName()
	return "Widget/System/Operation/OperationStageUI"
end

function SectionBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function SectionBaseView:OnCtor()
	return
end

function SectionBaseView:Init()
	self.lineList_ = {}
	self.customLineList_ = {}
	self.missionItem_ = {}
	self.lineType_ = nil
	self.multiTimeRefresh_ = 0

	self:InitUI()
	self:AddListeners()

	if self.doubleGo_ then
		self.multiView = OperationMultiView.New(self.doubleGo_)
	end
end

function SectionBaseView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INVITE_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	self:RegistEventListener(STAGE_ARCHIVE_RED_UPDATE, function()
		manager.redPoint:SetRedPointIndependent(self.archiveCollectBtn_.transform, StageTools.IsHavedStageArchiveRedInChapter(self.chapterID_))
	end)
	manager.ui:SetMainCamera("null")
	self:RefreshData()
	self:RefreshBGM()
	self:RefreshMultiReward()
	self:ShowPanel()
	self:RefreshText()
	self:RefreshUI()
end

function SectionBaseView:OnTop()
	self.stopMove_ = false
end

function SectionBaseView:OnMultipleRewardCountChange()
	self:RefreshMultiReward()
end

function SectionBaseView:OnUpdate()
	if self:IsOpenSectionInfo() then
		self.stopMove_ = false
	end

	self:RefreshData()
	self:RefreshUI()
end

function SectionBaseView:RefreshUI()
	self:RefreshMissionList()

	local var_11_0 = self.params_.section

	if not self.params_.section then
		var_11_0 = BattleFieldData:GetCacheStage(self.chapterID_)
		var_11_0 = var_11_0 or self.stageList_[1]
	end

	self.selectSection_ = var_11_0

	if self.stopMove_ then
		-- block empty
	else
		self.scrollMoveView_:RefreshUI(self:GetScrollPos(), (self:GetScrollWidth()))
	end

	self:RefreshSelectItem()
end

function SectionBaseView:RefreshBGM()
	if ChapterCfg[self.chapterID_].cue_sheet ~= "" then
		manager.audio:PlayBGM(ChapterCfg[self.chapterID_].cue_sheet, ChapterCfg[self.chapterID_].cue_name, ChapterCfg[self.chapterID_].awb)
	end
end

function SectionBaseView:GetScrollWidth()
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(self.oepnStageList_) do
		local var_13_1 = self:GetCfgName()[iter_13_1]

		if var_13_1.position ~= "" then
			local var_13_2 = var_13_1.position[1] or 0

			if var_13_0 < var_13_2 then
				var_13_0 = var_13_2
			end
		end
	end

	return var_13_0
end

function SectionBaseView:GetScrollPos()
	local var_14_0 = self:GetCfgName()[self.selectSection_]

	return (var_14_0 or nil) and (var_14_0.position[1] or 0)
end

function SectionBaseView:RefreshMultiReward()
	if self.multiView then
		self.multiView:RefreshUI(self.chapterID_, ChapterCfg[self.chapterID_].type, true)
	end
end

function SectionBaseView:OnExit()
	if self.multiView then
		self.multiView:OnExit()
	end

	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self.scrollMoveView_:OnExit()

	self.lastChapterID_ = nil
	self.stopMove_ = false
end

function SectionBaseView:Dispose()
	self:RemoveListeners()
	self:RemoveAllListeners()

	if self.multiView then
		self.multiView:Dispose()

		self.multiView = nil
	end

	self.lineType_ = nil

	for iter_17_0, iter_17_1 in ipairs(self.missionItem_) do
		iter_17_1:Dispose()
	end

	self.missionItem_ = nil

	self:DestroyLine()

	self.lineList_ = nil

	for iter_17_2, iter_17_3 in pairs(self.customLineList_) do
		iter_17_3:Dispose()
	end

	self.customLineList_ = nil

	if self.scene_ then
		Object.Destroy(self.scene_)

		self.scene_ = nil
	end

	self.selector_ = nil

	self.scrollMoveView_:Dispose()

	self.scrollMoveView_ = nil
	self.bgBtn_ = nil
	self.rollBgBtn_ = nil
	self.scrollView_ = nil
	self.scrollViewGo_ = nil
	self.content_ = nil
	self.contentRect_ = nil
	self.viewportRect_ = nil
	self.scrollViewEvent_ = nil
	self.selectDifficultGo_ = nil
	self.collectBtnGo_ = nil
	self.collectBtn_ = nil
	self.collectCurText_ = nil
	self.collectTotalText_ = nil
	self.collectProgress_ = nil
	self.sectionItem_ = nil
	self.lineGo_ = nil

	SectionBaseView.super.Dispose(self)
end

function SectionBaseView:InitUI()
	self:BindCfgUI()

	self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollViewGo_)

	self:InitCustom()
end

function SectionBaseView:InitCustom()
	return
end

function SectionBaseView:AddListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self:IsOpenSectionInfo() then
			self.isOpenInfoView_ = false

			JumpTools.Back()
		end
	end)

	if self.rollBgBtn_ then
		self:AddBtnListener(self.rollBgBtn_, nil, function()
			if self:IsOpenSectionInfo() then
				self.isOpenInfoView_ = false

				JumpTools.Back()
			end
		end)
	end

	if self.archiveCollectBtn_ then
		self:AddBtnListener(self.archiveCollectBtn_, nil, function()
			JumpTools.OpenPageByJump("stageArchiveCollect", {
				chapterID = self.chapterID_
			})
		end)
	end
end

function SectionBaseView:RemoveListeners()
	self.bgBtn_.onClick:RemoveAllListeners()

	if self.rollBgBtn_ then
		self.rollBgBtn_.onClick:RemoveAllListeners()
	end
end

function SectionBaseView:RefreshData()
	self.chapterID_ = self.params_.chapterID == nil and BattleFieldData:GetCacheChapter(self.params_.chapterClientID) or self.params_.chapterID
	self.stageData_ = BattleStageData:GetStageData()
	self.stageList_ = ChapterCfg[self.chapterID_].section_id_list

	local var_25_0 = self.params_.section

	if not self.params_.section then
		var_25_0 = BattleFieldData:GetCacheStage(self.chapterID_)
		var_25_0 = var_25_0 or ChapterCfg[self.chapterID_].section_id_list[1]
	end

	BattleFieldData:SetStageByClientID(getChapterClientCfgByChapterID(self.chapterID_).id, var_25_0)
	BattleFieldAction.ChangeSelectChapterID(self.chapterID_)
	self:RefreshCustomData()

	self.oepnStageList_ = ChapterTools.GetOpenStageList(self.chapterID_, self:GetCfgName())
end

function SectionBaseView:RefreshCustomData()
	return
end

function SectionBaseView:IsOpenSectionInfo()
	return self:IsOpenRoute("challengeSectionInfo")
end

function SectionBaseView:GetCfgName()
	return
end

function SectionBaseView:ShowPanel()
	SetActive(self.collectBtnGo_, false)
	SetActive(self.selectDifficultGo_, false)

	if self.archiveCollectBtn_ then
		SetActive(self.archiveCollectBtn_.gameObject, StageTools.IsNeedStageArchiveEntrace(self.chapterID_))
		manager.redPoint:SetRedPointIndependent(self.archiveCollectBtn_.transform, StageTools.IsHavedStageArchiveRedInChapter(self.chapterID_))
	end
end

function SectionBaseView:RefreshText()
	return
end

function SectionBaseView:SwitchBG()
	local var_31_0 = ChapterCfg[self.chapterID_]

	if ChapterCfg[self.chapterID_].bg ~= "" then
		self.bgImage_.sprite = pureGetSpriteWithoutAtlas(var_31_0.bg)
	end

	SetActive(self.bgImage_.gameObject, var_31_0.bg ~= "")
end

function SectionBaseView:RefreshSelectItem()
	for iter_32_0, iter_32_1 in pairs(self.missionItem_) do
		iter_32_1:SelectorItem(self.selectSection_)
	end
end

function SectionBaseView:RefreshMissionList()
	if self.lastChapterID_ == self.chapterID_ then
		return
	end

	self.lastChapterID_ = self.chapterID_

	for iter_33_0 = 1, #self.missionItem_ do
		self.missionItem_[iter_33_0]:Show(false)
	end

	for iter_33_1 = 1, #self.stageList_ do
		if self.missionItem_[iter_33_1] then
			self.missionItem_[iter_33_1]:SetData(self.chapterID_, self.stageList_[iter_33_1])
		else
			self.missionItem_[iter_33_1] = self:GetSectionItemClass().New(self.sectionItem_, self.content_, self.stageList_[iter_33_1], self.chapterID_)
		end
	end

	self:CreateLineItemList()
end

function SectionBaseView:CreateLineItemList()
	if self.lineType_ ~= ChapterCfg[self.chapterID_].line_type then
		self:DestroyLine()

		self.lineType_ = ChapterCfg[self.chapterID_].line_type
	end

	for iter_34_0, iter_34_1 in pairs(self.lineList_) do
		iter_34_1:Show(false)
	end

	for iter_34_2, iter_34_3 in pairs(self.customLineList_) do
		iter_34_3:Show(false)
	end

	local var_34_0 = 1
	local var_34_3 = self.oepnStageList_

	for iter_34_4, iter_34_5 in ipairs(self.oepnStageList_) do
		local var_34_4 = self.missionItem_[table.keyof(self.stageList_, iter_34_5)]:GetLocalPosition() + Vector3(0, 0, 0)
		local var_34_5 = self:GetCfgName()[iter_34_5].pre_show_id_list or {}
		local var_34_6 = #var_34_5 > 1

		for iter_34_6, iter_34_7 in ipairs(var_34_5) do
			if self.stageData_[iter_34_7] and self.stageData_[iter_34_7].clear_times > 0 then
				-- block empty
			else
				var_34_6 = false

				break
			end
		end

		for iter_34_8, iter_34_9 in ipairs(var_34_5) do
			local var_34_7 = self:GetCfgName()[iter_34_5]

			if type(var_34_7.custom_line) == "table" and #var_34_7.custom_line[iter_34_8] > 0 and (self.stageData_[iter_34_5] and self.stageData_[iter_34_5].clear_times > 0 or var_34_6) then
				self:DrawLine(var_34_0, var_34_7.custom_line[iter_34_8])

				var_34_0 = var_34_0 + 1
			elseif type(var_34_7.custom_lock_line) == "table" and #var_34_7.custom_lock_line[iter_34_8] > 0 then
				self:DrawLine(var_34_0, var_34_7.custom_lock_line[iter_34_8])

				var_34_0 = var_34_0 + 1
			elseif table.keyof(var_34_3, iter_34_9) then
				local var_34_8 = self.missionItem_[table.keyof(self.stageList_, iter_34_9)]:GetLocalPosition() + Vector3(0, 0, 0)

				self.lineList_[var_34_0] = self.lineList_[var_34_0] or self:GetLineClass(self.lineType_).New(self:GetLineGo(self.lineType_), self.content_, self:GetPointGo(self.lineType_))

				self.lineList_[var_34_0]:Show(true)
				self.lineList_[var_34_0]:RefreshUI(var_34_8, var_34_4)

				var_34_0 = var_34_0 + 1
			end
		end
	end
end

function SectionBaseView:DrawLine(arg_35_1, arg_35_2)
	self.customLineList_[arg_35_1] = self.customLineList_[arg_35_1] or SectionCustomLineItem.New(self:GetLineGo(2), self.content_, self:GetPointGo(self.lineType_))

	self.customLineList_[arg_35_1]:Show(true)
	self.customLineList_[arg_35_1]:RefreshUI(arg_35_2)
end

function SectionBaseView:GetLineClass(arg_36_1)
	if arg_36_1 == 0 then
		return SectionLineItem
	else
		return SectionBranchLineItem
	end
end

function SectionBaseView:GetLineGo(arg_37_1)
	if arg_37_1 == 2 then
		return self.lineGo_
	elseif arg_37_1 == 3 then
		return self.lineGo2_
	else
		return self.lineGo_
	end
end

function SectionBaseView:GetPointGo(arg_38_1)
	if arg_38_1 == 2 then
		return self.pointGo_
	else
		return self.pointGo_
	end
end

function SectionBaseView:DestroyLine()
	for iter_39_0, iter_39_1 in pairs(self.lineList_) do
		iter_39_1:Dispose()
	end

	self.lineList_ = {}
end

return SectionBaseView
