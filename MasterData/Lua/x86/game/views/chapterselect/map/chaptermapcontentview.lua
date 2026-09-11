local ChapterMapContentView = class("ChapterMapContentView", ReduxView)

ChapterMapContentView.SWITCH_STAGE_TIME = 0.8

function ChapterMapContentView:UIName()
	return "Widget/System/Operation/OperationMainUI_new"
end

function ChapterMapContentView:UIParent()
	return manager.ui.uiMain.transform
end

function ChapterMapContentView:Init()
	self.itemList_ = {}
	self.positionList_ = {}
	self.chapterList_ = {}
	self.mainPlotChapterToggleList_ = {}
	self.tempVector3_ = Vector3.New(0, 0, 0)
	self.tempVector2_ = Vector2.New(0, 0)

	self:InitUI()
	self:AddListeners()

	self.changeSelectChapterHandler_ = handler(self, self.ChangeSelectChapterID)
	self.changeSelectHardLevelHandler_ = handler(self, self.ChangeSelectHardLevel)

	for iter_3_0 = 1, 4 do
		self.itemList_[iter_3_0] = ChapterMapItemView.New(self.mapItem_, self.itemParent_)
	end
end

function ChapterMapContentView:InitUI()
	self:BindCfgUI()

	self.chapterBehindImage_.immediate = true
	self.chapterFrontImage_.immediate = true
	self.viewportTransform_ = self.mapViewPort_.transform
	self.hardLevelView_ = HardLevelChapterView.New(self.difficultPanel_)
end

function ChapterMapContentView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
end

function ChapterMapContentView:OnEnter()
	self.hardLevelView_:OnEnter()
	self:RefreshData()
	self:RefreshUI()
	self:CheckChapterSurvey()
	self:CheckStoryLineRedPoint()
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, self.changeSelectChapterHandler_)
	manager.notify:RegistListener(CHANGE_PLOT_HARD_LEVEL, self.changeSelectHardLevelHandler_)
end

function ChapterMapContentView:CheckStoryLineRedPoint()
	if getData("CHAPTERVIEW", "STORYLINE_REDPNT") then
		manager.redPoint:SetRedPointIndependent(self.chapterTimeLineBtn_.transform, false)
	else
		manager.redPoint:SetRedPointIndependent(self.chapterTimeLineBtn_.transform, true, nil, RedPointStyle.SHOW_NEW_TAG)
	end
end

function ChapterMapContentView:CheckChapterSurvey()
	if not getData("CHAPTERVIEW", "POPED_SURVEY_" .. self.selectChapterClientID_) and SurveyData:GetChapterSurveyUrl(self.selectChapterClientID_) and ChapterTools.IsClearChapterClient(self.selectChapterClientID_) then
		saveData("CHAPTERVIEW", "POPED_SURVEY_" .. self.selectChapterClientID_, true)
		JumpTools.OpenPageByJump("chapterSurveyPop", {
			chapterID = self.selectChapterClientID_
		})
	end
end

function ChapterMapContentView:OnExit()
	manager.windowBar:HideBar()
	self:StopAllTimer()
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, self.changeSelectChapterHandler_)
	manager.notify:RemoveListener(CHANGE_PLOT_HARD_LEVEL, self.changeSelectHardLevelHandler_)
	self.hardLevelView_:OnExit()

	self.viewSelectID_ = nil

	for iter_9_0, iter_9_1 in pairs(self.mainPlotChapterToggleList_) do
		iter_9_1:OnExit()
	end

	for iter_9_2, iter_9_3 in pairs(self.itemList_) do
		iter_9_3:OnExit()
	end

	self.isFirstEnter_ = false

	self:StopLeanTween()
end

function ChapterMapContentView:Dispose()
	self.changeSelectChapterHandler_ = nil
	self.changeSelectHardLevelHandler_ = nil

	self.scrollRect_.onValueChanged:RemoveAllListeners()
	self.hardLevelView_:Dispose()

	self.hardLevelView_ = nil

	for iter_10_0, iter_10_1 in pairs(self.mainPlotChapterToggleList_) do
		iter_10_1:Dispose()
	end

	self.mainPlotChapterToggleList_ = nil

	self:RemoveListeners()

	for iter_10_2, iter_10_3 in ipairs(self.itemList_) do
		iter_10_3:Dispose()
	end

	self.itemList_ = {}

	ChapterMapContentView.super.Dispose(self)
