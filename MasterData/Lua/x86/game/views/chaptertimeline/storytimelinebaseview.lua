local StoryTimelineBaseView = class("StoryTimelineBaseView", ReduxView)

function StoryTimelineBaseView:UIName()
	return "Widget/System/IllustratedHandbook/Illustrated_StoryLine/StoryLineMainUI"
end

function StoryTimelineBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function StoryTimelineBaseView:Init()
	self.tempVector2_ = Vector2.New(0, 0)
	self.tempVector3_ = Vector3.New(0, 0, 0)
	self.positionList_ = {}
	self.itemList_ = {}
	self.filterType_ = ChapterConst.TIME_LINE_FILTER_TYPE.ALL
	self.sizeState_ = 0
	self.itemClickCallBack_ = handler(self, self.ItemClickCallBack)
	self.LockClickCallBack_ = handler(self, self.LockClickCallBack)
	self.initScale_ = 0.75

	self:InitUI()

	self.scaleConfig = {
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
		self.scaleConfig = {
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

	self:RefreshItemSizeState(self.sizeState_)

	self.itemScale_ = Mathf.Lerp(self.scaleConfig[self.sizeState_].scaleRange.max, self.scaleConfig[self.sizeState_].scaleRange.min, 1 - (self.initScale_ - self.scaleConfig[1].maxValue) / (1 - self.scaleConfig[1].maxValue))
	self.isProcessing_ = false
	self.isAdjustingSpacing_ = false
	self.roleIDList_ = {}
	self.normalIDList_ = {}
	self.roleScrollList_ = LuaList.New(handler(self, self.IndexRoleItem), self.roleList_, StoryTimeLineRoleListItem)
	self.normalScrollList_ = LuaList.New(handler(self, self.IndexNormalItem), self.normalList_, StoryTimeLineNormalListItem)
	self.listStateController_ = self.controller_:GetController("listState")
	self.maskController_ = self.controller_:GetController("mask")
	self.axisController_ = self.axisControllerEx_:GetController("site")
	self.btnController_ = self.btnControllerEx_:GetController("tab")

	self:InitOpenBtn()
end

function StoryTimelineBaseView:InitUI()
	self:BindCfgUI()

	self.preLayoutSpacing = self.layoutGroup_.spacing
	self.layoutGroup_.spacing = self.preLayoutSpacing * self.initScale_

	self:AddListeners()

	for iter_4_0 = 1, math.ceil(_G.SCREEN_WIDTH / (self.itemTrs_.rect.width * 0.6)) + 2 do
		self.itemList_[iter_4_0] = StoryTimeLineItemBaseView.New(self.item_, self.itemContentTrs_)

		self.itemList_[iter_4_0]:SetClickCallBack(self.itemClickCallBack_)
		self.itemList_[iter_4_0]:SetLockClickCallBack(self.LockClickCallBack_)
	end
end

function StoryTimelineBaseView:InitOpenBtn()
	self.showRoleListOpenController_ = self.roleListControllerEx_:GetController("show")
	self.showNormalListOpenController_ = self.normalListControllEx_:GetController("show")
	self.roleListOpenItem_ = StoryTimeLineRoleListItem.New(self.roleListOpenGo_)
	self.normalListOpenItem_ = StoryTimeLineNormalListItem.New(self.normalListOpenGo_)

	self.roleListOpenItem_:SetOpenCallback(function(arg_6_0)
		self.listAni_:Play("UI_left_cx", -1, 0)
		self.listStateController_:SetSelectedState("roleList")
		self.showRoleListOpenController_:SetSelectedState("on")
	end)
	self.normalListOpenItem_:SetOpenCallback(function(arg_7_0)
		self.listAni_:Play("UI_left_cx", -1, 0)
		self.listStateController_:SetSelectedState("normalList")
		self.showNormalListOpenController_:SetSelectedState("on")
	end)
end

function StoryTimelineBaseView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function StoryTimelineBaseView:OnEnter()
	self.oldFilterType_ = self.filterType_
	self.filterType_ = ChapterTools.GetCacheSelectFilterType(self:UIName()) or 0
	self.selectTabIndex_ = ChapterTools.GetCacheSelectTabIndex(self:UIName()) or 1

	self.dropDown_:SetValueWithoutNotify(self.filterType_)
	self.btnController_:SetSelectedState(self.selectTabIndex_)
	SetActive(self.timelineSliderGo_, false)
	self:RefreshData()

	self.selectChapterClientID_ = ChapterTools.GetCacheSelectChapterClientID(self:UIName())
	self.needRePosition_ = true
	self.isEnter_ = true
	self.clickChapterID_ = self.selectChapterClientID_

	if not self.selectChapterClientID_ or self.selectChapterClientID_ == 0 then
		for iter_9_0, iter_9_1 in ipairs(self.chapterList_) do
			if ChapterTools.IsFinishPreChapter(iter_9_1) then
				self.selectChapterClientID_ = iter_9_1

				break
			end
		end
	end

	self:RefreshUI(true)
	self:InitTimelineSliderTimer()

	if not self.params_.isBack then
		self.selectTopTabIndex_ = 1
		self.slider_.value = self.initScale_

		if self.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.ALL then
			self.listStateController_:SetSelectedState("none")
		end
	end
end

function StoryTimelineBaseView:RefreshSelectItem()
	self.selectChapterClientID_ = self:SearchNearClientID()
end

function StoryTimelineBaseView:OnExit()
	manager.windowBar:HideBar()
	self:StopAllTimer()

	self.isProcessing_ = false
	self.clickChapterID_ = nil
	self.clickMidChapterID_ = nil
end

function StoryTimelineBaseView:Dispose()
	self.roleScrollList_:Dispose()
	self.normalScrollList_:Dispose()
	self.roleListOpenItem_:Dispose()
	self.normalListOpenItem_:Dispose()

	for iter_12_0, iter_12_1 in ipairs(self.itemList_) do
		iter_12_1:Dispose()
	end

	self.itemList_ = nil

	StoryTimelineBaseView.super.Dispose(self)
end

function StoryTimelineBaseView:AddListeners()
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.DragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(handler(self, self.ScrollFunc)))
	self.scrollRect_.onValueChanged:AddListener(handler(self, self.ScrollChangeFunc))
	self.timeLineSlider_.onValueChanged:AddListener(handler(self, self.TimeLineSliderChangeFunc))
	self.slider_.onValueChanged:AddListener(handler(self, self.SliderChangeFunc))
	self.dropDown_.onValueChanged:AddListener(handler(self, self.DropDownChangeFunc))
	self:AddBtnListener(self.subBtn_, nil, function()
		if self.isProcessing_ then
			return
		end

		self:HideLeftList()

		self.slider_.value = self.scaleConfig[2].maxValue
		self.clickChapterID_ = self.selectChapterClientID_
		self.needRePosition_ = true

		self.btnController_:SetSelectedState("2")
		OperationRecorder.RecordButtonTouch("story_timeline_button_chapter_class")
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		if self.isProcessing_ then
			return
		end

		self:HideLeftList()

		self.clickMidChapterID_ = self.selectChapterClientID_
		self.needRePosition_ = true
		self.slider_.value = self.scaleConfig[0].maxValue

		self.btnController_:SetSelectedState("1")
		OperationRecorder.RecordButtonTouch("story_timeline_button_chapter")
	end)
	self:AddBtnListener(self.jumpBtn_, nil, function()
		self:HideLeftList()

		self.oldFilterType_ = self.filterType_
		self.filterType_ = ChapterTools.GetCacheSelectFilterType(self:UIName())
		self.selectTabIndex_ = ChapterTools.GetCacheSelectTabIndex(self:UIName())
		self.selectChapterClientID_ = ChapterTools.GetCacheSelectChapterClientID(self:UIName())

		self.dropDown_:SetValueWithoutNotify(self.filterType_)
		self:RefreshData()
		self:RefreshUI(true)
		self:SetChapterToCenter(self.selectChapterClientID_)
		self:RefreshSelectItem()
	end)
	self:AddBtnListener(self.axisBtn_, nil, function()
		local var_17_0 = ChapterTools.GetCacheSelectChapterClientID(self:UIName())
		local var_17_1 = self.positionList_[table.indexof(self.chapterList_, var_17_0)] and self.positionList_[table.indexof(self.chapterList_, var_17_0)].x

		if var_17_1 then
			self.scrollRect_.content.anchoredPosition = Vector2.New(-var_17_1 + self.scrollRect_.transform.rect.width / 2, self.scrollRect_.content.anchoredPosition.y)
		end
	end)
end

function StoryTimelineBaseView:ItemClickCallBack(arg_18_1)
	self:HideLeftList()

	if self.sizeState_ == 0 or self.sizeState_ == 1 then
		local var_18_1 = arg_18_1
		local var_18_2, var_18_3 = ChapterTools.IsFinishPreChapter(ChapterClientCfg[arg_18_1].chapter_list[1])

		if not var_18_2 then
			ShowTips(ChapterTools.GetChapterLockText(ChapterClientCfg[arg_18_1].chapter_list[1], var_18_3))

			return
		end

		ChapterTools.SetCacheSelectFilterType(self.filterType_, self:UIName())
		ChapterTools.SetCacheSelectTabIndex(self.selectTabIndex_, self:UIName())
		ChapterTools.SetCacheSelectChapterClientID(var_18_1, self:UIName())
		ChapterTools.SetCacheSelectChapterID(ChapterClientCfg[arg_18_1].chapter_list[1], self:UIName())

		if ChapterClientCfg[arg_18_1].toggle == BattleConst.TOGGLE.PLOT then
			ChapterTools.GotoChapterSection(ChapterClientCfg[arg_18_1].chapter_list[1])
		else
			JumpTools.Jump2SubPlot(var_18_1, false, true)
		end

		OperationRecorder.RecordButtonTouch({
			button_name = "story_timeline_chapter_jump",
			group_id = var_18_1
		})
	else
		self.slider_.value = self.scaleConfig[0].maxValue
		self.clickMidChapterID_ = arg_18_1
		self.needRePosition_ = true

		self.btnController_:SetSelectedState("1")
		OperationRecorder.RecordButtonTouch({
			button_name = "story_timeline_chapter_class_jump",
			group_id = arg_18_1
		})
	end
end

function StoryTimelineBaseView:LockClickCallBack(arg_19_1)
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

	if GameSetting.show_tips_unlock_chapter_num then
		if (GameSetting.show_tips_unlock_chapter_num.value[1] or 3) <= var_19_4 then
			ShowMessageBox({
				content = GetTips("UNLOCK_PRE_CHAPTER_TIPS"),
				OkCallback = function()
					if var_19_5 and var_19_5 > 0 then
						local var_20_0 = self.positionList_[table.indexof(self.chapterList_, var_19_5)] and self.positionList_[table.indexof(self.chapterList_, var_19_5)].x

						if var_20_0 then
							self.scrollRect_.content.anchoredPosition = Vector2.New(-var_20_0 + self.scrollRect_.transform.rect.width / 2, self.scrollRect_.content.anchoredPosition.y)
						end

						self.needRePosition_ = false
						self.clickMidChapterID_ = nil
					end
				end
			})

			goto label_19_0
		end
	end

	ShowTips(GetTips(ChapterTools.GetChapterLockText(var_19_1, var_19_3)))

	::label_19_0::
end

function StoryTimelineBaseView:RestoreTrackedItemPosition()
	if self.needRePosition_ and (self.clickMidChapterID_ and self.clickMidChapterID_ ~= 0 or self.clickChapterID_ and self.clickChapterID_ ~= 0) then
		local var_21_0

		if self.clickMidChapterID_ and (self.sizeState_ == 0 or self.sizeState_ == 1) then
			var_21_0 = ChapterClassCfg[self.clickMidChapterID_].mid_chapter[1]
		elseif self.sizeState_ == 2 then
			for iter_21_0, iter_21_1 in ipairs(ChapterClassCfg.all) do
				if table.indexof(ChapterClassCfg[iter_21_1].mid_chapter, self.clickChapterID_) then
					var_21_0 = ChapterClassCfg[iter_21_1].id

					break
				end
			end
		end

		if self.isEnter_ then
			var_21_0 = self.clickChapterID_
			self.isEnter_ = nil
		end

		local var_21_2 = self.positionList_[table.indexof(self.chapterList_, var_21_0)] and self.positionList_[table.indexof(self.chapterList_, var_21_0)].x

		if var_21_2 then
			self.scrollRect_.content.anchoredPosition = Vector2.New(-var_21_2 + self.scrollRect_.transform.rect.width / 2, self.scrollRect_.content.anchoredPosition.y)
		end

		self.needRePosition_ = false
		self.clickMidChapterID_ = nil
		self.clickChapterID_ = nil
	end
end

function StoryTimelineBaseView:BeginDragFun(arg_22_1, arg_22_2)
	self:HideLeftList()
	self:StopMoveTimer()
	self:StopSnapTimer()
	self:AddToggleTimer()
end

function StoryTimelineBaseView:DragFun(arg_23_1, arg_23_2)
	if math.abs(arg_23_2.position.x - arg_23_2.pressPosition.x) > GameSetting.chapter_scroll_length_threshold.value[1] then
		self:RefreshSelectChapter(0)
	end
end

function StoryTimelineBaseView:EndDragFun(arg_24_1, arg_24_2)
	manager.audio:PlayUIAudioByVoice("stage_slide")
	self:AddSnapTimer()
end

function StoryTimelineBaseView:ScrollChangeFunc()
	self.timeLineSlider_.value = self.scrollRect_.horizontalNormalizedPosition

	if self.isProcessing_ then
		return
	end

	self:RefreshItemPosition()
end

function StoryTimelineBaseView:SliderChangeFunc(arg_26_1)
	self.sliderValue_ = arg_26_1

	self.scrollRect_:StopMovement()
	FrameTimer.New(function()
		if not self.isAdjustingSpacing_ then
			self.isAdjustingSpacing_ = true

			self:RefreshSizeState()

			self.isAdjustingSpacing_ = false
		end
	end, 1):Start()
end

function StoryTimelineBaseView:AdjustSpacingAndRefresh(arg_28_1)
	self.layoutGroup_.spacing = self.preLayoutSpacing * arg_28_1

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.itemContentTrs_)
	self:RefreshViewContent(true)
	FrameTimer.New(function()
		self:RestoreTrackedItemPosition()
	end, 1):Start()
