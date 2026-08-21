local var_0_0 = class("SectionBaseView", ReduxView)
local var_0_1 = import("game.const.BattleConst")
local var_0_2 = import("game.tools.JumpTools")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationStageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.lineList_ = {}
	arg_4_0.customLineList_ = {}
	arg_4_0.missionItem_ = {}
	arg_4_0.lineType_ = nil
	arg_4_0.multiTimeRefresh_ = 0

	arg_4_0:InitUI()
	arg_4_0:AddListeners()

	if arg_4_0.doubleGo_ then
		arg_4_0.multiView = OperationMultiView.New(arg_4_0.doubleGo_)
	end
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INVITE_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_5_0:IsOpenSectionInfo() then
			arg_5_0.isOpenInfoView_ = false
		end

		var_0_2.Back()
	end)
	arg_5_0:RegistEventListener(STAGE_ARCHIVE_RED_UPDATE, function()
		manager.redPoint:SetRedPointIndependent(arg_5_0.archiveCollectBtn_.transform, StageTools.IsHavedStageArchiveRedInChapter(arg_5_0.chapterID_))
	end)
	manager.ui:SetMainCamera("null")
	arg_5_0:RefreshData()
	arg_5_0:RefreshBGM()
	arg_5_0:RefreshMultiReward()
	arg_5_0:ShowPanel()
	arg_5_0:RefreshText()
	arg_5_0:RefreshUI()
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0.stopMove_ = false
end

function var_0_0.OnMultipleRewardCountChange(arg_9_0)
	arg_9_0:RefreshMultiReward()
end

function var_0_0.OnUpdate(arg_10_0)
	if arg_10_0:IsOpenSectionInfo() then
		arg_10_0.stopMove_ = false
	end

	arg_10_0:RefreshData()
	arg_10_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshMissionList()

	arg_11_0.selectSection_ = arg_11_0.params_.section or BattleFieldData:GetCacheStage(arg_11_0.chapterID_) or arg_11_0.stageList_[1]

	local var_11_0 = arg_11_0:GetScrollPos()
	local var_11_1 = arg_11_0:GetScrollWidth()

	if arg_11_0.stopMove_ then
		-- block empty
	else
		arg_11_0.scrollMoveView_:RefreshUI(var_11_0, var_11_1)
	end

	arg_11_0:RefreshSelectItem()
end

function var_0_0.RefreshBGM(arg_12_0)
	local var_12_0 = ChapterCfg[arg_12_0.chapterID_]

	if var_12_0.cue_sheet ~= "" then
		manager.audio:PlayBGM(var_12_0.cue_sheet, var_12_0.cue_name, var_12_0.awb)
	end
end

function var_0_0.GetScrollWidth(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = arg_13_0.oepnStageList_

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = arg_13_0:GetCfgName()[iter_13_1]
		local var_13_3 = var_13_2.position ~= "" and var_13_2.position[1] or 0

		if var_13_0 < var_13_3 then
			var_13_0 = var_13_3
		end
	end

	return var_13_0
end

function var_0_0.GetScrollPos(arg_14_0)
	local var_14_0 = arg_14_0:GetCfgName()[arg_14_0.selectSection_]

	return var_14_0 and var_14_0.position[1] or 0
end

function var_0_0.RefreshMultiReward(arg_15_0)
	if arg_15_0.multiView then
		local var_15_0 = ChapterCfg[arg_15_0.chapterID_]

		arg_15_0.multiView:RefreshUI(arg_15_0.chapterID_, var_15_0.type, true)
	end
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.multiView then
		arg_16_0.multiView:OnExit()
	end

	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_16_0.scrollMoveView_:OnExit()

	arg_16_0.lastChapterID_ = nil
	arg_16_0.stopMove_ = false
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveListeners()
	arg_17_0:RemoveAllListeners()

	if arg_17_0.multiView then
		arg_17_0.multiView:Dispose()

		arg_17_0.multiView = nil
	end

	arg_17_0.lineType_ = nil

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.missionItem_) do
		iter_17_1:Dispose()
	end

	arg_17_0.missionItem_ = nil

	arg_17_0:DestroyLine()

	arg_17_0.lineList_ = nil

	for iter_17_2, iter_17_3 in pairs(arg_17_0.customLineList_) do
		iter_17_3:Dispose()
	end

	arg_17_0.customLineList_ = nil

	if arg_17_0.scene_ then
		Object.Destroy(arg_17_0.scene_)

		arg_17_0.scene_ = nil
	end

	arg_17_0.selector_ = nil

	arg_17_0.scrollMoveView_:Dispose()

	arg_17_0.scrollMoveView_ = nil
	arg_17_0.bgBtn_ = nil
	arg_17_0.rollBgBtn_ = nil
	arg_17_0.scrollView_ = nil
	arg_17_0.scrollViewGo_ = nil
	arg_17_0.content_ = nil
	arg_17_0.contentRect_ = nil
	arg_17_0.viewportRect_ = nil
	arg_17_0.scrollViewEvent_ = nil
	arg_17_0.selectDifficultGo_ = nil
	arg_17_0.collectBtnGo_ = nil
	arg_17_0.collectBtn_ = nil
	arg_17_0.collectCurText_ = nil
	arg_17_0.collectTotalText_ = nil
	arg_17_0.collectProgress_ = nil
	arg_17_0.sectionItem_ = nil
	arg_17_0.lineGo_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.InitUI(arg_18_0)
	arg_18_0:BindCfgUI()

	arg_18_0.scrollMoveView_ = ScrollMoveView.New(arg_18_0, arg_18_0.scrollViewGo_)

	arg_18_0:InitCustom()
