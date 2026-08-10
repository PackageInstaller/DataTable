local var_0_0 = class("ChapterSelectSubChapterView", ReduxView)

var_0_0.MAX_DRAG_LENGTH = 1500
var_0_0.MIN_DRAG_LENGTH = 200
var_0_0.SWITCH_STAGE_TIME = 0.8

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationSideUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.chapterBehindImage_.immediate = true
	arg_3_0.chapterFrontImage_.immediate = true

	arg_3_0:AddListeners()

	arg_3_0.tempVector2_ = Vector2.New(0, 0, 0)
	arg_3_0.chapterSelectTitleView_ = ChapterSelectTitleView.New(arg_3_0.titleGo_)
	arg_3_0.changeSelectChapterHandler_ = handler(arg_3_0, arg_3_0.ChangeSelectChapterID)
	arg_3_0.lockController_ = arg_3_0.controllerEx_:GetController("lock")
	arg_3_0.chapterToggleItemList_ = {}
	arg_3_0.positionList_ = {}
end

function var_0_0.OnTop(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
end

function var_0_0.RefeshGroupData(arg_5_0)
	arg_5_0.groupDataList_ = ChapterTools.GetChapterGroupList(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT))

	table.sort(arg_5_0.groupDataList_, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0[2]
		local var_6_1 = arg_6_1[2]
		local var_6_2 = ChapterClientCfg[var_6_0]
		local var_6_3 = ChapterClientCfg[var_6_1]

		if var_6_2.sort < var_6_3.sort then
			return true
		else
			return false
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefeshGroupData()
	arg_7_0:RefreshViewContent()
	arg_7_0:RefreshData()
	arg_7_0:InitImage()
	arg_7_0:RefreshUI()
	arg_7_0.chapterSelectTitleView_:OnEnter(arg_7_0.selectChapterClientID_)
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, arg_7_0.changeSelectChapterHandler_)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.chapterToggleItemList_) do
		iter_7_1:OnEnter()
	end

	arg_7_0:RefreshItemPosition()
	arg_7_0:CheckChapterSurvey()
	arg_7_0:CheckStoryLineRedPoint()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	arg_8_0.chapterSelectTitleView_:OnExit()
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, arg_8_0.changeSelectChapterHandler_)
	arg_8_0:StopAllTimer()
	arg_8_0:StopLeanTween()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.chapterToggleItemList_) do
		iter_8_1:OnExit()
	end
end

