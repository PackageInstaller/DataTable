local var_0_0 = class("StoryTimelineBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/Illustrated_StoryLine/StoryLineMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.tempVector2_ = Vector2.New(0, 0)
	arg_3_0.tempVector3_ = Vector3.New(0, 0, 0)
	arg_3_0.positionList_ = {}
	arg_3_0.itemList_ = {}
	arg_3_0.filterType_ = ChapterConst.TIME_LINE_FILTER_TYPE.ALL
	arg_3_0.sizeState_ = 0
	arg_3_0.itemClickCallBack_ = handler(arg_3_0, arg_3_0.ItemClickCallBack)
	arg_3_0.LockClickCallBack_ = handler(arg_3_0, arg_3_0.LockClickCallBack)
	arg_3_0.initScale_ = 0.75

	arg_3_0:InitUI()

	arg_3_0.scaleConfig = {
		[0] = {
			maxValue = 0.75,
			minValue = 0.5,
			scaleRange = {
				max = 1,
				min = 0.85
			}
		},
		{
			maxValue = 0.5,
			minValue = 0.5,
			fixedScale = 0.85
		},
		{
			maxValue = 0.5,
			minValue = 0,
			scaleRange = {
				max = 0.85,
				min = 0.7
			}
		},
		{
			maxValue = 0,
			minValue = 0,
			fixedScale = 1
		}
	}

	if GameSetting.timeline_scale_state0 and GameSetting.timeline_scale_big and GameSetting.timeline_scale_middle.value and GameSetting.timeline_scale_smallest.value then
		arg_3_0.scaleConfig = {
			[0] = {
				minValue = GameSetting.timeline_scale_state0.value[1],
				maxValue = GameSetting.timeline_scale_state0.value[2],
				scaleRange = {
					min = GameSetting.timeline_scale_state0.value[3],
					max = GameSetting.timeline_scale_state0.value[4]
				}
			},
			{
				maxValue = GameSetting.timeline_scale_big.value[1],
				minValue = GameSetting.timeline_scale_big.value[2],
				fixedScale = GameSetting.timeline_scale_big.value[3]
			},
			{
				minValue = GameSetting.timeline_scale_middle.value[1],
				maxValue = GameSetting.timeline_scale_middle.value[2],
				scaleRange = {
					min = GameSetting.timeline_scale_middle.value[3],
					max = GameSetting.timeline_scale_middle.value[4]
				}
			},
			{
				minValue = GameSetting.timeline_scale_smallest.value[1],
				maxValue = GameSetting.timeline_scale_smallest.value[2],
				fixedScale = GameSetting.timeline_scale_smallest.value[3]
			}
		}
	end

	arg_3_0:RefreshItemSizeState(arg_3_0.sizeState_)

	local var_3_0 = arg_3_0.scaleConfig[arg_3_0.sizeState_]

	arg_3_0.itemScale_ = Mathf.Lerp(var_3_0.scaleRange.max, var_3_0.scaleRange.min, 1 - (arg_3_0.initScale_ - arg_3_0.scaleConfig[1].maxValue) / (1 - arg_3_0.scaleConfig[1].maxValue))
	arg_3_0.isProcessing_ = false
	arg_3_0.isAdjustingSpacing_ = false
	arg_3_0.roleIDList_ = {}
	arg_3_0.normalIDList_ = {}
	arg_3_0.roleScrollList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexRoleItem), arg_3_0.roleList_, StoryTimeLineRoleListItem)
	arg_3_0.normalScrollList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexNormalItem), arg_3_0.normalList_, StoryTimeLineNormalListItem)
	arg_3_0.listStateController_ = arg_3_0.controller_:GetController("listState")
	arg_3_0.maskController_ = arg_3_0.controller_:GetController("mask")
	arg_3_0.axisController_ = arg_3_0.axisControllerEx_:GetController("site")
	arg_3_0.btnController_ = arg_3_0.btnControllerEx_:GetController("tab")

	arg_3_0:InitOpenBtn()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.preLayoutSpacing = arg_4_0.layoutGroup_.spacing
	arg_4_0.layoutGroup_.spacing = arg_4_0.preLayoutSpacing * arg_4_0.initScale_

	arg_4_0:AddListeners()

	local var_4_0 = math.ceil(_G.SCREEN_WIDTH / (arg_4_0.itemTrs_.rect.width * 0.6)) + 2

	for iter_4_0 = 1, var_4_0 do
		arg_4_0.itemList_[iter_4_0] = StoryTimeLineItemBaseView.New(arg_4_0.item_, arg_4_0.itemContentTrs_)

		arg_4_0.itemList_[iter_4_0]:SetClickCallBack(arg_4_0.itemClickCallBack_)
		arg_4_0.itemList_[iter_4_0]:SetLockClickCallBack(arg_4_0.LockClickCallBack_)
	end
end

function var_0_0.InitOpenBtn(arg_5_0)
	arg_5_0.showRoleListOpenController_ = arg_5_0.roleListControllerEx_:GetController("show")
	arg_5_0.showNormalListOpenController_ = arg_5_0.normalListControllEx_:GetController("show")
	arg_5_0.roleListOpenItem_ = StoryTimeLineRoleListItem.New(arg_5_0.roleListOpenGo_)
	arg_5_0.normalListOpenItem_ = StoryTimeLineNormalListItem.New(arg_5_0.normalListOpenGo_)

	arg_5_0.roleListOpenItem_:SetOpenCallback(function(arg_6_0)
		arg_5_0.listAni_:Play("UI_left_cx", -1, 0)
		arg_5_0.listStateController_:SetSelectedState("roleList")
		arg_5_0.showRoleListOpenController_:SetSelectedState("on")
	end)
	arg_5_0.normalListOpenItem_:SetOpenCallback(function(arg_7_0)
		arg_5_0.listAni_:Play("UI_left_cx", -1, 0)
		arg_5_0.listStateController_:SetSelectedState("normalList")
		arg_5_0.showNormalListOpenController_:SetSelectedState("on")
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.oldFilterType_ = arg_9_0.filterType_
	arg_9_0.filterType_ = ChapterTools.GetCacheSelectFilterType(arg_9_0:UIName()) or 0
	arg_9_0.selectTabIndex_ = ChapterTools.GetCacheSelectTabIndex(arg_9_0:UIName()) or 1

	arg_9_0.dropDown_:SetValueWithoutNotify(arg_9_0.filterType_)
	arg_9_0.btnController_:SetSelectedState(arg_9_0.selectTabIndex_)
	SetActive(arg_9_0.timelineSliderGo_, false)
	arg_9_0:RefreshData()

	arg_9_0.selectChapterClientID_ = ChapterTools.GetCacheSelectChapterClientID(arg_9_0:UIName())
	arg_9_0.needRePosition_ = true
	arg_9_0.isEnter_ = true
	arg_9_0.clickChapterID_ = arg_9_0.selectChapterClientID_

	if not arg_9_0.selectChapterClientID_ or arg_9_0.selectChapterClientID_ == 0 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.chapterList_) do
			if ChapterTools.IsFinishPreChapter(iter_9_1) then
				arg_9_0.selectChapterClientID_ = iter_9_1

				break
			end
		end
	end

	arg_9_0:RefreshUI(true)
	arg_9_0:InitTimelineSliderTimer()

	if not arg_9_0.params_.isBack then
		arg_9_0.selectTopTabIndex_ = 1
		arg_9_0.slider_.value = arg_9_0.initScale_

		if arg_9_0.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.ALL then
			arg_9_0.listStateController_:SetSelectedState("none")
		end
	end
