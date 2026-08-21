local var_0_0 = class("ActivityFactoryStoryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/plot/MardukplotUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.GetItemClass(arg_3_0)
	return ActivityFactoryStoryItem
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()

	arg_4_0.stageItemList_ = {}
	arg_4_0.scrollMoveView_ = ScrollMoveView.New(arg_4_0, arg_4_0.scrollViewGo_)
	arg_4_0.storyChapterView_ = {}
	arg_4_0.lineList_ = {}
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_5_0:IsOpenSectionInfo() then
			arg_5_0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	arg_5_0:RegistEventListener(STAGE_ARCHIVE_RED_UPDATE, function()
		arg_5_0:RefreshArchiveCollectBtn()
	end)
	manager.ui:SetMainCamera("null")
	arg_5_0:RefreshData()
	arg_5_0:RefreshUI()

	for iter_5_0, iter_5_1 in ipairs(ChapterClientCfg[6010004].chapter_list) do
		local var_5_0 = arg_5_0[string.format("chapterGo%s_", iter_5_0)]

		if var_5_0 then
			arg_5_0.storyChapterView_[iter_5_0] = arg_5_0.storyChapterView_[iter_5_0] or ActivityFactoryStoryChapterItem.New(var_5_0, iter_5_1)
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0.storyChapterView_) do
		iter_5_3:OnEnter(arg_5_0.chapterID_)
	end
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	for iter_8_0, iter_8_1 in pairs(arg_8_0.storyChapterView_) do
		iter_8_1:OnExit()
	end

	arg_8_0.scrollMoveView_:OnExit()

	arg_8_0.stopMove_ = false
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0.stopMove_ = false
end

function var_0_0.OnUpdate(arg_10_0)
	if arg_10_0:IsOpenRoute("stageArchive") then
		arg_10_0.stopMove_ = true

		return
	end

	arg_10_0:RefreshData()
	arg_10_0:RefreshUI()

	for iter_10_0, iter_10_1 in pairs(arg_10_0.storyChapterView_) do
		iter_10_1:OnUpdate(arg_10_0.chapterID_)
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.lineList_) do
		iter_11_1:Dispose()
	end

	arg_11_0.lineList_ = nil

	for iter_11_2, iter_11_3 in pairs(arg_11_0.stageItemList_) do
		iter_11_3:Dispose()
	end

	arg_11_0.stageItemList_ = nil

	arg_11_0.scrollMoveView_:Dispose()

	arg_11_0.scrollMoveView_ = nil

	for iter_11_4, iter_11_5 in pairs(arg_11_0.storyChapterView_) do
		iter_11_5:Dispose()
	end

	arg_11_0.storyChapterView_ = nil
end

function var_0_0.AddListeners(arg_12_0)
	if arg_12_0.archiveCollectBtn_ then
		arg_12_0:AddBtnListener(arg_12_0.archiveCollectBtn_, nil, function()
			JumpTools.OpenPageByJump("stageArchiveCollect", {
				chapterID = arg_12_0.chapterID_
			})
		end)
	end
end

function var_0_0.RefreshData(arg_14_0)
	if arg_14_0.params_.chapterID == nil then
		local var_14_0 = arg_14_0.params_.chapterClientID
		local var_14_1 = ChapterClientCfg[var_14_0]

		arg_14_0.chapterID_ = BattleFieldData:GetCacheChapter(var_14_1.id)

		if table.keyof(var_14_1.chapter_list, arg_14_0.chapterID_) < 4 then
			arg_14_0.chapterID_ = BattleFieldData:GetSecondCacheChapter(getChapterToggle(var_14_1.id), var_14_1.id) or var_14_1.chapter_list[1]
		end
	else
		arg_14_0.chapterID_ = arg_14_0.params_.chapterID
	end

	arg_14_0.stageData_ = BattleStageData:GetStageData()
	arg_14_0.stageList_ = ChapterCfg[arg_14_0.chapterID_].section_id_list
	arg_14_0.selectStageID_ = BattleFieldData:GetCacheStage(arg_14_0.chapterID_) or arg_14_0.stageList_[1]
end