function var_0_0.CheckChapterSurvey(arg_9_0)
	if not getData("CHAPTERVIEW", "POPED_SURVEY_" .. arg_9_0.selectChapterClientID_) and SurveyData:GetChapterSurveyUrl(arg_9_0.selectChapterClientID_) and SurveyData:GetChapterSurveyUrl(arg_9_0.selectChapterClientID_) ~= "" and ChapterTools.IsClearChapterClient(arg_9_0.selectChapterClientID_) then
		saveData("CHAPTERVIEW", "POPED_SURVEY_" .. arg_9_0.selectChapterClientID_, true)
		JumpTools.OpenPageByJump("chapterSurveyPop", {
			chapterID = arg_9_0.selectChapterClientID_
		})
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.scrollView_.onValueChanged:RemoveAllListeners()

	arg_10_0.changeSelectChapterHandler_ = nil
	arg_10_0.chapterBehindImage_ = nil

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.chapterToggleItemList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.chapterToggleItemList_ = nil

	arg_10_0.chapterSelectTitleView_:Dispose()

	arg_10_0.chapterSelectTitleView_ = nil

	arg_10_0:RemoveListeners()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.BeginDragFun)))
	arg_11_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.DragFun)))
	arg_11_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.EndDragFun)))
	arg_11_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.PointerUpFun)))
	arg_11_0.toggleEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_11_0, arg_11_0.BeginToggleDragFun)))
	arg_11_0.scrollView_.onValueChanged:AddListener(function()
		arg_11_0:RefreshItemPosition()
	end)
	arg_11_0:AddBtnListener(arg_11_0.surveyBtn_, nil, function()
		local var_13_0 = arg_11_0.selectChapterClientID_

		JumpTools.OpenPageByJump("chapterSurveyPop", {
			chapterID = var_13_0
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.chapterTimeLineBtn_, nil, function()
		gameContext:Go("/chapterTimeline")
		saveData("CHAPTERVIEW", "STORYLINE_REDPNT", true)
		OperationRecorder.RecordButtonTouch("story_timeline_entrance_2")
	end)
end

function var_0_0.CheckStoryLineRedPoint(arg_15_0)
	if getData("CHAPTERVIEW", "STORYLINE_REDPNT") then
		manager.redPoint:SetRedPointIndependent(arg_15_0.chapterTimeLineBtn_.transform, false)
	else
		manager.redPoint:SetRedPointIndependent(arg_15_0.chapterTimeLineBtn_.transform, true, nil, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.BeginDragFun(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:StopLeanTween()
end

function var_0_0.GetNeighborClientID(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = -1

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.groupDataList_) do
		if iter_17_1[2] == arg_17_1 then
			var_17_0 = iter_17_0

			break
		end
	end

	if arg_17_2 and var_17_0 < #arg_17_0.groupDataList_ then
		var_17_0 = var_17_0 + 1
	elseif not arg_17_2 and var_17_0 > 1 then
		var_17_0 = var_17_0 - 1
	end

	if var_17_0 > 0 then
		return arg_17_0.groupDataList_[var_17_0][2]
	else
		return arg_17_1
	end
end

function var_0_0.DragFun(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2.position.x - arg_18_2.pressPosition.x
	local var_18_1 = arg_18_0:GetNeighborClientID(arg_18_0.selectChapterClientID_, var_18_0 < 0)

	if var_18_1 == arg_18_0.selectChapterClientID_ then
		return
	end

	if arg_18_0.nextChapterClientID_ ~= var_18_1 then
		local var_18_2 = ChapterClientCfg[var_18_1]
		local var_18_3 = SpritePathCfg.ChapterPaint.path .. var_18_2.chapter_paint

		arg_18_0.chapterBehindImage_.spriteAsync = var_18_3
		arg_18_0.nextChapterClientID_ = var_18_1
	end

	local var_18_4 = math.min(math.max(0, math.abs(var_18_0)), var_0_0.MAX_DRAG_LENGTH) / var_0_0.MAX_DRAG_LENGTH

	arg_18_0.chapterFrontCanvasGroup_.alpha = 1 - var_18_4
	arg_18_0.chapterBehindCanvasGroup_.alpha = var_18_4
end

function var_0_0.EndDragFun(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2.position.x - arg_19_2.pressPosition.x

	if arg_19_0:GetNeighborClientID(arg_19_0.selectChapterClientID_, var_19_0 < 0) == arg_19_0.selectChapterClientID_ then
		return
	end

	if math.abs(var_19_0) > var_0_0.MIN_DRAG_LENGTH then
		if arg_19_0.selectChapterClientID_ == arg_19_0.nextChapterClientID_ then
			return
		end

		arg_19_0.selectChapterClientID_ = arg_19_0.nextChapterClientID_
		arg_19_0.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, arg_19_0.selectChapterClientID_)
		arg_19_0:RefreshData()

		if math.abs(var_19_0) > var_0_0.MAX_DRAG_LENGTH then
			arg_19_0:RefreshChapterUI()
			arg_19_0:SwitchImageOver()
		else
			local var_19_1 = (var_0_0.MAX_DRAG_LENGTH - math.abs(var_19_0)) / var_0_0.MAX_DRAG_LENGTH * var_0_0.SWITCH_STAGE_TIME

			arg_19_0.leanTweenHandler_ = LeanTween.value(arg_19_0.chapterFrontImage_.gameObject, arg_19_0.chapterFrontCanvasGroup_.alpha, 0, var_19_1)

			arg_19_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
				arg_19_0.chapterFrontCanvasGroup_.alpha = arg_20_0
				arg_19_0.chapterBehindCanvasGroup_.alpha = 1 - arg_20_0
			end))
			arg_19_0.leanTweenHandler_:setOnComplete(System.Action(function()
				arg_19_0:RefreshChapterUI()
				arg_19_0:SwitchImageOver()
				LeanTween.cancel(arg_19_0.chapterFrontImage_.gameObject)
				arg_19_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

				arg_19_0.leanTweenHandler_ = nil
			end))
		end
	else
		local var_19_2 = (1 - (var_0_0.MIN_DRAG_LENGTH - math.abs(var_19_0)) / var_0_0.MIN_DRAG_LENGTH) * 0.8

		arg_19_0.leanTweenHandler_ = LeanTween.value(arg_19_0.chapterFrontImage_.gameObject, arg_19_0.chapterFrontCanvasGroup_.alpha, 1, var_19_2)

		arg_19_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
			arg_19_0.chapterFrontCanvasGroup_.alpha = arg_22_0
			arg_19_0.chapterBehindCanvasGroup_.alpha = 1 - arg_22_0
		end))
		arg_19_0.leanTweenHandler_:setOnComplete(System.Action(function()
			LeanTween.cancel(arg_19_0.chapterFrontImage_.gameObject)
			arg_19_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

			arg_19_0.leanTweenHandler_ = nil
		end))
	end
end

function var_0_0.PointerUpFun(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2.dragging then
		return
	end

	JumpTools.Jump2SubPlot(arg_24_0.selectChapterClientID_, false, true)
end

function var_0_0.BeginToggleDragFun(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:StopMoveTimer()
	arg_25_0.scrollView_:OnBeginDrag(arg_25_2)
end

function var_0_0.RemoveListeners(arg_26_0)
	arg_26_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_26_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_26_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_26_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	arg_26_0.toggleEventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
end

function var_0_0.SwitchImageOver(arg_27_0)
	arg_27_0.chapterBehindImage_, arg_27_0.chapterFrontImage_ = arg_27_0.chapterFrontImage_, arg_27_0.chapterBehindImage_
	arg_27_0.chapterBehindCanvasGroup_, arg_27_0.chapterFrontCanvasGroup_ = arg_27_0.chapterFrontCanvasGroup_, arg_27_0.chapterBehindCanvasGroup_
	arg_27_0.chapterFrontCanvasGroup_.alpha = 1
	arg_27_0.chapterBehindCanvasGroup_.alpha = 0
end

function var_0_0.AutoSwitchImage(arg_28_0)
	local var_28_0 = arg_28_0.selectChapterClientID_
	local var_28_1 = ChapterClientCfg[var_28_0]
	local var_28_2 = SpritePathCfg.ChapterPaint.path .. var_28_1.chapter_paint

	arg_28_0.chapterBehindImage_.spriteAsync = var_28_2

	local var_28_3 = var_0_0.SWITCH_STAGE_TIME

	arg_28_0.leanTweenHandler_ = LeanTween.value(arg_28_0.chapterFrontImage_.gameObject, arg_28_0.chapterFrontCanvasGroup_.alpha, 0, var_28_3)

	arg_28_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
		arg_28_0.chapterFrontCanvasGroup_.alpha = arg_29_0
		arg_28_0.chapterBehindCanvasGroup_.alpha = 1 - arg_29_0
	end))
	arg_28_0.leanTweenHandler_:setOnComplete(System.Action(function()
		arg_28_0:SwitchImageOver()
		LeanTween.cancel(arg_28_0.chapterFrontImage_.gameObject)
		arg_28_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		arg_28_0.leanTweenHandler_ = nil
	end))
end

function var_0_0.RefreshData(arg_31_0)
	arg_31_0.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)

	local var_31_0 = ChapterClientCfg[arg_31_0.selectChapterClientID_].chapter_list[1]

	arg_31_0.isLock_ = not ChapterTools.IsUnlockSubPlotClient(var_31_0)

	SetActive(arg_31_0.surveyBtn_.gameObject, SurveyData:GetChapterSurveyID(arg_31_0.selectChapterClientID_) and SurveyData:GetChapterSurveyID(arg_31_0.selectChapterClientID_) ~= 0 and ChapterTools.IsClearChapterClient(arg_31_0.selectChapterClientID_))
