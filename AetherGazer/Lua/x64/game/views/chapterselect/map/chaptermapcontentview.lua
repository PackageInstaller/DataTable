local var_0_0 = class("ChapterMapContentView", ReduxView)

var_0_0.SWITCH_STAGE_TIME = 0.8

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationMainUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.itemList_ = {}
	arg_3_0.positionList_ = {}
	arg_3_0.chapterList_ = {}
	arg_3_0.mainPlotChapterToggleList_ = {}
	arg_3_0.tempVector3_ = Vector3.New(0, 0, 0)
	arg_3_0.tempVector2_ = Vector2.New(0, 0)

	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.changeSelectChapterHandler_ = handler(arg_3_0, arg_3_0.ChangeSelectChapterID)
	arg_3_0.changeSelectHardLevelHandler_ = handler(arg_3_0, arg_3_0.ChangeSelectHardLevel)

	for iter_3_0 = 1, 4 do
		arg_3_0.itemList_[iter_3_0] = ChapterMapItemView.New(arg_3_0.mapItem_, arg_3_0.itemParent_)
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.chapterBehindImage_.immediate = true
	arg_4_0.chapterFrontImage_.immediate = true
	arg_4_0.viewportTransform_ = arg_4_0.mapViewPort_.transform
	arg_4_0.hardLevelView_ = HardLevelChapterView.New(arg_4_0.difficultPanel_)
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.hardLevelView_:OnEnter()
	arg_6_0:RefreshData()
	arg_6_0:RefreshUI()
	arg_6_0:CheckChapterSurvey()
	arg_6_0:CheckStoryLineRedPoint()
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, arg_6_0.changeSelectChapterHandler_)
	manager.notify:RegistListener(CHANGE_PLOT_HARD_LEVEL, arg_6_0.changeSelectHardLevelHandler_)
end

function var_0_0.CheckStoryLineRedPoint(arg_7_0)
	if getData("CHAPTERVIEW", "STORYLINE_REDPNT") then
		manager.redPoint:SetRedPointIndependent(arg_7_0.chapterTimeLineBtn_.transform, false)
	else
		manager.redPoint:SetRedPointIndependent(arg_7_0.chapterTimeLineBtn_.transform, true, nil, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.CheckChapterSurvey(arg_8_0)
	if not getData("CHAPTERVIEW", "POPED_SURVEY_" .. arg_8_0.selectChapterClientID_) and SurveyData:GetChapterSurveyUrl(arg_8_0.selectChapterClientID_) and ChapterTools.IsClearChapterClient(arg_8_0.selectChapterClientID_) then
		saveData("CHAPTERVIEW", "POPED_SURVEY_" .. arg_8_0.selectChapterClientID_, true)
		JumpTools.OpenPageByJump("chapterSurveyPop", {
			chapterID = arg_8_0.selectChapterClientID_
		})
	end
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0:StopAllTimer()
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, arg_9_0.changeSelectChapterHandler_)
	manager.notify:RemoveListener(CHANGE_PLOT_HARD_LEVEL, arg_9_0.changeSelectHardLevelHandler_)
	arg_9_0.hardLevelView_:OnExit()

	arg_9_0.viewSelectID_ = nil

	for iter_9_0, iter_9_1 in pairs(arg_9_0.mainPlotChapterToggleList_) do
		iter_9_1:OnExit()
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.itemList_) do
		iter_9_3:OnExit()
	end

	arg_9_0.isFirstEnter_ = false

	arg_9_0:StopLeanTween()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.changeSelectChapterHandler_ = nil
	arg_10_0.changeSelectHardLevelHandler_ = nil

	arg_10_0.scrollRect_.onValueChanged:RemoveAllListeners()
	arg_10_0.hardLevelView_:Dispose()

	arg_10_0.hardLevelView_ = nil

	for iter_10_0, iter_10_1 in pairs(arg_10_0.mainPlotChapterToggleList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.mainPlotChapterToggleList_ = nil

	arg_10_0:RemoveListeners()

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.itemList_) do
		iter_10_3:Dispose()
	end

	arg_10_0.itemList_ = {}

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.BeginDragFun)))
	arg_11_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.DragFun)))
	arg_11_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.EndDragFun)))
	arg_11_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.ScrollFunc)))
	arg_11_0.scrollRect_.onValueChanged:AddListener(function()
		arg_11_0:RefreshItemPosition()
	end)
	arg_11_0:AddBtnListener(arg_11_0.chapterTimeLineBtn_, nil, function()
		gameContext:Go("/chapterTimeline")
		saveData("CHAPTERVIEW", "STORYLINE_REDPNT", true)
		OperationRecorder.RecordButtonTouch("story_timeline_entrance_1")
	end)
