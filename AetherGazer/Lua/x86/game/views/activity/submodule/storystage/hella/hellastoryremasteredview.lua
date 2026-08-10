local var_0_0 = class("HellaStoryRemasteredView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/ChapterSectionUI/HellaSelectStageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.switchController_ = ControllerUtil.GetController(arg_3_0.goSwitch_.transform, "name")
	arg_3_0.btnLockController_ = ControllerUtil.GetController(arg_3_0.btnSwitch_.transform, "name")
	arg_3_0.storyChapterView_ = {}
	arg_3_0.stageItemList_ = {}
	arg_3_0.scrollMoveView_ = ScrollMoveView.New(arg_3_0, arg_3_0.goScrollView_)

	local var_3_0 = arg_3_0:FindCom(typeof(RectTransform), nil, arg_3_0.goStageItem_.transform).rect.width

	arg_3_0.scrollContenLineView_ = ScrollContentLineView.New(arg_3_0.goLineItem_, arg_3_0.goItemParent_, var_3_0, 30, 4)
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "active")

	arg_3_0.controller_:SetSelectedState("off")

	arg_3_0.extraStoryView_ = SubPlotExtraStoryBtn.New(arg_3_0.extraStoryGo_)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_4_0:IsOpenSectionInfo() then
			arg_4_0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	arg_4_0:RefreshData()

	local var_4_0 = getChapterClientCfgByChapterID(arg_4_0.selectChapterID_)
	local var_4_1 = var_4_0.id

	if not getData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. var_4_1) then
		saveData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. var_4_1, 1)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_POLT_NEW_TAG, var_4_1), 0, RedPointStyle.SHOW_NEW_TAG)
	end

	local var_4_2 = ChapterClientCfg[var_4_0.id].chapter_list

	for iter_4_0 = 1, 3 do
		arg_4_0.storyChapterView_[iter_4_0] = arg_4_0.storyChapterView_[iter_4_0] or HellaStoryChapterView.New(arg_4_0[string.format("chapterBtn%s_", iter_4_0)], var_4_2[iter_4_0])
	end

	for iter_4_1, iter_4_2 in pairs(arg_4_0.storyChapterView_) do
		iter_4_2:OnEnter(arg_4_0.selectChapterID_)
	end

	arg_4_0:RefreshUI()
	BattleStageAction.ClickSubPlot(arg_4_0.selectChapterID_)
	manager.notify:RegistListener(CHANGE_CHAPTER, arg_4_0.changeChapterHandler_)
	arg_4_0.extraStoryView_:OnEnter()
	manager.redPoint:bindUIandKey(arg_4_0.transformRedPoint2_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, var_4_2[4]))
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.storyChapterView_) do
		iter_6_1:OnExit()
	end

	arg_6_0.scrollMoveView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, arg_6_0.changeChapterHandler_)
	arg_6_0.extraStoryView_:OnExit()

	local var_6_0 = getChapterClientCfgByChapterID(arg_6_0.selectChapterID_)
	local var_6_1 = ChapterClientCfg[var_6_0.id].chapter_list

	manager.redPoint:unbindUIandKey(arg_6_0.transformRedPoint2_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, var_6_1[4]))
end