end

function var_0_0.InitImage(arg_32_0)
	local var_32_0 = ChapterClientCfg[arg_32_0.selectChapterClientID_]
	local var_32_1 = SpritePathCfg.ChapterPaint.path .. var_32_0.chapter_paint

	arg_32_0.chapterBehindImage_.spriteAsync = var_32_1
	arg_32_0.chapterFrontImage_.spriteAsync = var_32_1
end

function var_0_0.RefreshUI(arg_33_0)
	arg_33_0:RefreshChapterUI()
	arg_33_0:AutoSwitchImage()
end

function var_0_0.RefreshChapterUI(arg_34_0)
	arg_34_0.chapterSelectTitleView_:OnEnter(arg_34_0.selectChapterClientID_)
	arg_34_0:RefreshGroupToggle()
	arg_34_0:AddActivityTimer()
	arg_34_0:RefreshActivity()
	arg_34_0:RefreshLock()
	arg_34_0:RefreshSelectToggle()
end

function var_0_0.RefreshGroupToggle(arg_35_0)
	arg_35_0:AddMoveTimer(arg_35_0:GetItemPositionX(arg_35_0.selectChapterClientID_))
end

function var_0_0.RefreshActivity(arg_36_0)
	return
end

function var_0_0.RefreshLock(arg_37_0)
	local var_37_0 = ChapterClientCfg[arg_37_0.selectChapterClientID_].asset_pend_key

	if not manager.assetPend:CheckAssetPend(var_37_0) then
		arg_37_0.lockController_:SetSelectedState("assetpend")
	else
		arg_37_0.lockController_:SetSelectedState("false")
	end