end

function StoryTimelineBaseView:TimeLineSliderChangeFunc(arg_30_1)
	if self.scrollRect_.horizontalNormalizedPosition ~= arg_30_1 then
		self.scrollRect_.horizontalNormalizedPosition = arg_30_1
	end

	self:StopMoveTimer()

	local var_30_0 = self:SearchNearClientID()

	self.timelineSliderTimerTick_ = 0
	self.selectChapterClientID_ = var_30_0

	self:ChangeSelectID(var_30_0)
	self:RefreshSelectChapter(0)
end

function StoryTimelineBaseView:ScrollFunc(arg_31_1, arg_31_2)
	self:StopMoveTimer()

	local var_31_0 = self:SearchNearClientID()

	self.timelineSliderTimerTick_ = 0
	self.selectChapterClientID_ = var_31_0

	self:ChangeSelectID(var_31_0)
	self:RefreshSelectChapter(0)
	self:AddSnapTimer()
end

function StoryTimelineBaseView:DropDownChangeFunc(arg_32_1)
	self.oldFilterType_ = self.filterType_
	self.filterType_ = arg_32_1
	self.selectTabIndex_ = 1

	if self.filterType_ ~= 0 then
		if self.oldFilterType_ == 0 then
			self.cacheAllFilterSliderSize_ = self.slider_.value
		end

		self.slider_.value = 0.5
	else
		self.slider_.value = self.cacheAllFilterSliderSize_
	end

	self:RefreshData()
	self:RefreshUI(true)
	self:RefreshSelectItem()