end

function var_0_0.RefreshSelectItem(arg_10_0)
	arg_10_0.selectChapterClientID_ = arg_10_0:SearchNearClientID()
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	arg_11_0:StopAllTimer()

	arg_11_0.isProcessing_ = false
	arg_11_0.clickChapterID_ = nil
	arg_11_0.clickMidChapterID_ = nil
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.roleScrollList_:Dispose()
	arg_12_0.normalScrollList_:Dispose()
	arg_12_0.roleListOpenItem_:Dispose()
	arg_12_0.normalListOpenItem_:Dispose()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.itemList_) do
		iter_12_1:Dispose()
	end

	arg_12_0.itemList_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.AddListeners(arg_13_0)
	arg_13_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_13_0, arg_13_0.BeginDragFun)))
	arg_13_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_13_0, arg_13_0.DragFun)))
	arg_13_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_13_0, arg_13_0.EndDragFun)))
	arg_13_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(handler(arg_13_0, arg_13_0.ScrollFunc)))
	arg_13_0.scrollRect_.onValueChanged:AddListener(handler(arg_13_0, arg_13_0.ScrollChangeFunc))
	arg_13_0.timeLineSlider_.onValueChanged:AddListener(handler(arg_13_0, arg_13_0.TimeLineSliderChangeFunc))
	arg_13_0.slider_.onValueChanged:AddListener(handler(arg_13_0, arg_13_0.SliderChangeFunc))
	arg_13_0.dropDown_.onValueChanged:AddListener(handler(arg_13_0, arg_13_0.DropDownChangeFunc))
	arg_13_0:AddBtnListener(arg_13_0.subBtn_, nil, function()
		if arg_13_0.isProcessing_ then
			return
		end

		arg_13_0:HideLeftList()

		arg_13_0.slider_.value = arg_13_0.scaleConfig[2].maxValue
		arg_13_0.clickChapterID_ = arg_13_0.selectChapterClientID_
		arg_13_0.needRePosition_ = true

		arg_13_0.btnController_:SetSelectedState("2")
		OperationRecorder.RecordButtonTouch("story_timeline_button_chapter_class")
	end)
	arg_13_0:AddBtnListener(arg_13_0.addBtn_, nil, function()
		if arg_13_0.isProcessing_ then
			return
		end

		arg_13_0:HideLeftList()

		arg_13_0.clickMidChapterID_ = arg_13_0.selectChapterClientID_
		arg_13_0.needRePosition_ = true
		arg_13_0.slider_.value = arg_13_0.scaleConfig[0].maxValue

		arg_13_0.btnController_:SetSelectedState("1")
		OperationRecorder.RecordButtonTouch("story_timeline_button_chapter")
	end)
	arg_13_0:AddBtnListener(arg_13_0.jumpBtn_, nil, function()
		arg_13_0:HideLeftList()

		arg_13_0.oldFilterType_ = arg_13_0.filterType_
		arg_13_0.filterType_ = ChapterTools.GetCacheSelectFilterType(arg_13_0:UIName())
		arg_13_0.selectTabIndex_ = ChapterTools.GetCacheSelectTabIndex(arg_13_0:UIName())
		arg_13_0.selectChapterClientID_ = ChapterTools.GetCacheSelectChapterClientID(arg_13_0:UIName())

		arg_13_0.dropDown_:SetValueWithoutNotify(arg_13_0.filterType_)
		arg_13_0:RefreshData()
		arg_13_0:RefreshUI(true)
		arg_13_0:SetChapterToCenter(arg_13_0.selectChapterClientID_)
		arg_13_0:RefreshSelectItem()
	end)
	arg_13_0:AddBtnListener(arg_13_0.axisBtn_, nil, function()
		local var_17_0 = ChapterTools.GetCacheSelectChapterClientID(arg_13_0:UIName())
		local var_17_1 = arg_13_0.positionList_[table.indexof(arg_13_0.chapterList_, var_17_0)] and arg_13_0.positionList_[table.indexof(arg_13_0.chapterList_, var_17_0)].x

		if var_17_1 then
			arg_13_0.scrollRect_.content.anchoredPosition = Vector2.New(-var_17_1 + arg_13_0.scrollRect_.transform.rect.width / 2, arg_13_0.scrollRect_.content.anchoredPosition.y)
		end
	end)
end

function var_0_0.ItemClickCallBack(arg_18_0, arg_18_1)
	arg_18_0:HideLeftList()

	if arg_18_0.sizeState_ == 0 or arg_18_0.sizeState_ == 1 then
		local var_18_0 = 1
		local var_18_1 = arg_18_1
		local var_18_2 = ChapterClientCfg[var_18_1]
		local var_18_3 = var_18_2.chapter_list[1]
		local var_18_4, var_18_5 = ChapterTools.IsFinishPreChapter(var_18_3)

		if not var_18_4 then
			ShowTips(ChapterTools.GetChapterLockText(var_18_3, var_18_5))

			return
		end

		ChapterTools.SetCacheSelectFilterType(arg_18_0.filterType_, arg_18_0:UIName())
		ChapterTools.SetCacheSelectTabIndex(arg_18_0.selectTabIndex_, arg_18_0:UIName())
		ChapterTools.SetCacheSelectChapterClientID(var_18_1, arg_18_0:UIName())
		ChapterTools.SetCacheSelectChapterID(var_18_3, arg_18_0:UIName())

		if var_18_2.toggle == BattleConst.TOGGLE.PLOT then
			ChapterTools.GotoChapterSection(var_18_3)
		else
			JumpTools.Jump2SubPlot(var_18_1, false, true)
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "story_timeline_chapter_jump",
			group_id = var_18_1
		})
	else
		arg_18_0.slider_.value = arg_18_0.scaleConfig[0].maxValue
		arg_18_0.clickMidChapterID_ = arg_18_1
		arg_18_0.needRePosition_ = true

		arg_18_0.btnController_:SetSelectedState("1")
		OperationRecorder.RecordButtonTouch({
			button_name = "story_timeline_chapter_class_jump",
			group_id = arg_18_1
		})
	end