end

function var_0_0.ChangeSelectChapterID(arg_38_0)
	arg_38_0:StopLeanTween()
	arg_38_0:RefreshData()
	arg_38_0:RefreshUI()
end

function var_0_0.GetActivityID(arg_39_0)
	local var_39_0 = arg_39_0.selectChapterClientID_
	local var_39_1 = ChapterClientCfg[var_39_0].chapter_list[1]

	return ChapterCfg[var_39_1].activity_id or 0
end

function var_0_0.AddActivityTimer(arg_40_0)
	arg_40_0:RemoveActivityTimer()

	local var_40_0 = arg_40_0.selectChapterClientID_
	local var_40_1 = ChapterClientCfg[var_40_0].chapter_list[1]
	local var_40_2 = arg_40_0:GetActivityID()

	if var_40_2 == 0 then
		return
	end

	local var_40_3 = ActivityData:GetActivityData(var_40_2):IsActivitying()

	arg_40_0.activityTimer_ = Timer.New(function()
		local var_41_0 = ActivityData:GetActivityData(var_40_2):IsActivitying()

		if var_41_0 ~= var_40_3 then
			var_40_3 = var_41_0
			arg_40_0.isLock_ = not ChapterTools.IsUnlockSubPlotClient(var_40_1)

			arg_40_0:RefreshLock()
			arg_40_0:RefreshActivity()
		end
	end, 1, -1)

	arg_40_0.activityTimer_:Start()
end

function var_0_0.RemoveActivityTimer(arg_42_0)
	if arg_42_0.activityTimer_ then
		arg_42_0.activityTimer_:Stop()

		arg_42_0.activityTimer_ = nil
	end