end

function StoryTimelineBaseView:StopMoveAction()
	self:RefreshSelectChapter(self.selectChapterClientID_)
end

function StoryTimelineBaseView:RemoveListeners()
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)
end

function StoryTimelineBaseView:RefreshData()
	self.chapterList_ = {}

	if self.filterType_ == 0 then
		if self.sizeState_ == 0 or self.sizeState_ == 1 then
			self.chapterList_ = ChapterTools.GetNormalPlotAndSubPlotChapterList()
		elseif self.sizeState_ == 2 then
			self.chapterList_ = ChapterTools.GetChapterClassIDList()
		elseif self.sizeState_ == 3 then
			self.chapterList_ = ChapterTools.GetBigChapterClassIDList()
		end
	elseif self.filterType_ ~= 0 then
		self.chapterList_ = ChapterClassSiftCfg[ChapterClassSiftCfg.get_id_list_by_sift_id[self.filterType_][self.selectTabIndex_]].class_chapter
		self.normalIDList_ = ChapterClassSiftCfg.get_id_list_by_sift_id[self.filterType_]
	end
end

function StoryTimelineBaseView:IndexRoleItem(arg_36_1, arg_36_2)
	arg_36_2:SetData(arg_36_1, self.normalIDList_[arg_36_1])
	arg_36_2:SetClickCallBack(function(arg_37_0)
		self:SelectLeftItem(arg_37_0)
		self.roleListOpenItem_:SetData(arg_37_0, self.normalIDList_[arg_37_0])
	end)

	for iter_36_0, iter_36_1 in ipairs(self.normalScrollList_:GetItemList()) do
		iter_36_1:SetSelected(self.selectTabIndex_)
	end