function var_0_0.OnUpdate(arg_7_0)
	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.storyChapterView_) do
		iter_7_1:OnUpdate(arg_7_0.selectChapterID_)
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.extraStoryView_:Dispose()

	arg_8_0.extraStoryView_ = nil

	var_0_0.super.Dispose(arg_8_0)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.storyChapterView_) do
		iter_8_1:Dispose()
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0.stageItemList_) do
		iter_8_3:Dispose()
	end

	arg_8_0.stageItemList_ = nil

	arg_8_0.scrollContenLineView_:Dispose()

	arg_8_0.scrollContenLineView_ = nil

	arg_8_0.scrollMoveView_:Dispose()

	arg_8_0.scrollMoveView_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btnSwitch_, nil, function()
		local var_10_0 = getChapterClientCfgByChapterID(arg_9_0.selectChapterID_)

		if table.keyof(var_10_0.chapter_list, arg_9_0.selectChapterID_) < 4 then
			local var_10_1 = ChapterCfg[var_10_0.chapter_list[4]].section_id_list[1]

			if BattleStageData:GetStageData()[var_10_1] == nil then
				local var_10_2 = ChapterCfg[var_10_0.chapter_list[3]].subhead

				ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), var_10_2))

				return
			else
				local var_10_3 = var_10_0.chapter_list[4]
				local var_10_4 = BattleFieldData:GetCacheStage(var_10_3) or ChapterCfg[var_10_3].section_id_list[1]

				BattleFieldData:SetStageByClientID(var_10_0.id, var_10_4)
				BattleFieldData:SetCacheChapterClient(getChapterToggle(var_10_0.id), var_10_0.id)
				BattleFieldData:SetSecondCacheChapter(getChapterToggle(var_10_0.id), arg_9_0.selectChapterID_, var_10_0.id)
				BattleFieldData:SetCacheChapter(var_10_0.id, var_10_3)
				BattleStageAction.ClickSubPlot(var_10_3)
				JumpTools.Jump2SubPlot(var_10_0.id, true)
			end
		else
			local var_10_5 = BattleFieldData:GetSecondCacheChapter(getChapterToggle(var_10_0.id), var_10_0.id) or var_10_0.chapter_list[1]
			local var_10_6 = BattleFieldData:GetCacheStage(var_10_5) or ChapterCfg[var_10_5].section_id_list[1]

			BattleFieldData:SetStageByClientID(var_10_0.id, var_10_6)
			BattleFieldData:SetCacheChapterClient(getChapterToggle(var_10_0.id), var_10_0.id)
			BattleFieldData:SetCacheChapter(var_10_0.id, var_10_5)
			JumpTools.Jump2SubPlot(var_10_0.id, true)
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.btnWarChess_, nil, function()
		local var_11_0 = getChapterClientCfgByChapterID(arg_9_0.selectChapterID_)

		JumpTools.OpenPageByJump("/subPlotChessView", {
			tag = ChessConst.SUBPLOT_TAG.HELLA
		})
	end)
end

function var_0_0.RefreshData(arg_12_0)
	if arg_12_0.params_.chapterID == nil then
		local var_12_0 = arg_12_0.params_.chapterClientID
		local var_12_1 = ChapterClientCfg[var_12_0]

		arg_12_0.selectChapterID_ = BattleFieldData:GetCacheChapter(var_12_1.id)

		if table.keyof(var_12_1.chapter_list, arg_12_0.selectChapterID_) < 4 then
			local var_12_2 = BattleFieldData:GetSecondCacheChapter(getChapterToggle(var_12_1.id), var_12_0)

			if table.keyof(var_12_1.chapter_list, var_12_2) then
				arg_12_0.selectChapterID_ = var_12_2
			else
				arg_12_0.selectChapterID_ = var_12_1.chapter_list[1]
			end
		end
	else
		arg_12_0.selectChapterID_ = arg_12_0.params_.chapterID
	end

	arg_12_0.stageData_ = BattleStageData:GetStageData()
	arg_12_0.stageList_ = ChapterCfg[arg_12_0.selectChapterID_].section_id_list

	arg_12_0.extraStoryView_:SetData(arg_12_0.selectChapterID_)
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = arg_13_0.selectChapterID_

	arg_13_0.selectStageID_ = BattleFieldData:GetCacheStage(var_13_0) or ChapterCfg[var_13_0].section_id_list[1]

	arg_13_0:RefreshStageList()

	local var_13_1 = arg_13_0:GetScrollPos()
	local var_13_2 = arg_13_0:GetScrollWidth()

	arg_13_0.scrollMoveView_:RefreshUI(var_13_1, var_13_2)
	arg_13_0:RefreshSwitchBtn()
	arg_13_0:RefreshSelectItem()
	arg_13_0:RefreshChapterPanel()
	arg_13_0:RefreshRedPoint()
end