end

function var_0_0.AddMoveTimer(arg_43_0, arg_43_1)
	arg_43_0:StopMoveTimer()

	arg_43_0.moveTimer_ = FrameTimer.New(function()
		local var_44_0 = arg_43_0.chapterParentTf_.rect.width / 2
		local var_44_1 = arg_43_0.scrollTf_.rect.width / 2
		local var_44_2 = arg_43_0.chapterParentTf_.anchoredPosition
		local var_44_3 = arg_43_1 * -1

		if var_44_1 >= var_44_0 + var_44_3 then
			var_44_3 = var_44_1 - var_44_0
		elseif var_44_1 >= var_44_0 - var_44_3 then
			var_44_3 = var_44_0 - var_44_1
		end

		local var_44_4 = 3 * math.pow(arg_43_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_43_0.tempVector2_.x = var_44_3
		arg_43_0.tempVector2_.y = var_44_2.y
		arg_43_0.chapterParentTf_.anchoredPosition = Vector2.Lerp(var_44_2, arg_43_0.tempVector2_, var_44_4)

		if math.abs(var_44_2.x - var_44_3) <= 1 then
			arg_43_0.chapterParentTf_.anchoredPosition = arg_43_0.tempVector2_

			arg_43_0:StopMoveTimer()
		end
	end, 1, -1)

	arg_43_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_45_0)
	if arg_45_0.moveTimer_ then
		arg_45_0.moveTimer_:Stop()

		arg_45_0.moveTimer_ = nil
	end
end

function var_0_0.StopLeanTween(arg_46_0)
	if arg_46_0.leanTweenHandler_ then
		LeanTween.cancel(arg_46_0.chapterFrontImage_.gameObject)
		arg_46_0.leanTweenHandler_:callOnCompletes()
	end
end

function var_0_0.StopAllTimer(arg_47_0)
	arg_47_0:StopMoveTimer()
	arg_47_0:RemoveActivityTimer()
end

function var_0_0.RefreshViewContent(arg_48_0)
	local var_48_0 = arg_48_0.chapterItemTf_.rect.width
	local var_48_1 = arg_48_0.layoutGroup_.spacing
	local var_48_2 = arg_48_0.layoutGroup_.padding.left
	local var_48_3 = arg_48_0.layoutGroup_.padding.right
	local var_48_4 = 0

	for iter_48_0, iter_48_1 in ipairs(arg_48_0.groupDataList_) do
		var_48_4 = var_48_4 + 1
	end

	local var_48_5 = var_48_2 + var_48_0 * var_48_4 + var_48_1 * (var_48_4 - 1) + var_48_3

	arg_48_0.chapterParentTf_.sizeDelta = Vector2(var_48_5, arg_48_0.chapterParentTf_.sizeDelta.y)

	for iter_48_2, iter_48_3 in ipairs(arg_48_0.groupDataList_) do
		arg_48_0.positionList_[iter_48_2] = Vector3(var_48_2 + (var_48_0 + var_48_1) * (iter_48_2 - 1) + var_48_0 / 2 - var_48_5 / 2, 0, 0)
	end

	local var_48_6 = arg_48_0.viewportTransform_.rect.width / (var_48_0 + var_48_1) + 2

	for iter_48_4 = 1, var_48_6 do
		if arg_48_0.chapterToggleItemList_[iter_48_4] == nil then
			arg_48_0.chapterToggleItemList_[iter_48_4] = ChapterSelectSubChapterToggleItem.New(arg_48_0.chapterToggleItem_, arg_48_0.chapterParentTf_)
		end
	end
end