end

function var_0_0.BeginDragFun(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:StopMoveTimer()
	arg_14_0:StopSnapTimer()
	arg_14_0:AddToggleTimer()
end

function var_0_0.DragFun(arg_15_0, arg_15_1, arg_15_2)
	if math.abs(arg_15_2.position.x - arg_15_2.pressPosition.x) > GameSetting.chapter_scroll_length_threshold.value[1] then
		arg_15_0:RefreshSelectChapter(0)
	end
end

function var_0_0.EndDragFun(arg_16_0, arg_16_1, arg_16_2)
	manager.audio:PlayUIAudioByVoice("stage_slide")
	arg_16_0:AddSnapTimer()
end

function var_0_0.ScrollFunc(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:StopMoveTimer()

	local var_17_0 = arg_17_0:SearchNearClientID()

	arg_17_0.selectChapterClientID_ = var_17_0

	arg_17_0:ChangeSelectID(var_17_0)
	arg_17_0:RefreshSelectChapter(0)
	arg_17_0:AddSnapTimer()
end

function var_0_0.StopMoveAction(arg_18_0)
	arg_18_0:RefreshSelectChapter(arg_18_0.selectChapterClientID_)
	arg_18_0:AutoSwitchImage()
end

function var_0_0.InitImage(arg_19_0)
	local var_19_0 = ChapterClientCfg[arg_19_0.selectChapterClientID_]
	local var_19_1 = SpritePathCfg.ChapterPaint.path .. var_19_0.chapter_paint

	arg_19_0.chapterBehindImage_.spriteAsync = var_19_1
	arg_19_0.chapterFrontImage_.spriteAsync = var_19_1
end

function var_0_0.AutoSwitchImage(arg_20_0)
	local var_20_0 = arg_20_0.selectChapterClientID_
	local var_20_1 = ChapterClientCfg[var_20_0]
	local var_20_2 = SpritePathCfg.ChapterPaint.path .. var_20_1.chapter_paint

	arg_20_0.chapterBehindImage_.spriteAsync = var_20_2

	local var_20_3 = var_0_0.SWITCH_STAGE_TIME

	arg_20_0:StopLeanTween()

	arg_20_0.leanTweenHandler_ = LeanTween.value(arg_20_0.chapterFrontImage_.gameObject, arg_20_0.chapterFrontCanvasGroup_.alpha, 0, var_20_3)

	arg_20_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
		arg_20_0.chapterFrontCanvasGroup_.alpha = arg_21_0
		arg_20_0.chapterBehindCanvasGroup_.alpha = 1 - arg_21_0
	end))
	arg_20_0.leanTweenHandler_:setOnComplete(System.Action(function()
		arg_20_0:SwitchImageOver()
		arg_20_0:StopLeanTween()
	end))
end

function var_0_0.StopLeanTween(arg_23_0)
	if arg_23_0.leanTweenHandler_ then
		LeanTween.cancel(arg_23_0.chapterFrontImage_.gameObject)
		arg_23_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		arg_23_0.leanTweenHandler_ = nil
	end
end