end

function var_0_0.InitCustom(arg_19_0)
	return
end

function var_0_0.AddListeners(arg_20_0)
	arg_20_0:AddBtnListener(arg_20_0.bgBtn_, nil, function()
		if arg_20_0:IsOpenSectionInfo() then
			arg_20_0.isOpenInfoView_ = false

			var_0_2.Back()
		end
	end)

	if arg_20_0.rollBgBtn_ then
		arg_20_0:AddBtnListener(arg_20_0.rollBgBtn_, nil, function()
			if arg_20_0:IsOpenSectionInfo() then
				arg_20_0.isOpenInfoView_ = false

				var_0_2.Back()
			end
		end)
	end

	if arg_20_0.archiveCollectBtn_ then
		arg_20_0:AddBtnListener(arg_20_0.archiveCollectBtn_, nil, function()
			var_0_2.OpenPageByJump("stageArchiveCollect", {
				chapterID = arg_20_0.chapterID_
			})
		end)
	end
end

function var_0_0.RemoveListeners(arg_24_0)
	arg_24_0.bgBtn_.onClick:RemoveAllListeners()

	if arg_24_0.rollBgBtn_ then
		arg_24_0.rollBgBtn_.onClick:RemoveAllListeners()
	end
end

function var_0_0.RefreshData(arg_25_0)
	if arg_25_0.params_.chapterID == nil then
		local var_25_0 = arg_25_0.params_.chapterClientID

		arg_25_0.chapterID_ = BattleFieldData:GetCacheChapter(var_25_0)
	else
		arg_25_0.chapterID_ = arg_25_0.params_.chapterID
	end

	arg_25_0.stageData_ = BattleStageData:GetStageData()
	arg_25_0.stageList_ = ChapterCfg[arg_25_0.chapterID_].section_id_list

	local var_25_1 = arg_25_0.params_.section or BattleFieldData:GetCacheStage(arg_25_0.chapterID_) or ChapterCfg[arg_25_0.chapterID_].section_id_list[1]
	local var_25_2 = getChapterClientCfgByChapterID(arg_25_0.chapterID_)

	BattleFieldData:SetStageByClientID(var_25_2.id, var_25_1)
	BattleFieldAction.ChangeSelectChapterID(arg_25_0.chapterID_)
	arg_25_0:RefreshCustomData()

	arg_25_0.oepnStageList_ = ChapterTools.GetOpenStageList(arg_25_0.chapterID_, arg_25_0:GetCfgName())
end

function var_0_0.RefreshCustomData(arg_26_0)
	return
end

function var_0_0.IsOpenSectionInfo(arg_27_0)
	return arg_27_0:IsOpenRoute("challengeSectionInfo")
end

function var_0_0.GetCfgName(arg_28_0)
	return
end

function var_0_0.ShowPanel(arg_29_0)
	SetActive(arg_29_0.collectBtnGo_, false)
	SetActive(arg_29_0.selectDifficultGo_, false)

	if arg_29_0.archiveCollectBtn_ then
		SetActive(arg_29_0.archiveCollectBtn_.gameObject, StageTools.IsNeedStageArchiveEntrace(arg_29_0.chapterID_))
		manager.redPoint:SetRedPointIndependent(arg_29_0.archiveCollectBtn_.transform, StageTools.IsHavedStageArchiveRedInChapter(arg_29_0.chapterID_))
	end
end

function var_0_0.RefreshText(arg_30_0)
	return
end

function var_0_0.SwitchBG(arg_31_0)
	local var_31_0 = ChapterCfg[arg_31_0.chapterID_]

	if var_31_0.bg ~= "" then
		arg_31_0.bgImage_.sprite = pureGetSpriteWithoutAtlas(var_31_0.bg)
	end

	SetActive(arg_31_0.bgImage_.gameObject, var_31_0.bg ~= "")
end

function var_0_0.RefreshSelectItem(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.missionItem_) do
		iter_32_1:SelectorItem(arg_32_0.selectSection_)
	end
end