end

function ChapterMapContentView:AddListeners()
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.DragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(handler(self, self.ScrollFunc)))
	self.scrollRect_.onValueChanged:AddListener(function()
		self:RefreshItemPosition()
	end)
	self:AddBtnListener(self.chapterTimeLineBtn_, nil, function()
		gameContext:Go("/chapterTimeline")
		saveData("CHAPTERVIEW", "STORYLINE_REDPNT", true)
		OperationRecorder.RecordButtonTouch("story_timeline_entrance_1")
	end)
end

function ChapterMapContentView:BeginDragFun(arg_14_1, arg_14_2)
	self:StopMoveTimer()
	self:StopSnapTimer()
	self:AddToggleTimer()
end

function ChapterMapContentView:DragFun(arg_15_1, arg_15_2)
	if math.abs(arg_15_2.position.x - arg_15_2.pressPosition.x) > GameSetting.chapter_scroll_length_threshold.value[1] then
		self:RefreshSelectChapter(0)
	end
end

function ChapterMapContentView:EndDragFun(arg_16_1, arg_16_2)
	manager.audio:PlayUIAudioByVoice("stage_slide")
	self:AddSnapTimer()
end

function ChapterMapContentView:ScrollFunc(arg_17_1, arg_17_2)
	self:StopMoveTimer()

	local var_17_0 = self:SearchNearClientID()

	self.selectChapterClientID_ = var_17_0

	self:ChangeSelectID(var_17_0)
	self:RefreshSelectChapter(0)
	self:AddSnapTimer()
end

function ChapterMapContentView:StopMoveAction()
	self:RefreshSelectChapter(self.selectChapterClientID_)
	self:AutoSwitchImage()
end

function ChapterMapContentView:InitImage()
	self.chapterBehindImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint
	self.chapterFrontImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint
end

function ChapterMapContentView:AutoSwitchImage()
	self.chapterBehindImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint

	self:StopLeanTween()

	self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 0, ChapterMapContentView.SWITCH_STAGE_TIME)

	self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
		self.chapterFrontCanvasGroup_.alpha = arg_21_0
		self.chapterBehindCanvasGroup_.alpha = 1 - arg_21_0
	end))
	self.leanTweenHandler_:setOnComplete(System.Action(function()
		self:SwitchImageOver()
		self:StopLeanTween()
	end))
end

function ChapterMapContentView:StopLeanTween()
	if self.leanTweenHandler_ then
		LeanTween.cancel(self.chapterFrontImage_.gameObject)
		self.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		self.leanTweenHandler_ = nil
	end
end

function ChapterMapContentView:SwitchImageOver()
	self.chapterBehindImage_, self.chapterFrontImage_ = self.chapterFrontImage_, self.chapterBehindImage_
	self.chapterBehindCanvasGroup_, self.chapterFrontCanvasGroup_ = self.chapterFrontCanvasGroup_, self.chapterBehindCanvasGroup_
end

function ChapterMapContentView:RemoveListeners()
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)
end

function ChapterMapContentView:RefreshData()
	self.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)

	if ChapterClientCfg[self.selectChapterClientID_] then
		self.hardLevel_ = ChapterClientCfg[self.selectChapterClientID_].difficulty or 1
	end

	self.chapterList_ = {}

	for iter_26_0, iter_26_1 in ipairs(getChapterClientList()[self.hardLevel_]) do
		if ChapterTools.HasChapterStage(iter_26_1) then
			table.insert(self.chapterList_, iter_26_1)
		end
	end

	self.maxChapterLevel_ = #self.chapterList_
end

function ChapterMapContentView:RefreshUI()
	self:InitImage()
	self:RefreshViewContent()
	self:ChangeSelectChapterID()
	self:RefreshSelectDifficult()
	self:RefreshSelectChapter(self.selectChapterClientID_)
	self:RefreshToggle()
end