end

function var_0_0.LockClickCallBack(arg_19_0, arg_19_1)
	if ChapterClientCfg[arg_19_1].toggle ~= BattleConst.TOGGLE.PLOT then
		local var_19_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)

		if ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT and var_19_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT, var_19_0))

			return
		end
	end

	local var_19_1 = BattleFieldData:GetCacheChapter(arg_19_1)
	local var_19_2, var_19_3 = ChapterTools.IsFinishPreChapter(var_19_1)
	local var_19_4, var_19_5 = ChapterTools.GetLockPreChapterCount(arg_19_1)

	if var_19_4 >= (GameSetting.show_tips_unlock_chapter_num and GameSetting.show_tips_unlock_chapter_num.value[1] or 3) then
		ShowMessageBox({
			content = GetTips("UNLOCK_PRE_CHAPTER_TIPS"),
			OkCallback = function()
				if var_19_5 and var_19_5 > 0 then
					local var_20_0 = arg_19_0.positionList_[table.indexof(arg_19_0.chapterList_, var_19_5)] and arg_19_0.positionList_[table.indexof(arg_19_0.chapterList_, var_19_5)].x

					if var_20_0 then
						arg_19_0.scrollRect_.content.anchoredPosition = Vector2.New(-var_20_0 + arg_19_0.scrollRect_.transform.rect.width / 2, arg_19_0.scrollRect_.content.anchoredPosition.y)
					end

					arg_19_0.needRePosition_ = false
					arg_19_0.clickMidChapterID_ = nil
				end
			end
		})
	else
		ShowTips(GetTips(ChapterTools.GetChapterLockText(var_19_1, var_19_3)))
	end
end

function var_0_0.RestoreTrackedItemPosition(arg_21_0)
	if arg_21_0.needRePosition_ and (arg_21_0.clickMidChapterID_ and arg_21_0.clickMidChapterID_ ~= 0 or arg_21_0.clickChapterID_ and arg_21_0.clickChapterID_ ~= 0) then
		local var_21_0
		local var_21_1

		if arg_21_0.clickMidChapterID_ and (arg_21_0.sizeState_ == 0 or arg_21_0.sizeState_ == 1) then
			var_21_0 = ChapterClassCfg[arg_21_0.clickMidChapterID_].mid_chapter[1]
		elseif arg_21_0.sizeState_ == 2 then
			for iter_21_0, iter_21_1 in ipairs(ChapterClassCfg.all) do
				local var_21_2 = ChapterClassCfg[iter_21_1]

				if table.indexof(var_21_2.mid_chapter, arg_21_0.clickChapterID_) then
					var_21_0 = var_21_2.id

					break
				end
			end
		end

		if arg_21_0.isEnter_ then
			var_21_0 = arg_21_0.clickChapterID_
			arg_21_0.isEnter_ = nil
		end

		local var_21_3 = arg_21_0.positionList_[table.indexof(arg_21_0.chapterList_, var_21_0)] and arg_21_0.positionList_[table.indexof(arg_21_0.chapterList_, var_21_0)].x

		if var_21_3 then
			arg_21_0.scrollRect_.content.anchoredPosition = Vector2.New(-var_21_3 + arg_21_0.scrollRect_.transform.rect.width / 2, arg_21_0.scrollRect_.content.anchoredPosition.y)
		end

		arg_21_0.needRePosition_ = false
		arg_21_0.clickMidChapterID_ = nil
		arg_21_0.clickChapterID_ = nil
	end
end

function var_0_0.BeginDragFun(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:HideLeftList()
	arg_22_0:StopMoveTimer()
	arg_22_0:StopSnapTimer()
	arg_22_0:AddToggleTimer()
end

function var_0_0.DragFun(arg_23_0, arg_23_1, arg_23_2)
	if math.abs(arg_23_2.position.x - arg_23_2.pressPosition.x) > GameSetting.chapter_scroll_length_threshold.value[1] then
		arg_23_0:RefreshSelectChapter(0)
	end
end

function var_0_0.EndDragFun(arg_24_0, arg_24_1, arg_24_2)
	manager.audio:PlayUIAudioByVoice("stage_slide")
	arg_24_0:AddSnapTimer()
end

function var_0_0.ScrollChangeFunc(arg_25_0)
	arg_25_0.timeLineSlider_.value = arg_25_0.scrollRect_.horizontalNormalizedPosition

	if arg_25_0.isProcessing_ then
		return
	end

	arg_25_0:RefreshItemPosition()
end

function var_0_0.SliderChangeFunc(arg_26_0, arg_26_1)
	arg_26_0.sliderValue_ = arg_26_1

	arg_26_0.scrollRect_:StopMovement()
	FrameTimer.New(function()
		if not arg_26_0.isAdjustingSpacing_ then
			arg_26_0.isAdjustingSpacing_ = true

			arg_26_0:RefreshSizeState()

			arg_26_0.isAdjustingSpacing_ = false
		end
	end, 1):Start()
end

function var_0_0.AdjustSpacingAndRefresh(arg_28_0, arg_28_1)
	arg_28_0.layoutGroup_.spacing = arg_28_0.preLayoutSpacing * arg_28_1

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_0.itemContentTrs_)
	arg_28_0:RefreshViewContent(true)
	FrameTimer.New(function()
		arg_28_0:RestoreTrackedItemPosition()
	end, 1):Start()
end

function var_0_0.TimeLineSliderChangeFunc(arg_30_0, arg_30_1)
	if arg_30_0.scrollRect_.horizontalNormalizedPosition ~= arg_30_1 then
		arg_30_0.scrollRect_.horizontalNormalizedPosition = arg_30_1
	end

	arg_30_0:StopMoveTimer()

	local var_30_0 = arg_30_0:SearchNearClientID()

	arg_30_0.timelineSliderTimerTick_ = 0
	arg_30_0.selectChapterClientID_ = var_30_0

	arg_30_0:ChangeSelectID(var_30_0)
	arg_30_0:RefreshSelectChapter(0)
end