function var_0_0.RefreshMissionList(arg_33_0)
	if arg_33_0.lastChapterID_ == arg_33_0.chapterID_ then
		return
	end

	arg_33_0.lastChapterID_ = arg_33_0.chapterID_

	for iter_33_0 = 1, #arg_33_0.missionItem_ do
		arg_33_0.missionItem_[iter_33_0]:Show(false)
	end

	for iter_33_1 = 1, #arg_33_0.stageList_ do
		if arg_33_0.missionItem_[iter_33_1] then
			arg_33_0.missionItem_[iter_33_1]:SetData(arg_33_0.chapterID_, arg_33_0.stageList_[iter_33_1])
		else
			arg_33_0.missionItem_[iter_33_1] = arg_33_0:GetSectionItemClass().New(arg_33_0.sectionItem_, arg_33_0.content_, arg_33_0.stageList_[iter_33_1], arg_33_0.chapterID_)
		end
	end

	arg_33_0:CreateLineItemList()
end

function var_0_0.CreateLineItemList(arg_34_0)
	if arg_34_0.lineType_ ~= ChapterCfg[arg_34_0.chapterID_].line_type then
		arg_34_0:DestroyLine()

		arg_34_0.lineType_ = ChapterCfg[arg_34_0.chapterID_].line_type
	end

	for iter_34_0, iter_34_1 in pairs(arg_34_0.lineList_) do
		iter_34_1:Show(false)
	end

	for iter_34_2, iter_34_3 in pairs(arg_34_0.customLineList_) do
		iter_34_3:Show(false)
	end

	local var_34_0 = 1
	local var_34_1 = 1
	local var_34_2 = 1
	local var_34_3 = arg_34_0.oepnStageList_

	for iter_34_4, iter_34_5 in ipairs(var_34_3) do
		local var_34_4 = table.keyof(arg_34_0.stageList_, iter_34_5)
		local var_34_5 = arg_34_0.missionItem_[var_34_4]:GetLocalPosition() + Vector3(0, 0, 0)
		local var_34_6 = arg_34_0:GetCfgName()[iter_34_5].pre_show_id_list or {}
		local var_34_7 = #var_34_6 > 1

		for iter_34_6, iter_34_7 in ipairs(var_34_6) do
			if arg_34_0.stageData_[iter_34_7] and arg_34_0.stageData_[iter_34_7].clear_times > 0 then
				-- block empty
			else
				var_34_7 = false

				break
			end
		end

		for iter_34_8, iter_34_9 in ipairs(var_34_6) do
			local var_34_8 = arg_34_0:GetCfgName()[iter_34_5]

			if type(var_34_8.custom_line) == "table" and #var_34_8.custom_line[iter_34_8] > 0 and (arg_34_0.stageData_[iter_34_5] and arg_34_0.stageData_[iter_34_5].clear_times > 0 or var_34_7) then
				arg_34_0:DrawLine(var_34_0, var_34_8.custom_line[iter_34_8])

				var_34_0 = var_34_0 + 1
			elseif type(var_34_8.custom_lock_line) == "table" and #var_34_8.custom_lock_line[iter_34_8] > 0 then
				arg_34_0:DrawLine(var_34_0, var_34_8.custom_lock_line[iter_34_8])

				var_34_0 = var_34_0 + 1
			elseif table.keyof(var_34_3, iter_34_9) then
				local var_34_9 = table.keyof(arg_34_0.stageList_, iter_34_9)
				local var_34_10 = arg_34_0.missionItem_[var_34_9]:GetLocalPosition() + Vector3(0, 0, 0)

				arg_34_0.lineList_[var_34_0] = arg_34_0.lineList_[var_34_0] or arg_34_0:GetLineClass(arg_34_0.lineType_).New(arg_34_0:GetLineGo(arg_34_0.lineType_), arg_34_0.content_, arg_34_0:GetPointGo(arg_34_0.lineType_))

				arg_34_0.lineList_[var_34_0]:Show(true)
				arg_34_0.lineList_[var_34_0]:RefreshUI(var_34_10, var_34_5)

				var_34_0 = var_34_0 + 1
			end
		end
	end
end

function var_0_0.DrawLine(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.customLineList_[arg_35_1] = arg_35_0.customLineList_[arg_35_1] or SectionCustomLineItem.New(arg_35_0:GetLineGo(2), arg_35_0.content_, arg_35_0:GetPointGo(arg_35_0.lineType_))

	arg_35_0.customLineList_[arg_35_1]:Show(true)
	arg_35_0.customLineList_[arg_35_1]:RefreshUI(arg_35_2)
end

function var_0_0.GetLineClass(arg_36_0, arg_36_1)
	if arg_36_1 == 0 then
		return SectionLineItem
	else
		return SectionBranchLineItem
	end
end

function var_0_0.GetLineGo(arg_37_0, arg_37_1)
	if arg_37_1 == 2 then
		return arg_37_0.lineGo_
	elseif arg_37_1 == 3 then
		return arg_37_0.lineGo2_
	else
		return arg_37_0.lineGo_
	end
end

function var_0_0.GetPointGo(arg_38_0, arg_38_1)
	if arg_38_1 == 2 then
		return arg_38_0.pointGo_
	else
		return arg_38_0.pointGo_
	end
end

function var_0_0.DestroyLine(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.lineList_) do
		iter_39_1:Dispose()
	end

	arg_39_0.lineList_ = {}
end

return var_0_0