function var_0_0.SwitchImageOver(arg_24_0)
	arg_24_0.chapterBehindImage_, arg_24_0.chapterFrontImage_ = arg_24_0.chapterFrontImage_, arg_24_0.chapterBehindImage_
	arg_24_0.chapterBehindCanvasGroup_, arg_24_0.chapterFrontCanvasGroup_ = arg_24_0.chapterFrontCanvasGroup_, arg_24_0.chapterBehindCanvasGroup_
end

function var_0_0.RemoveListeners(arg_25_0)
	arg_25_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_25_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_25_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_25_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)
end

function var_0_0.RefreshData(arg_26_0)
	arg_26_0.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	arg_26_0.hardLevel_ = ChapterClientCfg[arg_26_0.selectChapterClientID_] and ChapterClientCfg[arg_26_0.selectChapterClientID_].difficulty or 1
	arg_26_0.chapterList_ = {}

	local var_26_0 = getChapterClientList()[arg_26_0.hardLevel_]

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if ChapterTools.HasChapterStage(iter_26_1) then
			table.insert(arg_26_0.chapterList_, iter_26_1)
		end
	end

	arg_26_0.maxChapterLevel_ = #arg_26_0.chapterList_
end

function var_0_0.RefreshUI(arg_27_0)
	arg_27_0:InitImage()
	arg_27_0:RefreshViewContent()
	arg_27_0:ChangeSelectChapterID()
	arg_27_0:RefreshSelectDifficult()
	arg_27_0:RefreshSelectChapter(arg_27_0.selectChapterClientID_)
	arg_27_0:RefreshToggle()
end

function var_0_0.ChangeSelectHardLevel(arg_28_0)
	arg_28_0:RefreshData()
	arg_28_0:RefreshSelectChapter(0)
	arg_28_0:RefreshViewContent()
	arg_28_0:RefreshItemPosition()
	arg_28_0:RefreshSelectDifficult()
	arg_28_0:RefreshToggle()

	arg_28_0.changeLevel_ = true
end

function var_0_0.RefreshToggle(arg_29_0)
	local var_29_0 = ChapterMainPlotToggleCfg.get_id_list_by_difficulty[arg_29_0.hardLevel_]

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		local var_29_1 = arg_29_0.mainPlotChapterToggleList_[iter_29_0] or ChapterMapToggleView.New(arg_29_0.chapterItem_, arg_29_0.chapterParentGo_)

		arg_29_0.mainPlotChapterToggleList_[iter_29_0] = var_29_1

		var_29_1:SetData(iter_29_1)
	end

	for iter_29_2 = #var_29_0 + 1, #arg_29_0.mainPlotChapterToggleList_ do
		arg_29_0.mainPlotChapterToggleList_[iter_29_2]:Show(false)
	end

	arg_29_0:RefreshSelectChapterToggle()
end

function var_0_0.RefreshSelectChapter(arg_30_0, arg_30_1)
	if arg_30_0.viewSelectID_ == arg_30_1 then
		return
	end

	arg_30_0.viewSelectID_ = arg_30_1

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.itemList_) do
		iter_30_1:SetSelectID(arg_30_1)
	end
end

function var_0_0.RefreshSelectChapterToggle(arg_31_0)
	arg_31_0.scrollTimer_ = FrameTimer.New(function()
		local var_32_0, var_32_1 = arg_31_0:GetToggleIndex()

		if arg_31_0.lastToggleIndx_ == var_32_0 then
			return
		end

		arg_31_0.lastToggleIndx_ = var_32_0
		arg_31_0.tempVector3_.x = 0
		arg_31_0.tempVector3_.y = 0
		arg_31_0.tempVector3_.z = 0

		local var_32_2 = arg_31_0.viewTf_:InverseTransformPoint(arg_31_0.mainPlotChapterToggleList_[var_32_0]:GetTransform():TransformPoint(arg_31_0.tempVector3_))

		if var_32_2.x <= 0 or var_32_2.x >= arg_31_0.viewTf_.rect.width then
			local var_32_3 = (var_32_0 - 1) / ((arg_31_0.contentTf_.rect.width - arg_31_0.viewTf_.rect.width) / (arg_31_0.itemTf_.rect.width + arg_31_0.contentLayout_.spacing))

			if var_32_3 > 1 then
				var_32_3 = 1
			elseif var_32_3 < 0 then
				var_32_3 = 0
			end

			arg_31_0.scrollView_.horizontalNormalizedPosition = var_32_3
		end

		for iter_32_0, iter_32_1 in pairs(arg_31_0.mainPlotChapterToggleList_) do
			iter_32_1:SetSelectID(arg_31_0.selectChapterClientID_)
		end
	end, 1, 1)

	arg_31_0.scrollTimer_:Start()