end

function StoryTimelineBaseView:IndexNormalItem(arg_38_1, arg_38_2)
	arg_38_2:SetData(arg_38_1, self.normalIDList_[arg_38_1])
	arg_38_2:SetClickCallBack(function(arg_39_0)
		self:SelectLeftItem(arg_39_0)
		self.normalListOpenItem_:SetData(arg_39_0, self.normalIDList_[arg_39_0])
	end)

	for iter_38_0, iter_38_1 in ipairs(self.normalScrollList_:GetItemList()) do
		iter_38_1:SetSelected(self.selectTabIndex_)
	end
end

function StoryTimelineBaseView:SelectLeftItem(arg_40_1)
	if arg_40_1 == self.selectTabIndex_ then
		return
	end

	self.selectTabIndex_ = arg_40_1

	self:RefreshSizeStateValue()
	self:RefreshData()
	self:RefreshViewContent(true)
	self:RefreshSelectChapter(self.selectChapterClientID_)
	FrameTimer.New(function()
		self:RefreshItemPosition()
		self:RefreshSelectItem()

		for iter_41_0, iter_41_1 in ipairs(self.normalScrollList_:GetItemList()) do
			iter_41_1:SetSelected(arg_40_1)
		end

		self:RestoreTrackedItemPosition()
	end, 1):Start()
end

function StoryTimelineBaseView:RefreshUI(arg_42_1)
	self:RefreshViewContent(arg_42_1)
	self:RefreshSelectChapter(self.selectChapterClientID_)
	self:RefreshListState()
	FrameTimer.New(function()
		self:RefreshItemPosition()
		self:RestoreTrackedItemPosition()
	end, 1):Start()
end