function ChapterMapContentView:ChangeSelectHardLevel()
	self:RefreshData()
	self:RefreshSelectChapter(0)
	self:RefreshViewContent()
	self:RefreshItemPosition()
	self:RefreshSelectDifficult()
	self:RefreshToggle()

	self.changeLevel_ = true
end

function ChapterMapContentView:RefreshToggle()
	for iter_29_0, iter_29_1 in ipairs(ChapterMainPlotToggleCfg.get_id_list_by_difficulty[self.hardLevel_]) do
		local var_29_0 = self.mainPlotChapterToggleList_[iter_29_0] or ChapterMapToggleView.New(self.chapterItem_, self.chapterParentGo_)

		self.mainPlotChapterToggleList_[iter_29_0] = var_29_0

		var_29_0:SetData(iter_29_1)
	end

	for iter_29_2 = #ChapterMainPlotToggleCfg.get_id_list_by_difficulty[self.hardLevel_] + 1, #self.mainPlotChapterToggleList_ do
		self.mainPlotChapterToggleList_[iter_29_2]:Show(false)
	end

	self:RefreshSelectChapterToggle()
end

function ChapterMapContentView:RefreshSelectChapter(arg_30_1)
	if self.viewSelectID_ == arg_30_1 then
		return
	end

	self.viewSelectID_ = arg_30_1

	for iter_30_0, iter_30_1 in ipairs(self.itemList_) do
		iter_30_1:SetSelectID(arg_30_1)
	end
end

function ChapterMapContentView:RefreshSelectChapterToggle()
	self.scrollTimer_ = FrameTimer.New(function()
		local var_32_0, var_32_1 = self:GetToggleIndex()

		if self.lastToggleIndx_ == var_32_0 then
			return
		end

		self.lastToggleIndx_ = var_32_0
		self.tempVector3_.x = 0
		self.tempVector3_.y = 0
		self.tempVector3_.z = 0

		local var_32_2 = self.viewTf_:InverseTransformPoint(self.mainPlotChapterToggleList_[var_32_0]:GetTransform():TransformPoint(self.tempVector3_))

		if var_32_2.x <= 0 or var_32_2.x >= self.viewTf_.rect.width then
			local var_32_3 = (var_32_0 - 1) / ((self.contentTf_.rect.width - self.viewTf_.rect.width) / (self.itemTf_.rect.width + self.contentLayout_.spacing))

			if (var_32_0 - 1) / ((self.contentTf_.rect.width - self.viewTf_.rect.width) / (self.itemTf_.rect.width + self.contentLayout_.spacing)) > 1 then
				var_32_3 = 1
			elseif var_32_3 < 0 then
				var_32_3 = 0
			end

			self.scrollView_.horizontalNormalizedPosition = var_32_3
		end

		for iter_32_0, iter_32_1 in pairs(self.mainPlotChapterToggleList_) do
			iter_32_1:SetSelectID(self.selectChapterClientID_)
		end
	end, 1, 1)

	self.scrollTimer_:Start()
end

function ChapterMapContentView:GetToggleIndex()
	for iter_33_0, iter_33_1 in ipairs(ChapterMainPlotToggleCfg.get_id_list_by_difficulty[self.hardLevel_]) do
		if table.keyof(ChapterMainPlotToggleCfg[iter_33_1].chapter_client_list, self.selectChapterClientID_) then
			return iter_33_0, #ChapterMainPlotToggleCfg.get_id_list_by_difficulty[self.hardLevel_]
		end
	end

	return #ChapterMainPlotToggleCfg.get_id_list_by_difficulty[self.hardLevel_], #ChapterMainPlotToggleCfg.get_id_list_by_difficulty[self.hardLevel_]
end