end

function var_0_0.GetToggleIndex(arg_33_0)
	local var_33_0 = ChapterMainPlotToggleCfg.get_id_list_by_difficulty[arg_33_0.hardLevel_]

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		if table.keyof(ChapterMainPlotToggleCfg[iter_33_1].chapter_client_list, arg_33_0.selectChapterClientID_) then
			return iter_33_0, #var_33_0
		end
	end

	return #var_33_0, #var_33_0
end

function var_0_0.RefreshViewContent(arg_34_0)
	local var_34_0 = arg_34_0.mapItemTf_.rect.width
	local var_34_1 = arg_34_0.layoutGroup_.spacing
	local var_34_2 = arg_34_0.layoutGroup_.padding.left
	local var_34_3 = arg_34_0.layoutGroup_.padding.right
	local var_34_4 = 0

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.chapterList_) do
		var_34_4 = var_34_4 + 1

		if arg_34_0.positionList_[iter_34_0] == nil then
			arg_34_0.positionList_[iter_34_0] = Vector3.New(var_34_2 + (var_34_0 + var_34_1) * (iter_34_0 - 1) + var_34_0 / 2, 0, 0)
		end
	end

	local var_34_5 = var_34_2 + var_34_0 * var_34_4 + var_34_1 * (var_34_4 - 1) + var_34_3 - arg_34_0.viewportTransform_.rect.width

	arg_34_0.tempVector2_.x = var_34_5
	arg_34_0.tempVector2_.y = arg_34_0.mapItemParentTf_.sizeDelta.y
	arg_34_0.mapItemParentTf_.sizeDelta = arg_34_0.tempVector2_
end

function var_0_0.IsDisplayItem(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.itemList_) do
		if arg_35_1 == iter_35_1:GetChapterClientID() then
			return iter_35_0
		end
	end
end

function var_0_0.RefreshItemPosition(arg_36_0)
	local var_36_0, var_36_1 = arg_36_0:CalcStartToEndIndex()
	local var_36_2 = {}
	local var_36_3 = {}

	for iter_36_0 = var_36_0, var_36_1 do
		local var_36_4 = arg_36_0.chapterList_[iter_36_0]
		local var_36_5 = arg_36_0:IsDisplayItem(var_36_4)

		if var_36_5 then
			arg_36_0.itemList_[var_36_5]:SetChapterClientID(arg_36_0.chapterList_[iter_36_0])
			arg_36_0.itemList_[var_36_5]:SetLocalPosition(arg_36_0.positionList_[iter_36_0])
			table.insert(var_36_2, var_36_5)
		else
			table.insert(var_36_3, iter_36_0)
		end
	end

	for iter_36_1, iter_36_2 in ipairs(var_36_3) do
		for iter_36_3, iter_36_4 in ipairs(arg_36_0.itemList_) do
			if not table.keyof(var_36_2, iter_36_3) then
				table.insert(var_36_2, iter_36_3)
				iter_36_4:SetChapterClientID(arg_36_0.chapterList_[iter_36_2])
				iter_36_4:SetLocalPosition(arg_36_0.positionList_[iter_36_2])

				break
			end
		end
	end

	for iter_36_5 = 1, #arg_36_0.itemList_ do
		if not table.keyof(var_36_2, iter_36_5) then
			arg_36_0.itemList_[iter_36_5]:Show(false)
		end
	end
