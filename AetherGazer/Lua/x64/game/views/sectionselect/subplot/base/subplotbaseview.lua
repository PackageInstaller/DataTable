local var_0_0 = class("SubPlotBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/hera/HeraStoryUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stageItemList_ = {}
	arg_3_0.scrollMoveView_ = ScrollMoveView.New(arg_3_0, arg_3_0.scrollViewGo_)
	arg_3_0.changeChapterHandler_ = handler(arg_3_0, arg_3_0.ChangeChapter)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_4_0:IsOpenSectionInfo() then
			arg_4_0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	manager.ui:SetMainCamera("null")
	arg_4_0:RefreshData()
	arg_4_0:RefreshUI()
	manager.notify:RegistListener(CHANGE_CHAPTER, arg_4_0.changeChapterHandler_)
	BattleStageAction.ClickSubPlot(arg_4_0.chapterID_)
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_6_0.scrollMoveView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, arg_6_0.changeChapterHandler_)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.changeChapterHandler_ = nil

	var_0_0.super.Dispose(arg_7_0)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.stageItemList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.stageItemList_ = nil

	arg_7_0.scrollMoveView_:Dispose()

	arg_7_0.scrollMoveView_ = nil
end

function var_0_0.OnUpdate(arg_8_0)
	arg_8_0:RefreshData()
	arg_8_0:RefreshUI()
end

function var_0_0.ChangeChapter(arg_9_0, arg_9_1)
	local var_9_0 = getChapterClientCfgByChapterID(arg_9_1)
	local var_9_1 = BattleFieldData:GetCacheStage(arg_9_1) or ChapterCfg[arg_9_1].section_id_list[1]

	if arg_9_0.params_.section == var_9_1 then
		return
	end

	arg_9_0.params_.chapterID = arg_9_1
	arg_9_0.params_.section = var_9_1

	BattleFieldData:SetStageByClientID(var_9_0.id, var_9_1)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(var_9_0.id), var_9_0.id)
	BattleFieldAction.ChangeSelectChapterID(arg_9_1)
	JumpTools.Jump2SubPlot(var_9_0.id, true)
end

function var_0_0.RefreshData(arg_10_0)
	local var_10_0 = arg_10_0.params_.chapterClientID

	arg_10_0.chapterID_ = BattleFieldData:GetCacheChapter(var_10_0)
	arg_10_0.stageData_ = BattleStageData:GetStageData()
	arg_10_0.stageList_ = ChapterCfg[arg_10_0.chapterID_].section_id_list
	arg_10_0.selectStageID_ = BattleFieldData:GetCacheStage(arg_10_0.chapterID_) or ChapterCfg[arg_10_0.chapterID_].section_id_list[1]
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = arg_11_0:GetScrollPos()
	local var_11_1 = arg_11_0:GetScrollWidth()

	arg_11_0.scrollMoveView_:RefreshUI(var_11_0, var_11_1)

	for iter_11_0 = 1, #arg_11_0.stageItemList_ do
		arg_11_0.stageItemList_[iter_11_0]:Show(false)
	end

	local var_11_2 = BattleStageData:GetStageData()

	for iter_11_1 = 1, #arg_11_0.stageList_ do
		if iter_11_1 == 1 or var_11_2[arg_11_0.stageList_[iter_11_1]] then
			if not arg_11_0.stageItemList_[iter_11_1] then
				arg_11_0.stageItemList_[iter_11_1] = arg_11_0:GetItemClass().New(arg_11_0.sectionItem_, arg_11_0.content_)
			end

			arg_11_0.stageItemList_[iter_11_1]:SetData(arg_11_0.stageList_[iter_11_1], arg_11_0.chapterID_)
		end
	end

	arg_11_0:RefreshSelectItem()
end

function var_0_0.RefreshSelectItem(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.stageItemList_) do
		iter_12_1:SelectorItem(arg_12_0.selectStageID_)
	end
end

function var_0_0.GetItemClass(arg_13_0)
	return SubPlotBaseItem
end

function var_0_0.GetScrollWidth(arg_14_0)
	local var_14_0 = arg_14_0.stageList_[1]

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.stageList_) do
		if not arg_14_0.stageData_[iter_14_1] then
			break
		end

		var_14_0 = iter_14_1
	end

	local var_14_1 = arg_14_0:GetCfgName()[var_14_0]

	return var_14_1 and var_14_1.position[1] or 0
end

function var_0_0.GetScrollPos(arg_15_0)
	local var_15_0 = arg_15_0.selectStageID_
	local var_15_1 = arg_15_0:GetCfgName()[var_15_0]

	return var_15_1 and var_15_1.position[1] or 0
end

function var_0_0.IsOpenSectionInfo(arg_16_0)
	return arg_16_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_0.SwitchBG(arg_17_0)
	local var_17_0 = ChapterCfg[arg_17_0.chapterID_]

	if var_17_0.bg ~= "" then
		arg_17_0.bgImage_.sprite = pureGetSpriteWithoutAtlas(var_17_0.bg)
	end

	SetActive(arg_17_0.bgImage_.gameObject, var_17_0.bg ~= "")
end

function var_0_0.GetCfgName(arg_18_0)
	return BattleActivityStoryStageCfg
end

return var_0_0