function var_0_0.ScrollFunc(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0:StopMoveTimer()

	local var_31_0 = arg_31_0:SearchNearClientID()

	arg_31_0.timelineSliderTimerTick_ = 0
	arg_31_0.selectChapterClientID_ = var_31_0

	arg_31_0:ChangeSelectID(var_31_0)
	arg_31_0:RefreshSelectChapter(0)
	arg_31_0:AddSnapTimer()
end

function var_0_0.DropDownChangeFunc(arg_32_0, arg_32_1)
	arg_32_0.oldFilterType_ = arg_32_0.filterType_
	arg_32_0.filterType_ = arg_32_1
	arg_32_0.selectTabIndex_ = 1

	if arg_32_0.filterType_ ~= 0 then
		if arg_32_0.oldFilterType_ == 0 then
			arg_32_0.cacheAllFilterSliderSize_ = arg_32_0.slider_.value
		end

		arg_32_0.slider_.value = 0.5
	else
		arg_32_0.slider_.value = arg_32_0.cacheAllFilterSliderSize_
	end

	arg_32_0:RefreshData()
	arg_32_0:RefreshUI(true)
	arg_32_0:RefreshSelectItem()
end

function var_0_0.StopMoveAction(arg_33_0)
	arg_33_0:RefreshSelectChapter(arg_33_0.selectChapterClientID_)
end

function var_0_0.RemoveListeners(arg_34_0)
	arg_34_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_34_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_34_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_34_0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)
end

function var_0_0.RefreshData(arg_35_0)
	arg_35_0.chapterList_ = {}

	if arg_35_0.filterType_ == 0 then
		if arg_35_0.sizeState_ == 0 or arg_35_0.sizeState_ == 1 then
			arg_35_0.chapterList_ = ChapterTools.GetNormalPlotAndSubPlotChapterList()
		elseif arg_35_0.sizeState_ == 2 then
			arg_35_0.chapterList_ = ChapterTools.GetChapterClassIDList()
		elseif arg_35_0.sizeState_ == 3 then
			arg_35_0.chapterList_ = ChapterTools.GetBigChapterClassIDList()
		end
	elseif arg_35_0.filterType_ ~= 0 then
		arg_35_0.chapterList_ = ChapterClassSiftCfg[ChapterClassSiftCfg.get_id_list_by_sift_id[arg_35_0.filterType_][arg_35_0.selectTabIndex_]].class_chapter
		arg_35_0.normalIDList_ = ChapterClassSiftCfg.get_id_list_by_sift_id[arg_35_0.filterType_]
	end
end

function var_0_0.IndexRoleItem(arg_36_0, arg_36_1, arg_36_2)
	arg_36_2:SetData(arg_36_1, arg_36_0.normalIDList_[arg_36_1])
	arg_36_2:SetClickCallBack(function(arg_37_0)
		arg_36_0:SelectLeftItem(arg_37_0)
		arg_36_0.roleListOpenItem_:SetData(arg_37_0, arg_36_0.normalIDList_[arg_37_0])
	end)

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.normalScrollList_:GetItemList()) do
		iter_36_1:SetSelected(arg_36_0.selectTabIndex_)
	end
end

function var_0_0.IndexNormalItem(arg_38_0, arg_38_1, arg_38_2)
	arg_38_2:SetData(arg_38_1, arg_38_0.normalIDList_[arg_38_1])
	arg_38_2:SetClickCallBack(function(arg_39_0)
		arg_38_0:SelectLeftItem(arg_39_0)
		arg_38_0.normalListOpenItem_:SetData(arg_39_0, arg_38_0.normalIDList_[arg_39_0])
	end)

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.normalScrollList_:GetItemList()) do
		iter_38_1:SetSelected(arg_38_0.selectTabIndex_)
	end
end

function var_0_0.SelectLeftItem(arg_40_0, arg_40_1)
	if arg_40_1 == arg_40_0.selectTabIndex_ then
		return
	end

	arg_40_0.selectTabIndex_ = arg_40_1

	arg_40_0:RefreshSizeStateValue()
	arg_40_0:RefreshData()
	arg_40_0:RefreshViewContent(true)
	arg_40_0:RefreshSelectChapter(arg_40_0.selectChapterClientID_)
	FrameTimer.New(function()
		arg_40_0:RefreshItemPosition()
		arg_40_0:RefreshSelectItem()

		for iter_41_0, iter_41_1 in ipairs(arg_40_0.normalScrollList_:GetItemList()) do
			iter_41_1:SetSelected(arg_40_1)
		end

		arg_40_0:RestoreTrackedItemPosition()
	end, 1):Start()
end

function var_0_0.RefreshUI(arg_42_0, arg_42_1)
	arg_42_0:RefreshViewContent(arg_42_1)
	arg_42_0:RefreshSelectChapter(arg_42_0.selectChapterClientID_)
	arg_42_0:RefreshListState()
	FrameTimer.New(function()
		arg_42_0:RefreshItemPosition()
		arg_42_0:RestoreTrackedItemPosition()
	end, 1):Start()
end