function ChapterMapContentView:RefreshViewContent()
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in ipairs(self.chapterList_) do
		var_34_0 = var_34_0 + 1

		if self.positionList_[iter_34_0] == nil then
			self.positionList_[iter_34_0] = Vector3.New(self.layoutGroup_.padding.left + (self.mapItemTf_.rect.width + self.layoutGroup_.spacing) * (iter_34_0 - 1) + self.mapItemTf_.rect.width / 2, 0, 0)
		end
	end

	self.tempVector2_.x = self.layoutGroup_.padding.left + self.mapItemTf_.rect.width * var_34_0 + self.layoutGroup_.spacing * (var_34_0 - 1) + self.layoutGroup_.padding.right - self.viewportTransform_.rect.width
	self.tempVector2_.y = self.mapItemParentTf_.sizeDelta.y
	self.mapItemParentTf_.sizeDelta = self.tempVector2_
end

function ChapterMapContentView:IsDisplayItem(arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(self.itemList_) do
		if arg_35_1 == iter_35_1:GetChapterClientID() then
			return iter_35_0
		end
	end
end

function ChapterMapContentView:RefreshItemPosition()
	local var_36_0, var_36_1 = self:CalcStartToEndIndex()
	local var_36_2 = {}
	local var_36_3 = {}

	for iter_36_0 = var_36_0, var_36_1 do
		local var_36_4 = self:IsDisplayItem(self.chapterList_[iter_36_0])

		if var_36_4 then
			self.itemList_[var_36_4]:SetChapterClientID(self.chapterList_[iter_36_0])
			self.itemList_[var_36_4]:SetLocalPosition(self.positionList_[iter_36_0])
			table.insert(var_36_2, var_36_4)
		else
			table.insert(var_36_3, iter_36_0)
		end
	end

	for iter_36_1, iter_36_2 in ipairs(var_36_3) do
		for iter_36_3, iter_36_4 in ipairs(self.itemList_) do
			if not table.keyof(var_36_2, iter_36_3) then
				table.insert(var_36_2, iter_36_3)
				iter_36_4:SetChapterClientID(self.chapterList_[iter_36_2])
				iter_36_4:SetLocalPosition(self.positionList_[iter_36_2])

				break
			end
		end
	end

	for iter_36_5 = 1, #self.itemList_ do
		if not table.keyof(var_36_2, iter_36_5) then
			self.itemList_[iter_36_5]:Show(false)
		end
	end
end

function ChapterMapContentView:CalcStartToEndIndex()
	local var_37_0 = 1
	local var_37_1 = 1

	self.chapterList_ = self.chapterList_ or {}

	for iter_37_0, iter_37_1 in ipairs(self.chapterList_) do
		if self.positionList_[iter_37_0].x + self.mapItemParentTf_.localPosition.x + self.mapItemTf_.rect.width / 2 < 0 then
			var_37_0 = iter_37_0
		end

		if self.positionList_[iter_37_0].x + self.mapItemParentTf_.localPosition.x + self.mapItemTf_.rect.width / 2 >= 0 and self.viewportTransform_.rect.width >= self.positionList_[iter_37_0].x + self.mapItemParentTf_.localPosition.x - self.mapItemTf_.rect.width / 2 then
			var_37_1 = iter_37_0
		end
	end

	if var_37_1 < var_37_0 then
		var_37_1 = var_37_0
	end

	return var_37_0, var_37_1
end

function ChapterMapContentView:RefreshSelectDifficult()
	self.hardLevelView_:SetData(self.hardLevel_, 0)
end

function ChapterMapContentView:ChangeSelectChapterID()
	self:RefreshData()
	self:StopAllTimer()
	self.scrollRect_:StopMovement()

	local var_39_0 = self:GetItemPositionX(self.selectChapterClientID_)

	if self.changeLevel_ or not self.isFirstEnter_ then
		local var_39_1 = self.mapItemParentTf_.localPosition

		self.tempVector3_.x = var_39_0
		self.tempVector3_.y = var_39_1.y
		self.tempVector3_.z = var_39_1.z
		self.mapItemParentTf_.localPosition = self.tempVector3_

		self:RefreshItemPosition()
		self:StopMoveAction()
	else
		self:AddMoveTimer(var_39_0)
	end

	self:RefreshSelectChapterToggle()

	if self.changeLevel_ or not self.isFirstEnter_ then
		self.changeLevel_ = false
		self.isFirstEnter_ = true
	else
		self:RefreshSelectChapter(0)
	end
end

function ChapterMapContentView:ChangeSelectID(arg_40_1)
	if not arg_40_1 then
		return
	end

	if arg_40_1 == BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT) then
		return
	end

	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, arg_40_1)
	self:RefreshSelectChapterToggle()