function var_0_0.RefreshUI(arg_15_0)
	local var_15_0 = arg_15_0:GetScrollPos()
	local var_15_1 = arg_15_0:GetScrollWidth()

	if not arg_15_0.stopMove_ then
		arg_15_0.scrollMoveView_:RefreshUI(var_15_0, var_15_1)
	end

	local var_15_2 = ChapterCfg[arg_15_0.chapterID_]
	local var_15_3 = 0
	local var_15_4 = 0

	for iter_15_0, iter_15_1 in pairs(var_15_2.section_id_list) do
		local var_15_5 = arg_15_0.stageData_[iter_15_1]

		if var_15_5 then
			var_15_3 = var_15_3 + 1

			if var_15_5.clear_times > 0 then
				var_15_4 = var_15_4 + 1
			end
		end
	end

	for iter_15_2 = #arg_15_0.stageItemList_, var_15_3 + 1, -1 do
		arg_15_0.stageItemList_[iter_15_2]:OnExit()
	end

	for iter_15_3 = 1, var_15_3 do
		if arg_15_0.stageItemList_[iter_15_3] == nil then
			arg_15_0.stageItemList_[iter_15_3] = arg_15_0:GetItemClass().New(arg_15_0.sectionItem_, arg_15_0.content_)
		end

		arg_15_0.stageItemList_[iter_15_3]:SetData(arg_15_0.stageList_[iter_15_3], arg_15_0.chapterID_)
	end

	arg_15_0:RefreshSelectItem()

	arg_15_0.nameText_.text = GetI18NText(var_15_2.subhead)
	arg_15_0.finishCntText_.text = string.format("%s/%s", var_15_4, #var_15_2.section_id_list)

	arg_15_0:CreateLineItemList(var_15_3)
	arg_15_0:RefreshArchiveCollectBtn()
end

function var_0_0.RefreshSelectItem(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.stageItemList_) do
		iter_16_1:SelectorItem(arg_16_0.selectStageID_)
	end
end

function var_0_0.GetScrollWidth(arg_17_0)
	local var_17_0 = arg_17_0.stageList_[1]

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.stageList_) do
		if not arg_17_0.stageData_[iter_17_1] then
			break
		end

		var_17_0 = iter_17_1
	end

	local var_17_1 = BattleActivityStoryStageCfg[var_17_0]

	return var_17_1 and var_17_1.position[1] or 0
end

function var_0_0.GetScrollPos(arg_18_0)
	local var_18_0 = arg_18_0.selectStageID_
	local var_18_1 = BattleActivityStoryStageCfg[var_18_0]

	return var_18_1 and var_18_1.position[1] or 0
end

function var_0_0.IsOpenSectionInfo(arg_19_0)
	return arg_19_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_0.AddTimer(arg_20_0)
	local var_20_0 = ChapterCfg[arg_20_0.chapterID_].activity_id

	arg_20_0.stopTime_ = ActivityData:GetActivityData(var_20_0).stopTime

	arg_20_0:StopTimer()

	if manager.time:GetServerTime() >= arg_20_0.stopTime_ then
		arg_20_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_20_0.textTime_.text = manager.time:GetLostTimeStr(arg_20_0.stopTime_)
	arg_20_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_20_0.stopTime_ then
			arg_20_0:StopTimer()

			arg_20_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_20_0.textTime_.text = manager.time:GetLostTimeStr(arg_20_0.stopTime_)
	end, 1, -1)

	arg_20_0.timer_:Start()
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()

		arg_22_0.timer_ = nil
	end
end

function var_0_0.CreateLineItemList(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.lineList_) do
		iter_23_1:Show(false)
	end

	local var_23_0 = 1

	for iter_23_2 = 2, arg_23_1 do
		local var_23_1 = ChapterCfg[arg_23_0.chapterID_].section_id_list[iter_23_2]
		local var_23_2 = arg_23_0.stageItemList_[iter_23_2]:GetLocalPosition() + Vector3(-130, 0, 0)
		local var_23_3 = BattleActivityStoryStageCfg[var_23_1]
		local var_23_4 = arg_23_0.stageItemList_[iter_23_2 - 1]:GetLocalPosition() + Vector3(130, 0, 0)

		arg_23_0.lineList_[var_23_0] = arg_23_0.lineList_[var_23_0] or arg_23_0:GetLineClass().New(arg_23_0.lineGo_, arg_23_0.content_, 3)

		arg_23_0.lineList_[var_23_0]:Show(true)
		arg_23_0.lineList_[var_23_0]:RefreshUI(var_23_4, var_23_2)

		var_23_0 = var_23_0 + 1
	end
end

function var_0_0.RefreshArchiveCollectBtn(arg_24_0)
	if arg_24_0.archiveCollectBtn_ then
		SetActive(arg_24_0.archiveCollectBtn_.gameObject, StageTools.IsNeedStageArchiveEntrace(arg_24_0.chapterID_))
		manager.redPoint:SetRedPointIndependent(arg_24_0.archiveCollectBtn_.transform, StageTools.IsHavedStageArchiveRedInChapter(arg_24_0.chapterID_))
	end
end

function var_0_0.GetLineClass(arg_25_0)
	return SectionSingleLineItem
end

return var_0_0