function StoryTimelineBaseView:RefreshListState()
	if self.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.HERO then
		if self.oldFilterType_ ~= self.filterType_ then
			self.listAni_:Play("UI_left_cx", -1, 0)
		end

		self.listStateController_:SetSelectedState("roleList")
		self.roleScrollList_:StartScroll(#self.normalIDList_)
		self.showRoleListOpenController_:SetSelectedState("on")
	elseif self.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.ALL then
		if self.oldFilterType_ ~= self.filterType_ and self.selectTopTabIndex_ == 1 then
			self.listAni_:Play("UI_left_xs", -1, 0)
		end

		self.maskController_:SetSelectedState("off")
	else
		if self.oldFilterType_ ~= self.filterType_ then
			self.listAni_:Play("UI_left_cx", -1, 0)
		end

		self.listStateController_:SetSelectedState("normalList")
		self.normalScrollList_:StartScroll(#self.normalIDList_)
		self.showNormalListOpenController_:SetSelectedState("on")
	end

	self.oldFilterType_ = self.filterType_
end

function StoryTimelineBaseView:RefreshSelectChapter(arg_45_1)
	self.viewSelectID_ = arg_45_1

	if ChapterTools.GetCacheSelectFilterType(self:UIName()) ~= self.filterType_ or ChapterTools.GetCacheSelectTabIndex(self:UIName()) ~= self.selectTabIndex_ then
		SetActive(self.jumpBtn_.gameObject, true)
	else
		SetActive(self.jumpBtn_.gameObject, false)
	end
end

function StoryTimelineBaseView:RefreshSizeStateValue()
	if self.sliderValue_ <= 1 and self.sliderValue_ > self.scaleConfig[0].minValue then
		self.sizeState_ = 0
	elseif self.sliderValue_ <= self.scaleConfig[1].maxValue and self.sliderValue_ > self.scaleConfig[1].minValue then
		self.sizeState_ = 1
	elseif self.sliderValue_ <= self.scaleConfig[2].maxValue and self.sliderValue_ > self.scaleConfig[2].minValue then
		self.sizeState_ = 2
	elseif self.sliderValue_ == self.scaleConfig[2].minValue then
		self.sizeState_ = 3
	end
end

function StoryTimelineBaseView:RefreshSizeState()
	self:RefreshSizeStateValue()

	local function var_47_0()
		if self.filterType_ == 0 then
			self:RefreshItemSizeState(self.sizeState_)

			if self.sizeState_ == 0 then
				self.itemScale_ = Mathf.Lerp(self.scaleConfig[self.sizeState_].scaleRange.max, self.scaleConfig[self.sizeState_].scaleRange.min, 1 - (self.sliderValue_ - self.scaleConfig[1].maxValue) / (1 - self.scaleConfig[1].maxValue))
			elseif self.sizeState_ == 1 then
				self.itemScale_ = self.scaleConfig[self.sizeState_].fixedScale
			elseif self.sizeState_ == 2 then
				self.itemScale_ = Mathf.Lerp(self.scaleConfig[self.sizeState_].scaleRange.max, self.scaleConfig[self.sizeState_].scaleRange.min, 1 - (self.sliderValue_ - self.scaleConfig[self.sizeState_].minValue) / (self.scaleConfig[1].minValue - self.scaleConfig[self.sizeState_].minValue))
			elseif self.sizeState_ == 3 then
				self.itemScale_ = self.scaleConfig[self.sizeState_].fixedScale
			end

			self:RefreshItemScale(self.itemScale_)
		end

		self:RefreshData()
		self:AdjustSpacingAndRefresh(self.sliderValue_)
		self:RefreshItemPosition()
	end

	if self.filterType_ == 0 then
		if self.sizeState_ == 0 then
			if self.sizeState_ > 1 and self.selectTopTabIndex_ == 1 then
				self:PlayItemScaleAnimation(var_47_0)
			else
				var_47_0()
			end
		elseif self.sizeState_ == 1 then
			if self.sizeState_ > 1 and self.selectTopTabIndex_ == 1 then
				self:PlayItemScaleAnimation(var_47_0)
			else
				var_47_0()
			end
		elseif self.sizeState_ == 2 then
			if self.sizeState_ ~= 2 and self.selectTopTabIndex_ == 1 then
				self:PlayItemScaleAnimation(var_47_0)
			else
				var_47_0()
			end
		elseif self.sizeState_ == 3 then
			if self.sizeState_ ~= 3 and self.selectTopTabIndex_ == 1 then
				self:PlayItemScaleAnimation(var_47_0)
			else
				var_47_0()
			end
		end
	else
		var_47_0()

		self.sizeState_ = 0

		self:RefreshItemSizeState(self.sizeState_)

		self.itemScale_ = Mathf.Lerp(1, 0.6, 1 - self.sliderValue_)

		self:RefreshItemScale(self.itemScale_)
	end
end

function StoryTimelineBaseView:PlayItemScaleAnimation(arg_49_1)
	self.isProcessing_ = true

	local var_49_0

	if GameSetting.time_line_AniTime.value then
		var_49_0 = GameSetting.time_line_AniTime.value[1] or 0.15
	end

	LeanTween.alphaCanvas(self.viewCanvas_, 0, var_49_0):setEase(LeanTweenType.easeInCirc):setOnComplete(LuaHelper.VoidAction(function()
		if arg_49_1 then
			arg_49_1()
		end

		LeanTween.alphaCanvas(self.viewCanvas_, 1, var_49_0):setEase(LeanTweenType.easeOutCirc)

		self.isProcessing_ = false
	end))
end

function StoryTimelineBaseView:RefreshItemScale(arg_51_1)
	for iter_51_0, iter_51_1 in ipairs(self.itemList_) do
		iter_51_1:SetScale(arg_51_1)
	end
end

function StoryTimelineBaseView:RefreshItemSizeState(arg_52_1)
	for iter_52_0, iter_52_1 in ipairs(self.itemList_) do
		iter_52_1:SetSizeState(arg_52_1)
	end
end

function StoryTimelineBaseView:RefreshViewContent(arg_53_1)
	local var_53_0 = (self.layoutGroup_.spacing + self.itemTrs_.rect.width * self.itemScale_) / 2
	local var_53_1 = self.layoutGroup_.padding.left
	local var_53_2 = 0
	local var_53_3

	for iter_53_0, iter_53_1 in ipairs(self.chapterList_) do
		var_53_2 = var_53_2 + 1

		if self.positionList_[iter_53_0] == nil or arg_53_1 then
			local var_53_4 = self.sizeState_ <= 1 and ChapterClientCfg[iter_53_1].toggle == BattleConst.TOGGLE.PLOT or ChapterClassCfg[iter_53_1].mid_type == 1
			local var_53_5 = var_53_0

			if self.sizeState_ == 2 then
				if var_53_3 ~= nil then
					var_53_5 = var_53_3 and var_53_4 and var_53_0 * 3 or (var_53_3 or var_53_4) and var_53_0 * 2 or var_53_0 * 1
				end
			elseif var_53_3 ~= nil then
				if var_53_3 and var_53_4 or not var_53_3 and not var_53_4 then
					var_53_5 = var_53_0 * 2
				end

				local var_53_6

				do
					var_53_5 = var_53_0 * 1
					var_53_6 = self.positionList_
				end
			end

			var_53_6[iter_53_0] = Vector3.New(iter_53_0 == 1 and var_53_1 or self.positionList_[iter_53_0 - 1].x + var_53_5, 0, 0)
			var_53_3 = var_53_4
		end
	end

	for iter_53_2 = var_53_2 + 1, #self.positionList_ do
		self.positionList_[iter_53_2] = Vector3.New(-30000, 0, 0)
	end

	if #self.chapterList_ == 1 then
		SetActive(self.lineContent_.gameObject, false)

		return
	else
		SetActive(self.lineContent_.gameObject, true)
	end

	self.tempVector2_.x = self.positionList_[var_53_2].x + self.itemTrs_.rect.width * self.itemScale_ / 2 + self.layoutGroup_.padding.right + 200
	self.tempVector2_.y = self.itemContentTrs_.sizeDelta.y
	self.itemContentTrs_.sizeDelta = self.tempVector2_

	local var_53_7 = self.lineTrs_.rect.width
	local var_53_8 = self.lineTrs_.localPosition.y
	local var_53_9 = math.floor((self.positionList_[var_53_2].x + self.itemTrs_.rect.width * self.itemScale_ / 2 + self.layoutGroup_.padding.right + 200) / self.lineTrs_.rect.width) + 1

	for iter_53_3 = 1, math.max(var_53_9, self.lineContent_.childCount) do
		local var_53_10

		if iter_53_3 > self.lineContent_.transform.childCount then
			var_53_10 = Object.Instantiate(self.lineGo_).transform

			var_53_10:SetParent(self.lineContent_.transform, false)
		else
			var_53_10 = self.lineContent_.transform:GetChild(iter_53_3 - 1)

			if iter_53_3 == 1 then
				var_53_10.localPosition = Vector3.New((iter_53_3 - 1) * var_53_7, var_53_8, 0)
			end
		end

		self.tempVector3_.x = (iter_53_3 - 1) * var_53_7 + self.positionList_[1].x
		self.tempVector3_.y = var_53_8
		self.tempVector3_.z = 0
		var_53_10.localPosition = self.tempVector3_

		local var_53_11 = var_53_7 * iter_53_3 - self.positionList_[#self.chapterList_].x + self.positionList_[1].x

		SetActive(var_53_10.gameObject, true)

		if iter_53_3 == var_53_9 or var_53_11 > 0 then
			if ((self.filterType_ == 0 or nil) and var_53_7 * 2) < var_53_11 or var_53_11 < 0 then
				SetActive(var_53_10.gameObject, false)
			end

			if self.filterType_ ~= 0 then
				local var_53_13 = var_53_10:GetComponent(typeof(UnityEngine.UI.RectMask2D))

				if var_53_13 then
					var_53_13.padding = Vector4.New(0, 0, var_53_11, 0)
				end
			else
				local var_53_14 = var_53_10:GetComponent(typeof(UnityEngine.UI.RectMask2D))

				if var_53_14 then
					var_53_14.padding = Vector4.New(0, 0, 0, 0)
				end
			end
		else
			local var_53_15 = var_53_10:GetComponent(typeof(UnityEngine.UI.RectMask2D))

			if var_53_15 then
				var_53_15.padding = Vector4.New(0, 0, 0, 0)
			end
		end
	end

	self:RefreshSlider()
end

function StoryTimelineBaseView:RefreshSlider()
	if self.viewportTransform_.rect.width < self.itemContentTrs_.rect.width then
		SetActive(self.slider_.transform.parent.gameObject, true)
		SetActive(self.timeLineSlider_.transform.parent.gameObject, true)
	else
		SetActive(self.slider_.transform.parent.gameObject, false)
		SetActive(self.timeLineSlider_.transform.parent.gameObject, false)
	end
end

function StoryTimelineBaseView:IsDisplayItem(arg_55_1)
	if self.itemList_ == nil then
		return nil
	end

	for iter_55_0, iter_55_1 in ipairs(self.itemList_) do
		if arg_55_1 == iter_55_1:GetID() then
			return iter_55_0
		end
	end
end

function StoryTimelineBaseView:RefreshItemPosition()
	local var_56_0, var_56_1 = self:CalcStartToEndIndex()
	local var_56_2 = {}
	local var_56_3 = {}

	for iter_56_0 = var_56_0, var_56_1 do
		local var_56_4 = self:IsDisplayItem(self.chapterList_[iter_56_0])

		if var_56_4 then
			self.itemList_[var_56_4]:SetID(self.chapterList_[iter_56_0])
			self.itemList_[var_56_4]:SetLocalPosition(self.positionList_[iter_56_0])
			table.insert(var_56_2, var_56_4)
		else
			table.insert(var_56_3, iter_56_0)
		end
	end

	for iter_56_1, iter_56_2 in ipairs(var_56_3) do
		for iter_56_3, iter_56_4 in ipairs(self.itemList_) do
			if not table.keyof(var_56_2, iter_56_3) then
				table.insert(var_56_2, iter_56_3)
				iter_56_4:SetID(self.chapterList_[iter_56_2])
				iter_56_4:SetLocalPosition(self.positionList_[iter_56_2])

				break
			end
		end
	end

	for iter_56_5 = 1, #self.itemList_ do
		if not table.keyof(var_56_2, iter_56_5) then
			self.itemList_[iter_56_5]:Show(false)
		end
	end

	self.lineContent_.localPosition = Vector3.New(self.itemContentTrs_.localPosition.x, self.lineContent_.localPosition.y, self.itemContentTrs_.localPosition.z)

	self:RefreshAxis()
end

function StoryTimelineBaseView:RefreshAxis()
	local var_57_0 = ChapterTools.GetCacheSelectChapterClientID(self:UIName())

	if var_57_0 and var_57_0 ~= 0 and self.filterType_ == ChapterTools.GetCacheSelectFilterType(self:UIName()) then
		if self.sizeState_ == 2 then
			for iter_57_0, iter_57_1 in ipairs(self.chapterList_) do
				if table.indexof(ChapterClassCfg[iter_57_1].mid_chapter, var_57_0) then
					var_57_0 = iter_57_1
				end
			end
		elseif self.sizeState_ == 3 then
			for iter_57_2, iter_57_3 in ipairs(self.chapterList_) do
				for iter_57_4, iter_57_5 in ipairs(ChapterClassCfg.get_id_list_by_big_id[iter_57_3]) do
					if table.indexof(ChapterClassCfg[iter_57_5].mid_chapter, var_57_0) then
						var_57_0 = iter_57_3
					end
				end
			end
		end

		local var_57_1 = self.positionList_[table.indexof(self.chapterList_, var_57_0)] and self.positionList_[table.indexof(self.chapterList_, var_57_0)].x

		if not var_57_1 then
			self.tempVector3_.x = -9999
		else
			self.tempVector3_.x = var_57_1

			if self.sizeState_ == 0 or self.sizeState_ == 1 then
				self.tempVector3_.y = ChapterClientCfg[var_57_0].toggle == BattleConst.TOGGLE.PLOT and -50 or 50
			elseif self.sizeState_ == 2 then
				self.tempVector3_.y = ChapterClassCfg[var_57_0].mid_type == 1 and self.itemTrs_.rect.height / 2 * self.itemScale_ or 80
			elseif self.sizeState_ == 3 then
				self.tempVector3_.y = self.itemTrs_.rect.height / 2 * self.scaleConfig[2].scaleRange.min
			end

			self.tempVector3_.z = 0
			self.axisTrs_.localPosition = self.tempVector3_

			local var_57_2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
			local var_57_3 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_57_2, (self.axisTrs_:TransformPoint(Vector3.zero)))

			if var_57_3.x < 0 then
				local var_57_4, var_57_5 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.itemContentTrs_, Vector2.New(50, var_57_3.y), var_57_2, nil)

				self.tempVector3_.x = var_57_5.x
				self.tempVector3_.y = (self.itemTrs_.rect.height / 2 + 100) * self.itemScale_
				self.axisTrs_.localPosition = self.tempVector3_

				self.axisController_:SetSelectedState("left")
			elseif var_57_3.x > _G.SCREEN_WIDTH then
				local var_57_6, var_57_7 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.itemContentTrs_, Vector2.New(_G.SCREEN_WIDTH - 110, var_57_3.y), var_57_2, nil)

				self.tempVector3_.x = var_57_7.x
				self.tempVector3_.y = (self.itemTrs_.rect.height / 2 + 100) * self.itemScale_
				self.axisTrs_.localPosition = self.tempVector3_

				self.axisController_:SetSelectedState("right")
			elseif self.sizeState_ == 0 or self.sizeState_ == 1 then
				if ChapterClientCfg[var_57_0].toggle == BattleConst.TOGGLE.PLOT then
					self.axisController_:SetSelectedState("down")
				else
					self.axisController_:SetSelectedState("middle")
				end
			else
				self.axisController_:SetSelectedState("middle")
			end
		end
	else
		self.tempVector3_.x = -9999
		self.tempVector3_.y = 0
		self.tempVector3_.z = 0
		self.axisTrs_.localPosition = self.tempVector3_
	end