end

function ChapterMapContentView:SearchNearClientID()
	local var_41_0

	for iter_41_0, iter_41_1 in ipairs(self.chapterList_) do
		if math.abs(self.positionList_[iter_41_0].x + self.mapItemParentTf_.localPosition.x - self.viewportTransform_.rect.width / 2) <= 200000 then
			var_41_0 = iter_41_1
		end
	end

	return var_41_0
end

function ChapterMapContentView:GetItemPositionX(arg_42_1)
	return -self.positionList_[table.keyof(self.chapterList_, arg_42_1)].x + self.viewportTransform_.rect.width / 2
end

function ChapterMapContentView:AddSnapTimer()
	self:StopSnapTimer()

	self.snapTimer_ = FrameTimer.New(function()
		if self.scrollRect_.velocity.x > -200 and self.scrollRect_.velocity.x < 200 then
			self.scrollRect_:StopMovement()

			local var_44_0 = self:SearchNearClientID()

			self.selectChapterClientID_ = var_44_0

			self:ChangeSelectID(var_44_0)
			self:AddMoveTimer((self:GetItemPositionX(var_44_0)))
			self:StopSnapTimer()
		end
	end, 1, -1)

	self.snapTimer_:Start()
end

function ChapterMapContentView:StopSnapTimer()
	if self.snapTimer_ then
		self.snapTimer_:Stop()

		self.snapTimer_ = nil
	end
end

function ChapterMapContentView:AddMoveTimer(arg_46_1)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		self.tempVector3_.x = arg_46_1
		self.tempVector3_.y = self.mapItemParentTf_.localPosition.y
		self.tempVector3_.z = self.mapItemParentTf_.localPosition.z

		local var_47_0 = Vector3.Lerp(self.mapItemParentTf_.localPosition, self.tempVector3_, GameSetting.chapter_velocity_times.value[1] * math.pow(self.scrollRect_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if GameSetting.chapter_scroll_min_length.value[1] > math.abs(self.mapItemParentTf_.localPosition.x - var_47_0.x) then
			local var_47_1 = arg_46_1 - self.mapItemParentTf_.localPosition.x

			if GameSetting.chapter_scroll_min_length.value[1] < math.abs(arg_46_1 - self.mapItemParentTf_.localPosition.x) then
				var_47_1 = GameSetting.chapter_scroll_min_length.value[1] * var_47_1 / math.abs(var_47_1)
			end

			var_47_0.x = var_47_0.x + var_47_1
		end

		self.mapItemParentTf_.anchoredPosition = var_47_0

		if math.abs(self.mapItemParentTf_.localPosition.x - arg_46_1) <= GameSetting.chapter_stop_min_length.value[1] then
			self.scrollView_:StopMovement()

			self.mapItemParentTf_.anchoredPosition = self.tempVector3_

			self:StopToggleTimer()
			self:StopMoveTimer()
			self:StopMoveAction()
		end
	end, 1, -1)

	self.moveTimer_:Start()
end

function ChapterMapContentView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function ChapterMapContentView:AddToggleTimer()
	self:StopToggleTimer()

	self.toggleTimer_ = FrameTimer.New(function()
		local var_50_0 = self:SearchNearClientID()

		self.selectChapterClientID_ = var_50_0

		self:ChangeSelectID(var_50_0)
	end, 1, -1)

	self.toggleTimer_:Start()
end

function ChapterMapContentView:StopToggleTimer()
	if self.toggleTimer_ then
		self.toggleTimer_:Stop()

		self.toggleTimer_ = nil
	end
end

function ChapterMapContentView:StopAllTimer()
	self:StopMoveTimer()
	self:StopSnapTimer()
	self:StopToggleTimer()
end

function ChapterMapContentView:OnAssetPendDownloadEnd(arg_53_1, arg_53_2)
	for iter_53_0, iter_53_1 in ipairs(self.itemList_) do
		iter_53_1:RefreshLock()
	end
end

return ChapterMapContentView