function var_0_0.RefreshListState(arg_44_0)
	if arg_44_0.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.HERO then
		if arg_44_0.oldFilterType_ ~= arg_44_0.filterType_ then
			arg_44_0.listAni_:Play("UI_left_cx", -1, 0)
		end

		arg_44_0.listStateController_:SetSelectedState("roleList")
		arg_44_0.roleScrollList_:StartScroll(#arg_44_0.normalIDList_)
		arg_44_0.showRoleListOpenController_:SetSelectedState("on")
	elseif arg_44_0.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.ALL then
		if arg_44_0.oldFilterType_ ~= arg_44_0.filterType_ and arg_44_0.selectTopTabIndex_ == 1 then
			arg_44_0.listAni_:Play("UI_left_xs", -1, 0)
		end

		arg_44_0.maskController_:SetSelectedState("off")
	else
		if arg_44_0.oldFilterType_ ~= arg_44_0.filterType_ then
			arg_44_0.listAni_:Play("UI_left_cx", -1, 0)
		end

		arg_44_0.listStateController_:SetSelectedState("normalList")
		arg_44_0.normalScrollList_:StartScroll(#arg_44_0.normalIDList_)
		arg_44_0.showNormalListOpenController_:SetSelectedState("on")
	end

	arg_44_0.oldFilterType_ = arg_44_0.filterType_
end

function var_0_0.RefreshSelectChapter(arg_45_0, arg_45_1)
	arg_45_0.viewSelectID_ = arg_45_1

	local var_45_0 = ChapterTools.GetCacheSelectFilterType(arg_45_0:UIName()) ~= arg_45_0.filterType_
	local var_45_1 = ChapterTools.GetCacheSelectTabIndex(arg_45_0:UIName()) ~= arg_45_0.selectTabIndex_

	if var_45_0 or var_45_1 then
		SetActive(arg_45_0.jumpBtn_.gameObject, true)
	else
		SetActive(arg_45_0.jumpBtn_.gameObject, false)
	end
end

function var_0_0.RefreshSizeStateValue(arg_46_0)
	if arg_46_0.sliderValue_ <= 1 and arg_46_0.sliderValue_ > arg_46_0.scaleConfig[0].minValue then
		arg_46_0.sizeState_ = 0
	elseif arg_46_0.sliderValue_ <= arg_46_0.scaleConfig[1].maxValue and arg_46_0.sliderValue_ > arg_46_0.scaleConfig[1].minValue then
		arg_46_0.sizeState_ = 1
	elseif arg_46_0.sliderValue_ <= arg_46_0.scaleConfig[2].maxValue and arg_46_0.sliderValue_ > arg_46_0.scaleConfig[2].minValue then
		arg_46_0.sizeState_ = 2
	elseif arg_46_0.sliderValue_ == arg_46_0.scaleConfig[2].minValue then
		arg_46_0.sizeState_ = 3
	end
end

function var_0_0.RefreshSizeState(arg_47_0)
	local var_47_0 = arg_47_0.sizeState_

	arg_47_0:RefreshSizeStateValue()

	local function var_47_1()
		if arg_47_0.filterType_ == 0 then
			arg_47_0:RefreshItemSizeState(arg_47_0.sizeState_)

			local var_48_0 = arg_47_0.scaleConfig[arg_47_0.sizeState_]

			if arg_47_0.sizeState_ == 0 then
				arg_47_0.itemScale_ = Mathf.Lerp(var_48_0.scaleRange.max, var_48_0.scaleRange.min, 1 - (arg_47_0.sliderValue_ - arg_47_0.scaleConfig[1].maxValue) / (1 - arg_47_0.scaleConfig[1].maxValue))
			elseif arg_47_0.sizeState_ == 1 then
				arg_47_0.itemScale_ = var_48_0.fixedScale
			elseif arg_47_0.sizeState_ == 2 then
				arg_47_0.itemScale_ = Mathf.Lerp(var_48_0.scaleRange.max, var_48_0.scaleRange.min, 1 - (arg_47_0.sliderValue_ - var_48_0.minValue) / (arg_47_0.scaleConfig[1].minValue - var_48_0.minValue))
			elseif arg_47_0.sizeState_ == 3 then
				arg_47_0.itemScale_ = var_48_0.fixedScale
			end

			arg_47_0:RefreshItemScale(arg_47_0.itemScale_)
		end

		arg_47_0:RefreshData()
		arg_47_0:AdjustSpacingAndRefresh(arg_47_0.sliderValue_)
		arg_47_0:RefreshItemPosition()
	end

	if arg_47_0.filterType_ == 0 then
		if arg_47_0.sizeState_ == 0 then
			if var_47_0 > 1 and arg_47_0.selectTopTabIndex_ == 1 then
				arg_47_0:PlayItemScaleAnimation(var_47_1)
			else
				var_47_1()
			end
		elseif arg_47_0.sizeState_ == 1 then
			if var_47_0 > 1 and arg_47_0.selectTopTabIndex_ == 1 then
				arg_47_0:PlayItemScaleAnimation(var_47_1)
			else
				var_47_1()
			end
		elseif arg_47_0.sizeState_ == 2 then
			if var_47_0 ~= 2 and arg_47_0.selectTopTabIndex_ == 1 then
				arg_47_0:PlayItemScaleAnimation(var_47_1)
			else
				var_47_1()
			end
		elseif arg_47_0.sizeState_ == 3 then
			if var_47_0 ~= 3 and arg_47_0.selectTopTabIndex_ == 1 then
				arg_47_0:PlayItemScaleAnimation(var_47_1)
			else
				var_47_1()
			end
		end
	else
		var_47_1()

		arg_47_0.sizeState_ = 0

		arg_47_0:RefreshItemSizeState(arg_47_0.sizeState_)

		local var_47_2 = arg_47_0.scaleConfig[0]

		arg_47_0.itemScale_ = Mathf.Lerp(1, 0.6, 1 - arg_47_0.sliderValue_)

		arg_47_0:RefreshItemScale(arg_47_0.itemScale_)
	end
end

function var_0_0.PlayItemScaleAnimation(arg_49_0, arg_49_1)
	arg_49_0.isProcessing_ = true

	local var_49_0 = GameSetting.time_line_AniTime.value and GameSetting.time_line_AniTime.value[1] or 0.15

	LeanTween.alphaCanvas(arg_49_0.viewCanvas_, 0, var_49_0):setEase(LeanTweenType.easeInCirc):setOnComplete(LuaHelper.VoidAction(function()
		if arg_49_1 then
			arg_49_1()
		end

		LeanTween.alphaCanvas(arg_49_0.viewCanvas_, 1, var_49_0):setEase(LeanTweenType.easeOutCirc)

		arg_49_0.isProcessing_ = false
	end))
end

function var_0_0.RefreshItemScale(arg_51_0, arg_51_1)
	for iter_51_0, iter_51_1 in ipairs(arg_51_0.itemList_) do
		iter_51_1:SetScale(arg_51_1)
	end
end

function var_0_0.RefreshItemSizeState(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in ipairs(arg_52_0.itemList_) do
		iter_52_1:SetSizeState(arg_52_1)
	end
end

function var_0_0.RefreshViewContent(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0.itemTrs_.rect.width * arg_53_0.itemScale_
	local var_53_1 = (arg_53_0.layoutGroup_.spacing + var_53_0) / 2
	local var_53_2 = arg_53_0.layoutGroup_.padding.left
	local var_53_3 = arg_53_0.layoutGroup_.padding.right
	local var_53_4 = 0
	local var_53_5

	for iter_53_0, iter_53_1 in ipairs(arg_53_0.chapterList_) do
		var_53_4 = var_53_4 + 1

		if arg_53_0.positionList_[iter_53_0] == nil or arg_53_1 then
			local var_53_6

			if arg_53_0.sizeState_ <= 1 then
				var_53_6 = ChapterClientCfg[iter_53_1].toggle == BattleConst.TOGGLE.PLOT
			else
				var_53_6 = ChapterClassCfg[iter_53_1].mid_type == 1
			end

			local var_53_7 = var_53_1

			if arg_53_0.sizeState_ == 2 then
				if var_53_5 ~= nil then
					if var_53_5 and var_53_6 then
						var_53_7 = var_53_1 * 3
					elseif var_53_5 or var_53_6 then
						var_53_7 = var_53_1 * 2
					else
						var_53_7 = var_53_1 * 1
					end
				end
			elseif var_53_5 ~= nil then
				if var_53_5 and var_53_6 or not var_53_5 and not var_53_6 then
					var_53_7 = var_53_1 * 2
				else
					var_53_7 = var_53_1 * 1
				end
			end

			local var_53_8 = iter_53_0 == 1 and var_53_2 or arg_53_0.positionList_[iter_53_0 - 1].x + var_53_7

			arg_53_0.positionList_[iter_53_0] = Vector3.New(var_53_8, 0, 0)
			var_53_5 = var_53_6
		end
	end

	for iter_53_2 = var_53_4 + 1, #arg_53_0.positionList_ do
		arg_53_0.positionList_[iter_53_2] = Vector3.New(-30000, 0, 0)
	end

	if #arg_53_0.chapterList_ == 1 then
		SetActive(arg_53_0.lineContent_.gameObject, false)

		return
	else
		SetActive(arg_53_0.lineContent_.gameObject, true)
	end

	local var_53_9 = arg_53_0.positionList_[var_53_4].x + var_53_0 / 2 + var_53_3 + 200

	arg_53_0.tempVector2_.x = var_53_9
	arg_53_0.tempVector2_.y = arg_53_0.itemContentTrs_.sizeDelta.y
	arg_53_0.itemContentTrs_.sizeDelta = arg_53_0.tempVector2_

	local var_53_10 = arg_53_0.lineTrs_.rect.width
	local var_53_11 = arg_53_0.lineTrs_.localPosition.y
	local var_53_12 = math.floor(var_53_9 / var_53_10) + 1

	for iter_53_3 = 1, math.max(var_53_12, arg_53_0.lineContent_.childCount) do
		local var_53_13

		if iter_53_3 > arg_53_0.lineContent_.transform.childCount then
			var_53_13 = Object.Instantiate(arg_53_0.lineGo_).transform

			var_53_13:SetParent(arg_53_0.lineContent_.transform, false)
		else
			var_53_13 = arg_53_0.lineContent_.transform:GetChild(iter_53_3 - 1)

			if iter_53_3 == 1 then
				var_53_13.localPosition = Vector3.New((iter_53_3 - 1) * var_53_10, var_53_11, 0)
			end
		end

		arg_53_0.tempVector3_.x = (iter_53_3 - 1) * var_53_10 + arg_53_0.positionList_[1].x
		arg_53_0.tempVector3_.y = var_53_11
		arg_53_0.tempVector3_.z = 0
		var_53_13.localPosition = arg_53_0.tempVector3_

		local var_53_14 = var_53_10 * iter_53_3 - arg_53_0.positionList_[#arg_53_0.chapterList_].x + arg_53_0.positionList_[1].x

		SetActive(var_53_13.gameObject, true)

		if iter_53_3 == var_53_12 or var_53_14 > 0 then
			local var_53_15 = var_53_10

			if arg_53_0.filterType_ == 0 then
				var_53_15 = var_53_10 * 2
			end

			if var_53_15 < var_53_14 or var_53_14 < 0 then
				SetActive(var_53_13.gameObject, false)
			end

			if arg_53_0.filterType_ ~= 0 then
				local var_53_16 = var_53_13:GetComponent(typeof(UnityEngine.UI.RectMask2D))

				if var_53_16 then
					var_53_16.padding = Vector4.New(0, 0, var_53_14, 0)
				end
			else
				local var_53_17 = var_53_13:GetComponent(typeof(UnityEngine.UI.RectMask2D))

				if var_53_17 then
					var_53_17.padding = Vector4.New(0, 0, 0, 0)
				end
			end
		else
			local var_53_18 = var_53_13:GetComponent(typeof(UnityEngine.UI.RectMask2D))

			if var_53_18 then
				var_53_18.padding = Vector4.New(0, 0, 0, 0)
			end
		end
	end

	arg_53_0:RefreshSlider()
end

function var_0_0.RefreshSlider(arg_54_0)
	if arg_54_0.viewportTransform_.rect.width < arg_54_0.itemContentTrs_.rect.width then
		SetActive(arg_54_0.slider_.transform.parent.gameObject, true)
		SetActive(arg_54_0.timeLineSlider_.transform.parent.gameObject, true)
	else
		SetActive(arg_54_0.slider_.transform.parent.gameObject, false)
		SetActive(arg_54_0.timeLineSlider_.transform.parent.gameObject, false)
	end
end

function var_0_0.IsDisplayItem(arg_55_0, arg_55_1)
	if arg_55_0.itemList_ == nil then
		return nil
	end

	for iter_55_0, iter_55_1 in ipairs(arg_55_0.itemList_) do
		if arg_55_1 == iter_55_1:GetID() then
			return iter_55_0
		end
	end
end

function var_0_0.RefreshItemPosition(arg_56_0)
	local var_56_0, var_56_1 = arg_56_0:CalcStartToEndIndex()
	local var_56_2 = {}
	local var_56_3 = {}

	for iter_56_0 = var_56_0, var_56_1 do
		local var_56_4 = arg_56_0.chapterList_[iter_56_0]
		local var_56_5 = arg_56_0:IsDisplayItem(var_56_4)

		if var_56_5 then
			arg_56_0.itemList_[var_56_5]:SetID(arg_56_0.chapterList_[iter_56_0])
			arg_56_0.itemList_[var_56_5]:SetLocalPosition(arg_56_0.positionList_[iter_56_0])
			table.insert(var_56_2, var_56_5)
		else
			table.insert(var_56_3, iter_56_0)
		end
	end

	for iter_56_1, iter_56_2 in ipairs(var_56_3) do
		for iter_56_3, iter_56_4 in ipairs(arg_56_0.itemList_) do
			if not table.keyof(var_56_2, iter_56_3) then
				table.insert(var_56_2, iter_56_3)
				iter_56_4:SetID(arg_56_0.chapterList_[iter_56_2])
				iter_56_4:SetLocalPosition(arg_56_0.positionList_[iter_56_2])

				break
			end
		end
	end

	for iter_56_5 = 1, #arg_56_0.itemList_ do
		if not table.keyof(var_56_2, iter_56_5) then
			arg_56_0.itemList_[iter_56_5]:Show(false)
		end
	end

	arg_56_0.lineContent_.localPosition = Vector3.New(arg_56_0.itemContentTrs_.localPosition.x, arg_56_0.lineContent_.localPosition.y, arg_56_0.itemContentTrs_.localPosition.z)

	arg_56_0:RefreshAxis()
end

function var_0_0.RefreshAxis(arg_57_0)
	local var_57_0 = ChapterTools.GetCacheSelectChapterClientID(arg_57_0:UIName())
	local var_57_1 = ChapterTools.GetCacheSelectFilterType(arg_57_0:UIName())

	if var_57_0 and var_57_0 ~= 0 and arg_57_0.filterType_ == var_57_1 then
		if arg_57_0.sizeState_ == 2 then
			for iter_57_0, iter_57_1 in ipairs(arg_57_0.chapterList_) do
				local var_57_2 = ChapterClassCfg[iter_57_1]

				if table.indexof(var_57_2.mid_chapter, var_57_0) then
					var_57_0 = iter_57_1
				end
			end
		elseif arg_57_0.sizeState_ == 3 then
			for iter_57_2, iter_57_3 in ipairs(arg_57_0.chapterList_) do
				local var_57_3 = ChapterClassCfg.get_id_list_by_big_id[iter_57_3]

				for iter_57_4, iter_57_5 in ipairs(var_57_3) do
					local var_57_4 = ChapterClassCfg[iter_57_5]

					if table.indexof(var_57_4.mid_chapter, var_57_0) then
						var_57_0 = iter_57_3
					end
				end
			end
		end

		local var_57_5 = arg_57_0.positionList_[table.indexof(arg_57_0.chapterList_, var_57_0)] and arg_57_0.positionList_[table.indexof(arg_57_0.chapterList_, var_57_0)].x

		if not var_57_5 then
			arg_57_0.tempVector3_.x = -9999
		else
			arg_57_0.tempVector3_.x = var_57_5

			if arg_57_0.sizeState_ == 0 or arg_57_0.sizeState_ == 1 then
				if ChapterClientCfg[var_57_0].toggle == BattleConst.TOGGLE.PLOT then
					arg_57_0.tempVector3_.y = -50
				else
					arg_57_0.tempVector3_.y = 50
				end
			elseif arg_57_0.sizeState_ == 2 then
				if ChapterClassCfg[var_57_0].mid_type == 1 then
					arg_57_0.tempVector3_.y = arg_57_0.itemTrs_.rect.height / 2 * arg_57_0.itemScale_
				else
					arg_57_0.tempVector3_.y = 80
				end
			elseif arg_57_0.sizeState_ == 3 then
				arg_57_0.tempVector3_.y = arg_57_0.itemTrs_.rect.height / 2 * arg_57_0.scaleConfig[2].scaleRange.min
			end

			arg_57_0.tempVector3_.z = 0
			arg_57_0.axisTrs_.localPosition = arg_57_0.tempVector3_

			local var_57_6 = arg_57_0.axisTrs_:TransformPoint(Vector3.zero)
			local var_57_7 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
			local var_57_8 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_57_7, var_57_6)

			if var_57_8.x < 0 then
				local var_57_9, var_57_10 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_57_0.itemContentTrs_, Vector2.New(50, var_57_8.y), var_57_7, nil)

				arg_57_0.tempVector3_.x = var_57_10.x
				arg_57_0.tempVector3_.y = (arg_57_0.itemTrs_.rect.height / 2 + 100) * arg_57_0.itemScale_
				arg_57_0.axisTrs_.localPosition = arg_57_0.tempVector3_

				arg_57_0.axisController_:SetSelectedState("left")
			elseif var_57_8.x > _G.SCREEN_WIDTH then
				local var_57_11, var_57_12 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_57_0.itemContentTrs_, Vector2.New(_G.SCREEN_WIDTH - 110, var_57_8.y), var_57_7, nil)

				arg_57_0.tempVector3_.x = var_57_12.x
				arg_57_0.tempVector3_.y = (arg_57_0.itemTrs_.rect.height / 2 + 100) * arg_57_0.itemScale_
				arg_57_0.axisTrs_.localPosition = arg_57_0.tempVector3_

				arg_57_0.axisController_:SetSelectedState("right")
			elseif arg_57_0.sizeState_ == 0 or arg_57_0.sizeState_ == 1 then
				if ChapterClientCfg[var_57_0].toggle == BattleConst.TOGGLE.PLOT then
					arg_57_0.axisController_:SetSelectedState("down")
				else
					arg_57_0.axisController_:SetSelectedState("middle")
				end
			else
				arg_57_0.axisController_:SetSelectedState("middle")
			end
		end
	else
		arg_57_0.tempVector3_.x = -9999
		arg_57_0.tempVector3_.y = 0
		arg_57_0.tempVector3_.z = 0
		arg_57_0.axisTrs_.localPosition = arg_57_0.tempVector3_
	end
end

function var_0_0.CalcStartToEndIndex(arg_58_0)
	local var_58_0 = arg_58_0.viewportTransform_.rect.width
	local var_58_1 = arg_58_0.itemTrs_.rect.width * arg_58_0.itemScale_ / 2
	local var_58_2 = 1
	local var_58_3 = 1
	local var_58_4 = arg_58_0.itemContentTrs_.localPosition.x

	for iter_58_0, iter_58_1 in ipairs(arg_58_0.chapterList_) do
		local var_58_5 = arg_58_0.positionList_[iter_58_0].x + var_58_4

		if iter_58_0 == 1 then
			var_58_5 = -arg_58_0.itemTrs_.rect.width * arg_58_0.itemScale_
		end

		if var_58_5 + var_58_1 < 0 then
			var_58_2 = iter_58_0
		end

		if var_58_5 + var_58_1 >= 0 and var_58_0 >= var_58_5 - var_58_1 then
			var_58_3 = iter_58_0
		end
	end

	if var_58_3 < var_58_2 then
		var_58_3 = var_58_2
	end

	return var_58_2, var_58_3
end

function var_0_0.ChangeSelectID(arg_59_0, arg_59_1)
	if not arg_59_1 then
		return
	end
end

function var_0_0.SearchNearClientID(arg_60_0)
	local var_60_0
	local var_60_1 = 200000
	local var_60_2 = arg_60_0.viewportTransform_.localPosition.x + arg_60_0.viewportTransform_.rect.width / 2

	for iter_60_0, iter_60_1 in ipairs(arg_60_0.chapterList_) do
		local var_60_3 = arg_60_0.positionList_[iter_60_0]
		local var_60_4 = math.abs(var_60_3.x + arg_60_0.itemContentTrs_.localPosition.x - arg_60_0.viewportTransform_.rect.width / 2)

		if var_60_4 <= var_60_1 then
			var_60_1 = var_60_4
			var_60_0 = iter_60_1
		end
	end

	return var_60_0
end

function var_0_0.GetItemPositionX(arg_61_0, arg_61_1)
	local var_61_0 = table.keyof(arg_61_0.chapterList_, arg_61_1)
	local var_61_1 = arg_61_0.itemContentTrs_.localPosition

	return -arg_61_0.positionList_[var_61_0].x + arg_61_0.viewportTransform_.rect.width / 2
end

function var_0_0.SetChapterToCenter(arg_62_0, arg_62_1)
	if not arg_62_1 or not arg_62_0.positionList_ or #arg_62_0.positionList_ == 0 then
		return
	end

	local var_62_0 = table.keyof(arg_62_0.chapterList_, arg_62_1)

	if not var_62_0 or not arg_62_0.positionList_[var_62_0] then
		return
	end

	local var_62_1 = -arg_62_0.positionList_[var_62_0].x + arg_62_0.viewportTransform_.rect.width / 2
	local var_62_2 = Vector3.New(var_62_1, arg_62_0.itemContentTrs_.localPosition.y, arg_62_0.itemContentTrs_.localPosition.z)

	arg_62_0.itemContentTrs_.localPosition = var_62_2

	arg_62_0.scrollRect_:StopMovement()

	arg_62_0.selectChapterClientID_ = arg_62_1

	arg_62_0:ChangeSelectID(arg_62_1)
	arg_62_0:RefreshSelectChapter(arg_62_1)
end

function var_0_0.AddSnapTimer(arg_63_0)
	arg_63_0:StopSnapTimer()

	arg_63_0.snapTimer_ = FrameTimer.New(function()
		if arg_63_0.scrollRect_.velocity.x > -100 and arg_63_0.scrollRect_.velocity.x < 100 then
			arg_63_0.scrollRect_:StopMovement()

			local var_64_0 = arg_63_0:SearchNearClientID()

			arg_63_0.selectChapterClientID_ = var_64_0

			arg_63_0:ChangeSelectID(var_64_0)

			local var_64_1 = arg_63_0:GetItemPositionX(var_64_0)

			arg_63_0:AddMoveTimer(var_64_1)
			arg_63_0:StopSnapTimer()
		end
	end, 0.5, -1)

	arg_63_0.snapTimer_:Start()
end

function var_0_0.StopSnapTimer(arg_65_0)
	if arg_65_0.snapTimer_ then
		arg_65_0.snapTimer_:Stop()

		arg_65_0.snapTimer_ = nil
	end
end

function var_0_0.AddMoveTimer(arg_66_0, arg_66_1)
	arg_66_0:StopMoveTimer()

	arg_66_0.moveTimer_ = FrameTimer.New(function()
		local var_67_0 = arg_66_0.itemContentTrs_.localPosition
		local var_67_1 = GameSetting.chapter_velocity_times.value[1] * math.pow(arg_66_0.scrollRect_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		if arg_66_0.scrollRect_.horizontalNormalizedPosition > 0.98 or arg_66_0.scrollRect_.horizontalNormalizedPosition < 0.02 then
			var_67_1 = 0
		end

		arg_66_0.tempVector3_.x = arg_66_1
		arg_66_0.tempVector3_.y = var_67_0.y
		arg_66_0.tempVector3_.z = var_67_0.z

		local var_67_2 = Vector3.Lerp(var_67_0, arg_66_0.tempVector3_, var_67_1)
		local var_67_3 = GameSetting.chapter_scroll_min_length.value[1]

		if var_67_3 <= math.abs(var_67_0.x - var_67_2.x) then
			local var_67_4 = arg_66_1 - var_67_0.x

			if var_67_3 < math.abs(var_67_4) then
				var_67_4 = var_67_3 * var_67_4 / math.abs(var_67_4)
			end

			var_67_2.x = var_67_2.x + var_67_4
		end

		arg_66_0.itemContentTrs_.localPosition = var_67_2

		if math.abs(var_67_0.x - arg_66_1) <= GameSetting.chapter_stop_min_length.value[1] then
			arg_66_0.scrollRect_:StopMovement()

			arg_66_0.itemContentTrs_.localPosition = arg_66_0.tempVector3_

			arg_66_0:StopToggleTimer()
			arg_66_0:StopMoveTimer()
			arg_66_0:StopMoveAction()
		end
	end, 0.5, -1)

	arg_66_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_68_0)
	if arg_68_0.moveTimer_ then
		arg_68_0.moveTimer_:Stop()

		arg_68_0.moveTimer_ = nil
	end
end

function var_0_0.AddToggleTimer(arg_69_0)
	arg_69_0:StopToggleTimer()

	arg_69_0.toggleTimer_ = FrameTimer.New(function()
		local var_70_0 = arg_69_0:SearchNearClientID()

		arg_69_0.selectChapterClientID_ = var_70_0

		arg_69_0:ChangeSelectID(var_70_0)
	end, 1, -1)

	arg_69_0.toggleTimer_:Start()
end

function var_0_0.StopToggleTimer(arg_71_0)
	if arg_71_0.toggleTimer_ then
		arg_71_0.toggleTimer_:Stop()

		arg_71_0.toggleTimer_ = nil
	end
end

function var_0_0.StopAllTimer(arg_72_0)
	arg_72_0:StopMoveTimer()
	arg_72_0:StopSnapTimer()
	arg_72_0:StopToggleTimer()
	arg_72_0:StopTimelineSliderTimer()
end

function var_0_0.HideLeftList(arg_73_0)
	if arg_73_0.showRoleListOpenController_:GetSelectedState() == "off" and arg_73_0.showNormalListOpenController_:GetSelectedState() == "off" then
		return
	end

	arg_73_0.listAni_:Play("UI_right_xs", -1, 0)
	arg_73_0.maskController_:SetSelectedState("off")

	if arg_73_0.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.ALL then
		arg_73_0.showRoleListOpenController_:SetSelectedState("on")
		arg_73_0.showNormalListOpenController_:SetSelectedState("on")
		arg_73_0.listStateController_:SetSelectedState("none")
	elseif arg_73_0.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.HERO then
		arg_73_0.showRoleListOpenController_:SetSelectedState("off")
	else
		arg_73_0.showNormalListOpenController_:SetSelectedState("off")
	end
end

function var_0_0.InitTimelineSliderTimer(arg_74_0)
	arg_74_0.timelineSliderTimerTick_ = 0
	arg_74_0.timelineSliderTimer_ = Timer.New(function()
		arg_74_0.timelineSliderTimerTick_ = arg_74_0.timelineSliderTimerTick_ + 1

		if arg_74_0.timelineSliderTimerTick_ >= 5 then
			SetActive(arg_74_0.timelineSliderGo_, false)
		else
			SetActive(arg_74_0.timelineSliderGo_, true)
		end
	end, 1, -1)

	arg_74_0.timelineSliderTimer_:Start()
end

function var_0_0.StopTimelineSliderTimer(arg_76_0)
	if arg_76_0.timelineSliderTimer_ then
		arg_76_0.timelineSliderTimer_:Stop()

		arg_76_0.timelineSliderTimer_ = nil
	end
end

return var_0_0