end

function StoryTimelineBaseView:CalcStartToEndIndex()
	local var_58_0 = 1
	local var_58_1 = 1

	for iter_58_0, iter_58_1 in ipairs(self.chapterList_) do
		local var_58_2 = self.positionList_[iter_58_0].x + self.itemContentTrs_.localPosition.x

		if iter_58_0 == 1 then
			var_58_2 = -self.itemTrs_.rect.width * self.itemScale_
		end

		if var_58_2 + self.itemTrs_.rect.width * self.itemScale_ / 2 < 0 then
			var_58_0 = iter_58_0
		end

		if var_58_2 + self.itemTrs_.rect.width * self.itemScale_ / 2 >= 0 and self.viewportTransform_.rect.width >= var_58_2 - self.itemTrs_.rect.width * self.itemScale_ / 2 then
			var_58_1 = iter_58_0
		end
	end

	if var_58_1 < var_58_0 then
		var_58_1 = var_58_0
	end

	return var_58_0, var_58_1
end

function StoryTimelineBaseView:ChangeSelectID(arg_59_1)
	if not arg_59_1 then
		return
	end
end

function StoryTimelineBaseView:SearchNearClientID()
	local var_60_0

	for iter_60_0, iter_60_1 in ipairs(self.chapterList_) do
		if math.abs(self.positionList_[iter_60_0].x + self.itemContentTrs_.localPosition.x - self.viewportTransform_.rect.width / 2) <= 200000 then
			var_60_0 = iter_60_1
		end
	end

	return var_60_0