function var_0_0.RefreshItemPosition(arg_49_0)
	local var_49_0, var_49_1 = arg_49_0:CalcStartToEndIndex()
	local var_49_2 = {}
	local var_49_3 = {}

	for iter_49_0 = #arg_49_0.chapterToggleItemList_ + 1, var_49_1 - var_49_0 + 1 do
		arg_49_0.chapterToggleItemList_[iter_49_0] = ChapterSelectSubChapterToggleItem.New(arg_49_0.chapterToggleItem_, arg_49_0.chapterParentTf_)
	end

	for iter_49_1 = var_49_0, var_49_1 do
		local var_49_4 = arg_49_0.groupDataList_[iter_49_1][2]
		local var_49_5 = arg_49_0:IsDisplayItem(var_49_4)

		if var_49_5 then
			arg_49_0.chapterToggleItemList_[var_49_5]:SetData(var_49_4)
			arg_49_0.chapterToggleItemList_[var_49_5]:SetLocalPosition(arg_49_0.positionList_[iter_49_1])
			arg_49_0.chapterToggleItemList_[var_49_5]:SetSelect(var_49_4 == arg_49_0.selectChapterClientID_)
			table.insert(var_49_2, var_49_5)
		else
			table.insert(var_49_3, iter_49_1)
		end
	end

	for iter_49_2, iter_49_3 in ipairs(var_49_3) do
		for iter_49_4, iter_49_5 in ipairs(arg_49_0.chapterToggleItemList_) do
			if not table.keyof(var_49_2, iter_49_4) then
				table.insert(var_49_2, iter_49_4)

				local var_49_6 = arg_49_0.groupDataList_[iter_49_3][2]

				iter_49_5:SetData(var_49_6)
				iter_49_5:SetLocalPosition(arg_49_0.positionList_[iter_49_3])
				iter_49_5:SetSelect(var_49_6 == arg_49_0.selectChapterClientID_)

				break
			end
		end
	end

	for iter_49_6 = 1, #arg_49_0.chapterToggleItemList_ do
		if not table.keyof(var_49_2, iter_49_6) then
			arg_49_0.chapterToggleItemList_[iter_49_6]:Show(false)
		end
	end
end

function var_0_0.CalcStartToEndIndex(arg_50_0)
	local var_50_0 = arg_50_0.viewportTransform_.rect.width
	local var_50_1 = arg_50_0.chapterItemTf_.rect.width / 2
	local var_50_2 = 1
	local var_50_3 = 1
	local var_50_4 = arg_50_0.chapterParentTf_.localPosition.x

	for iter_50_0, iter_50_1 in ipairs(arg_50_0.groupDataList_) do
		local var_50_5 = arg_50_0.positionList_[iter_50_0].x + var_50_4

		if var_50_5 - var_50_1 < 0 then
			var_50_2 = iter_50_0
		end

		if var_50_5 + var_50_1 >= 0 and var_50_0 >= var_50_5 - var_50_1 then
			var_50_3 = iter_50_0
		end
	end

	if var_50_3 < var_50_2 then
		var_50_3 = var_50_2
	end

	return var_50_2, var_50_3
end

function var_0_0.IsDisplayItem(arg_51_0, arg_51_1)
	for iter_51_0, iter_51_1 in ipairs(arg_51_0.chapterToggleItemList_) do
		if arg_51_1 == iter_51_1:GetChapterClientID() then
			return iter_51_0
		end
	end
end

function var_0_0.GetItemPositionX(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in ipairs(arg_52_0.groupDataList_) do
		if iter_52_1[2] == arg_52_1 then
			return arg_52_0.positionList_[iter_52_0].x
		end
	end

	return 0
end

function var_0_0.RefreshSelectToggle(arg_53_0)
	for iter_53_0, iter_53_1 in ipairs(arg_53_0.chapterToggleItemList_) do
		local var_53_0 = iter_53_1:GetChapterClientID()

		iter_53_1:SetSelect(var_53_0 == arg_53_0.selectChapterClientID_)
	end
end

function var_0_0.OnAssetPendDownloadEnd(arg_54_0, arg_54_1, arg_54_2)
	arg_54_0:RefreshLock()
end

return var_0_0