end

function var_0_0.CalcStartToEndIndex(arg_37_0)
	local var_37_0 = arg_37_0.viewportTransform_.rect.width
	local var_37_1 = arg_37_0.mapItemTf_.rect.width / 2
	local var_37_2 = 1
	local var_37_3 = 1
	local var_37_4 = arg_37_0.mapItemParentTf_.localPosition.x

	arg_37_0.chapterList_ = arg_37_0.chapterList_ or {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.chapterList_) do
		local var_37_5 = arg_37_0.positionList_[iter_37_0].x + var_37_4

		if var_37_5 + var_37_1 < 0 then
			var_37_2 = iter_37_0
		end

		if var_37_5 + var_37_1 >= 0 and var_37_0 >= var_37_5 - var_37_1 then
			var_37_3 = iter_37_0
		end
	end

	if var_37_3 < var_37_2 then
		var_37_3 = var_37_2
	end

	return var_37_2, var_37_3
end

function var_0_0.RefreshSelectDifficult(arg_38_0)
	arg_38_0.hardLevelView_:SetData(arg_38_0.hardLevel_, 0)
end

function var_0_0.ChangeSelectChapterID(arg_39_0)
	arg_39_0:RefreshData()
	arg_39_0:StopAllTimer()
	arg_39_0.scrollRect_:StopMovement()

	local var_39_0 = arg_39_0:GetItemPositionX(arg_39_0.selectChapterClientID_)

	if arg_39_0.changeLevel_ or not arg_39_0.isFirstEnter_ then
		local var_39_1 = arg_39_0.mapItemParentTf_.localPosition

		arg_39_0.tempVector3_.x = var_39_0
		arg_39_0.tempVector3_.y = var_39_1.y
		arg_39_0.tempVector3_.z = var_39_1.z
		arg_39_0.mapItemParentTf_.localPosition = arg_39_0.tempVector3_

		arg_39_0:RefreshItemPosition()
		arg_39_0:StopMoveAction()
	else
		arg_39_0:AddMoveTimer(var_39_0)
	end

	arg_39_0:RefreshSelectChapterToggle()

	if arg_39_0.changeLevel_ or not arg_39_0.isFirstEnter_ then
		arg_39_0.changeLevel_ = false
		arg_39_0.isFirstEnter_ = true
	else
		arg_39_0:RefreshSelectChapter(0)
	end
end

function var_0_0.ChangeSelectID(arg_40_0, arg_40_1)
	if not arg_40_1 then
		return
	end

	if arg_40_1 == BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT) then
		return
	end

	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, arg_40_1)
	arg_40_0:RefreshSelectChapterToggle()
end

function var_0_0.SearchNearClientID(arg_41_0)
	local var_41_0
	local var_41_1 = 200000
	local var_41_2 = arg_41_0.viewportTransform_.localPosition.x + arg_41_0.viewportTransform_.rect.width / 2

	for iter_41_0, iter_41_1 in ipairs(arg_41_0.chapterList_) do
		local var_41_3 = arg_41_0.positionList_[iter_41_0]
		local var_41_4 = math.abs(var_41_3.x + arg_41_0.mapItemParentTf_.localPosition.x - arg_41_0.viewportTransform_.rect.width / 2)

		if var_41_4 <= var_41_1 then
			var_41_1 = var_41_4
			var_41_0 = iter_41_1
		end
	end

	return var_41_0
end

function var_0_0.GetItemPositionX(arg_42_0, arg_42_1)
	local var_42_0 = table.keyof(arg_42_0.chapterList_, arg_42_1)
	local var_42_1 = arg_42_0.mapItemParentTf_.localPosition

	return -arg_42_0.positionList_[var_42_0].x + arg_42_0.viewportTransform_.rect.width / 2
end