end

function StoryTimelineBaseView:GetItemPositionX(arg_61_1)
	return -self.positionList_[table.keyof(self.chapterList_, arg_61_1)].x + self.viewportTransform_.rect.width / 2
end

function StoryTimelineBaseView:SetChapterToCenter(arg_62_1)
	if not arg_62_1 or not self.positionList_ or #self.positionList_ == 0 then
		return
	end

	local var_62_0 = table.keyof(self.chapterList_, arg_62_1)

	if not var_62_0 or not self.positionList_[var_62_0] then
		return
	end

	self.itemContentTrs_.localPosition = Vector3.New(-self.positionList_[var_62_0].x + self.viewportTransform_.rect.width / 2, self.itemContentTrs_.localPosition.y, self.itemContentTrs_.localPosition.z)

	self.scrollRect_:StopMovement()

	self.selectChapterClientID_ = arg_62_1

	self:ChangeSelectID(arg_62_1)
	self:RefreshSelectChapter(arg_62_1)
end

function StoryTimelineBaseView:AddSnapTimer()
	self:StopSnapTimer()

	self.snapTimer_ = FrameTimer.New(function()
		if self.scrollRect_.velocity.x > -100 and self.scrollRect_.velocity.x < 100 then
			self.scrollRect_:StopMovement()

			local var_64_0 = self:SearchNearClientID()

			self.selectChapterClientID_ = var_64_0

			self:ChangeSelectID(var_64_0)
			self:AddMoveTimer((self:GetItemPositionX(var_64_0)))
			self:StopSnapTimer()
		end
	end, 0.5, -1)

	self.snapTimer_:Start()