function var_0_0.RefreshSwitchBtn(arg_14_0)
	local var_14_0 = getChapterClientCfgByChapterID(arg_14_0.selectChapterID_)

	if table.keyof(var_14_0.chapter_list, arg_14_0.selectChapterID_) < 4 then
		arg_14_0.switchController_:SetSelectedState("1")

		arg_14_0.text_1.text = GetTips("FRONT_CHAPTER")
		arg_14_0.text_2.text = GetTips("AFTER_CHAPTER")
		arg_14_0.text_3.text = GetTips("AFTER_CHAPTER")
		arg_14_0.titleText_.text = GetTips("FRONT_CHAPTER")
	else
		arg_14_0.switchController_:SetSelectedState("2")

		arg_14_0.text_1.text = GetTips("AFTER_CHAPTER")
		arg_14_0.text_2.text = GetTips("FRONT_CHAPTER")
		arg_14_0.text_3.text = GetTips("FRONT_CHAPTER")
		arg_14_0.titleText_.text = GetTips("AFTER_CHAPTER")
	end

	local var_14_1 = ChapterCfg[var_14_0.chapter_list[4]].section_id_list[1]

	if BattleStageData:GetStageData()[var_14_1] == nil then
		arg_14_0.btnLockController_:SetSelectedState("false")
	else
		arg_14_0.btnLockController_:SetSelectedState("true")
	end
end

function var_0_0.RefreshChapterPanel(arg_15_0)
	local var_15_0 = getChapterClientCfgByChapterID(arg_15_0.selectChapterID_)

	if table.keyof(ChapterClientCfg[var_15_0.id].chapter_list, arg_15_0.selectChapterID_) > 3 then
		SetActive(arg_15_0.goChapterPanel1_, false)
	else
		SetActive(arg_15_0.goChapterPanel1_, true)
	end
end

function var_0_0.GetScrollWidth(arg_16_0)
	local var_16_0 = arg_16_0.stageList_[1]

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.stageList_) do
		if not arg_16_0.stageData_[iter_16_1] then
			break
		end

		var_16_0 = iter_16_1
	end

	local var_16_1 = BattleActivityStoryStageCfg[var_16_0]

	return var_16_1 and var_16_1.position[1] or 0
end

function var_0_0.GetScrollPos(arg_17_0)
	local var_17_0 = arg_17_0.selectStageID_
	local var_17_1 = BattleActivityStoryStageCfg[var_17_0]

	return var_17_1 and var_17_1.position[1] or 0
end

function var_0_0.RefreshStageList(arg_18_0)
	for iter_18_0 = 1, #arg_18_0.stageItemList_ do
		arg_18_0.stageItemList_[iter_18_0]:Show(false)
	end

	local var_18_0 = BattleStageData:GetStageData()

	for iter_18_1 = 1, #arg_18_0.stageList_ do
		if iter_18_1 == 1 or var_18_0[arg_18_0.stageList_[iter_18_1]] then
			if not arg_18_0.stageItemList_[iter_18_1] then
				arg_18_0.stageItemList_[iter_18_1] = arg_18_0:GetStageItemClass().New(arg_18_0.goStageItem_, arg_18_0.goItemParent_)
			end

			arg_18_0.stageItemList_[iter_18_1]:SetData(arg_18_0.stageList_[iter_18_1], arg_18_0.selectChapterID_)
		end
	end

	arg_18_0.scrollContenLineView_:CreateLineItemList(arg_18_0.stageData_, arg_18_0.stageList_, arg_18_0.stageItemList_)
end

function var_0_0.RefreshSelectItem(arg_19_0)
	local var_19_0 = arg_19_0.selectStageID_

	for iter_19_0, iter_19_1 in pairs(arg_19_0.stageItemList_) do
		iter_19_1:SelectorItem(var_19_0)
	end
end

function var_0_0.IsOpenSectionInfo(arg_20_0)
	return arg_20_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_0.GetStageItemClass(arg_21_0)
	return HellaStoryRemasteredItem
end

function var_0_0.RefreshRedPoint(arg_22_0)
	local var_22_0 = getChapterClientCfgByChapterID(arg_22_0.selectChapterID_).chapter_list

	if table.keyof(var_22_0, arg_22_0.selectChapterID_) < 4 then
		local var_22_1 = var_22_0[4]

		if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, var_22_1)) == 1 and BattleStageData:GetSubPlotRedPointFlag(var_22_1) ~= 1 then
			SetActive(arg_22_0.transformRedPoint2_.gameObject, true)

			return
		end
	end

	SetActive(arg_22_0.transformRedPoint2_.gameObject, false)
end

return var_0_0