function var_0_0.AddSnapTimer(arg_43_0)
	arg_43_0:StopSnapTimer()

	arg_43_0.snapTimer_ = FrameTimer.New(function()
		if arg_43_0.scrollRect_.velocity.x > -200 and arg_43_0.scrollRect_.velocity.x < 200 then
			arg_43_0.scrollRect_:StopMovement()

			local var_44_0 = arg_43_0:SearchNearClientID()

			arg_43_0.selectChapterClientID_ = var_44_0

			arg_43_0:ChangeSelectID(var_44_0)

			local var_44_1 = arg_43_0:GetItemPositionX(var_44_0)

			arg_43_0:AddMoveTimer(var_44_1)
			arg_43_0:StopSnapTimer()
		end
	end, 1, -1)

	arg_43_0.snapTimer_:Start()
end

function var_0_0.StopSnapTimer(arg_45_0)
	if arg_45_0.snapTimer_ then
		arg_45_0.snapTimer_:Stop()

		arg_45_0.snapTimer_ = nil
	end
end

function var_0_0.AddMoveTimer(arg_46_0, arg_46_1)
	arg_46_0:StopMoveTimer()

	arg_46_0.moveTimer_ = FrameTimer.New(function()
		local var_47_0 = arg_46_0.mapItemParentTf_.localPosition
		local var_47_1 = GameSetting.chapter_velocity_times.value[1] * math.pow(arg_46_0.scrollRect_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_46_0.tempVector3_.x = arg_46_1
		arg_46_0.tempVector3_.y = var_47_0.y
		arg_46_0.tempVector3_.z = var_47_0.z

		local var_47_2 = Vector3.Lerp(var_47_0, arg_46_0.tempVector3_, var_47_1)
		local var_47_3 = GameSetting.chapter_scroll_min_length.value[1]

		if var_47_3 > math.abs(var_47_0.x - var_47_2.x) then
			local var_47_4 = arg_46_1 - var_47_0.x

			if var_47_3 < math.abs(var_47_4) then
				var_47_4 = var_47_3 * var_47_4 / math.abs(var_47_4)
			end

			var_47_2.x = var_47_2.x + var_47_4
		end

		arg_46_0.mapItemParentTf_.anchoredPosition = var_47_2

		if math.abs(var_47_0.x - arg_46_1) <= GameSetting.chapter_stop_min_length.value[1] then
			arg_46_0.scrollView_:StopMovement()

			arg_46_0.mapItemParentTf_.anchoredPosition = arg_46_0.tempVector3_

			arg_46_0:StopToggleTimer()
			arg_46_0:StopMoveTimer()
			arg_46_0:StopMoveAction()
		end
	end, 1, -1)

	arg_46_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_48_0)
	if arg_48_0.moveTimer_ then
		arg_48_0.moveTimer_:Stop()

		arg_48_0.moveTimer_ = nil
	end
end

function var_0_0.AddToggleTimer(arg_49_0)
	arg_49_0:StopToggleTimer()

	arg_49_0.toggleTimer_ = FrameTimer.New(function()
		local var_50_0 = arg_49_0:SearchNearClientID()

		arg_49_0.selectChapterClientID_ = var_50_0

		arg_49_0:ChangeSelectID(var_50_0)
	end, 1, -1)

	arg_49_0.toggleTimer_:Start()
end

function var_0_0.StopToggleTimer(arg_51_0)
	if arg_51_0.toggleTimer_ then
		arg_51_0.toggleTimer_:Stop()

		arg_51_0.toggleTimer_ = nil
	end
end

function var_0_0.StopAllTimer(arg_52_0)
	arg_52_0:StopMoveTimer()
	arg_52_0:StopSnapTimer()
	arg_52_0:StopToggleTimer()
end

function var_0_0.OnAssetPendDownloadEnd(arg_53_0, arg_53_1, arg_53_2)
	for iter_53_0, iter_53_1 in ipairs(arg_53_0.itemList_) do
		iter_53_1:RefreshLock()
	end
end

return var_0_0