end

function StoryTimelineBaseView:StopSnapTimer()
	if self.snapTimer_ then
		self.snapTimer_:Stop()

		self.snapTimer_ = nil
	end
end

function StoryTimelineBaseView:AddMoveTimer(arg_66_1)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		local var_67_0 = self.itemContentTrs_.localPosition
		local var_67_1 = GameSetting.chapter_velocity_times.value[1] * math.pow(self.scrollRect_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		if self.scrollRect_.horizontalNormalizedPosition > 0.98 or self.scrollRect_.horizontalNormalizedPosition < 0.02 then
			var_67_1 = 0
		end

		self.tempVector3_.x = arg_66_1
		self.tempVector3_.y = var_67_0.y
		self.tempVector3_.z = var_67_0.z

		local var_67_2 = Vector3.Lerp(var_67_0, self.tempVector3_, var_67_1)

		if GameSetting.chapter_scroll_min_length.value[1] <= math.abs(var_67_0.x - var_67_2.x) then
			local var_67_3 = arg_66_1 - var_67_0.x

			if GameSetting.chapter_scroll_min_length.value[1] < math.abs(arg_66_1 - var_67_0.x) then
				var_67_3 = GameSetting.chapter_scroll_min_length.value[1] * var_67_3 / math.abs(var_67_3)
			end

			var_67_2.x = var_67_2.x + var_67_3
		end

		self.itemContentTrs_.localPosition = var_67_2

		if math.abs(var_67_0.x - arg_66_1) <= GameSetting.chapter_stop_min_length.value[1] then
			self.scrollRect_:StopMovement()

			self.itemContentTrs_.localPosition = self.tempVector3_

			self:StopToggleTimer()
			self:StopMoveTimer()
			self:StopMoveAction()
		end
	end, 0.5, -1)

	self.moveTimer_:Start()
end

function StoryTimelineBaseView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function StoryTimelineBaseView:AddToggleTimer()
	self:StopToggleTimer()

	self.toggleTimer_ = FrameTimer.New(function()
		local var_70_0 = self:SearchNearClientID()

		self.selectChapterClientID_ = var_70_0

		self:ChangeSelectID(var_70_0)
	end, 1, -1)

	self.toggleTimer_:Start()
end

function StoryTimelineBaseView:StopToggleTimer()
	if self.toggleTimer_ then
		self.toggleTimer_:Stop()

		self.toggleTimer_ = nil
	end
end

function StoryTimelineBaseView:StopAllTimer()
	self:StopMoveTimer()
	self:StopSnapTimer()
	self:StopToggleTimer()
	self:StopTimelineSliderTimer()
end

function StoryTimelineBaseView:HideLeftList()
	if self.showRoleListOpenController_:GetSelectedState() == "off" and self.showNormalListOpenController_:GetSelectedState() == "off" then
		return
	end

	self.listAni_:Play("UI_right_xs", -1, 0)
	self.maskController_:SetSelectedState("off")

	if self.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.ALL then
		self.showRoleListOpenController_:SetSelectedState("on")
		self.showNormalListOpenController_:SetSelectedState("on")
		self.listStateController_:SetSelectedState("none")
	elseif self.filterType_ == ChapterConst.TIME_LINE_FILTER_TYPE.HERO then
		self.showRoleListOpenController_:SetSelectedState("off")
	else
		self.showNormalListOpenController_:SetSelectedState("off")
	end
end

function StoryTimelineBaseView:InitTimelineSliderTimer()
	self.timelineSliderTimerTick_ = 0
	self.timelineSliderTimer_ = Timer.New(function()
		self.timelineSliderTimerTick_ = self.timelineSliderTimerTick_ + 1

		if self.timelineSliderTimerTick_ >= 5 then
			SetActive(self.timelineSliderGo_, false)
		else
			SetActive(self.timelineSliderGo_, true)
		end
	end, 1, -1)

	self.timelineSliderTimer_:Start()
end

function StoryTimelineBaseView:StopTimelineSliderTimer()
	if self.timelineSliderTimer_ then
		self.timelineSliderTimer_:Stop()

		self.timelineSliderTimer_ = nil
	end
end

return StoryTimelineBaseView
