local ChapterSelectSubChapterView = class("ChapterSelectSubChapterView", ReduxView)

ChapterSelectSubChapterView.MAX_DRAG_LENGTH = 1500
ChapterSelectSubChapterView.MIN_DRAG_LENGTH = 200
ChapterSelectSubChapterView.SWITCH_STAGE_TIME = 0.8

function ChapterSelectSubChapterView:UIName()
	return "Widget/System/Operation/OperationSideUI"
end

function ChapterSelectSubChapterView:UIParent()
	return manager.ui.uiMain.transform
end

function ChapterSelectSubChapterView:Init()
	self:BindCfgUI()

	self.chapterBehindImage_.immediate = true
	self.chapterFrontImage_.immediate = true

	self:AddListeners()

	self.tempVector2_ = Vector2.New(0, 0, 0)
	self.chapterSelectTitleView_ = ChapterSelectTitleView.New(self.titleGo_)
	self.changeSelectChapterHandler_ = handler(self, self.ChangeSelectChapterID)
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.chapterToggleItemList_ = {}
	self.positionList_ = {}
end

function ChapterSelectSubChapterView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
end

function ChapterSelectSubChapterView:RefeshGroupData()
	self.groupDataList_ = ChapterTools.GetChapterGroupList(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT))

	table.sort(self.groupDataList_, function(arg_6_0, arg_6_1)
		if ChapterClientCfg[arg_6_0[2]].sort < ChapterClientCfg[arg_6_1[2]].sort then
			return true
		else
			return false
		end
	end)
end

function ChapterSelectSubChapterView:OnEnter()
	self:RefeshGroupData()
	self:RefreshViewContent()
	self:RefreshData()
	self:InitImage()
	self:RefreshUI()
	self.chapterSelectTitleView_:OnEnter(self.selectChapterClientID_)
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, self.changeSelectChapterHandler_)

	for iter_7_0, iter_7_1 in ipairs(self.chapterToggleItemList_) do
		iter_7_1:OnEnter()
	end

	self:RefreshItemPosition()
	self:CheckChapterSurvey()
	self:CheckStoryLineRedPoint()
end

function ChapterSelectSubChapterView:OnExit()
	manager.windowBar:HideBar()
	self.chapterSelectTitleView_:OnExit()
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, self.changeSelectChapterHandler_)
	self:StopAllTimer()
	self:StopLeanTween()

	for iter_8_0, iter_8_1 in ipairs(self.chapterToggleItemList_) do
		iter_8_1:OnExit()
	end
end

function ChapterSelectSubChapterView:CheckChapterSurvey()
	if not getData("CHAPTERVIEW", "POPED_SURVEY_" .. self.selectChapterClientID_) and SurveyData:GetChapterSurveyUrl(self.selectChapterClientID_) and SurveyData:GetChapterSurveyUrl(self.selectChapterClientID_) ~= "" and ChapterTools.IsClearChapterClient(self.selectChapterClientID_) then
		saveData("CHAPTERVIEW", "POPED_SURVEY_" .. self.selectChapterClientID_, true)
		JumpTools.OpenPageByJump("chapterSurveyPop", {
			chapterID = self.selectChapterClientID_
		})
	end
end

function ChapterSelectSubChapterView:Dispose()
	self.scrollView_.onValueChanged:RemoveAllListeners()

	self.changeSelectChapterHandler_ = nil
	self.chapterBehindImage_ = nil

	for iter_10_0, iter_10_1 in ipairs(self.chapterToggleItemList_) do
		iter_10_1:Dispose()
	end

	self.chapterToggleItemList_ = nil

	self.chapterSelectTitleView_:Dispose()

	self.chapterSelectTitleView_ = nil

	self:RemoveListeners()
	ChapterSelectSubChapterView.super.Dispose(self)
end

function ChapterSelectSubChapterView:AddListeners()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.DragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handler(self, self.PointerUpFun)))
	self.toggleEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginToggleDragFun)))
	self.scrollView_.onValueChanged:AddListener(function()
		self:RefreshItemPosition()
	end)
	self:AddBtnListener(self.surveyBtn_, nil, function()
		JumpTools.OpenPageByJump("chapterSurveyPop", {
			chapterID = self.selectChapterClientID_
		})
	end)
	self:AddBtnListener(self.chapterTimeLineBtn_, nil, function()
		gameContext:Go("/chapterTimeline")
		saveData("CHAPTERVIEW", "STORYLINE_REDPNT", true)
		OperationRecorder.RecordButtonTouch("story_timeline_entrance_2")
	end)
end

function ChapterSelectSubChapterView:CheckStoryLineRedPoint()
	if getData("CHAPTERVIEW", "STORYLINE_REDPNT") then
		manager.redPoint:SetRedPointIndependent(self.chapterTimeLineBtn_.transform, false)
	else
		manager.redPoint:SetRedPointIndependent(self.chapterTimeLineBtn_.transform, true, nil, RedPointStyle.SHOW_NEW_TAG)
	end
end

function ChapterSelectSubChapterView:BeginDragFun(arg_16_1, arg_16_2)
	self:StopLeanTween()
end

function ChapterSelectSubChapterView:GetNeighborClientID(arg_17_1, arg_17_2)
	local var_17_0 = -1

	for iter_17_0, iter_17_1 in ipairs(self.groupDataList_) do
		if iter_17_1[2] == arg_17_1 then
			var_17_0 = iter_17_0

			break
		end
	end

	if arg_17_2 and var_17_0 < #self.groupDataList_ then
		var_17_0 = var_17_0 + 1
	elseif not arg_17_2 and var_17_0 > 1 then
		var_17_0 = var_17_0 - 1
	end

	if var_17_0 > 0 then
		return self.groupDataList_[var_17_0][2]
	else
		return arg_17_1
	end
end

function ChapterSelectSubChapterView:DragFun(arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2.position.x - arg_18_2.pressPosition.x
	local var_18_1 = self:GetNeighborClientID(self.selectChapterClientID_, arg_18_2.position.x - arg_18_2.pressPosition.x < 0)

	if var_18_1 == self.selectChapterClientID_ then
		return
	end

	if self.nextChapterClientID_ ~= var_18_1 then
		self.chapterBehindImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[var_18_1].chapter_paint
		self.nextChapterClientID_ = var_18_1
	end

	local var_18_2 = math.min(math.max(0, math.abs(var_18_0)), ChapterSelectSubChapterView.MAX_DRAG_LENGTH) / ChapterSelectSubChapterView.MAX_DRAG_LENGTH

	self.chapterFrontCanvasGroup_.alpha = 1 - var_18_2
	self.chapterBehindCanvasGroup_.alpha = var_18_2
end

function ChapterSelectSubChapterView:EndDragFun(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2.position.x - arg_19_2.pressPosition.x

	if self:GetNeighborClientID(self.selectChapterClientID_, arg_19_2.position.x - arg_19_2.pressPosition.x < 0) == self.selectChapterClientID_ then
		return
	end

	if math.abs(var_19_0) > ChapterSelectSubChapterView.MIN_DRAG_LENGTH then
		if self.selectChapterClientID_ == self.nextChapterClientID_ then
			return
		end

		self.selectChapterClientID_ = self.nextChapterClientID_
		self.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, self.selectChapterClientID_)
		self:RefreshData()

		if math.abs(var_19_0) > ChapterSelectSubChapterView.MAX_DRAG_LENGTH then
			self:RefreshChapterUI()
			self:SwitchImageOver()
		else
			self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 0, (ChapterSelectSubChapterView.MAX_DRAG_LENGTH - math.abs(var_19_0)) / ChapterSelectSubChapterView.MAX_DRAG_LENGTH * ChapterSelectSubChapterView.SWITCH_STAGE_TIME)

			self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
				self.chapterFrontCanvasGroup_.alpha = arg_20_0
				self.chapterBehindCanvasGroup_.alpha = 1 - arg_20_0
			end))
			self.leanTweenHandler_:setOnComplete(System.Action(function()
				self:RefreshChapterUI()
				self:SwitchImageOver()
				LeanTween.cancel(self.chapterFrontImage_.gameObject)
				self.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

				self.leanTweenHandler_ = nil
			end))
		end
	else
		self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 1, (1 - (ChapterSelectSubChapterView.MIN_DRAG_LENGTH - math.abs(var_19_0)) / ChapterSelectSubChapterView.MIN_DRAG_LENGTH) * 0.8)

		self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
			self.chapterFrontCanvasGroup_.alpha = arg_22_0
			self.chapterBehindCanvasGroup_.alpha = 1 - arg_22_0
		end))
		self.leanTweenHandler_:setOnComplete(System.Action(function()
			LeanTween.cancel(self.chapterFrontImage_.gameObject)
			self.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

			self.leanTweenHandler_ = nil
		end))
	end
end

function ChapterSelectSubChapterView:PointerUpFun(arg_24_1, arg_24_2)
	if arg_24_2.dragging then
		return
	end

	JumpTools.Jump2SubPlot(self.selectChapterClientID_, false, true)
end

function ChapterSelectSubChapterView:BeginToggleDragFun(arg_25_1, arg_25_2)
	self:StopMoveTimer()
	self.scrollView_:OnBeginDrag(arg_25_2)
end

function ChapterSelectSubChapterView:RemoveListeners()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	self.toggleEventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
end

function ChapterSelectSubChapterView:SwitchImageOver()
	self.chapterBehindImage_, self.chapterFrontImage_ = self.chapterFrontImage_, self.chapterBehindImage_
	self.chapterBehindCanvasGroup_, self.chapterFrontCanvasGroup_ = self.chapterFrontCanvasGroup_, self.chapterBehindCanvasGroup_
	self.chapterFrontCanvasGroup_.alpha = 1
	self.chapterBehindCanvasGroup_.alpha = 0
end

function ChapterSelectSubChapterView:AutoSwitchImage()
	self.chapterBehindImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint
	self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 0, ChapterSelectSubChapterView.SWITCH_STAGE_TIME)

	self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
		self.chapterFrontCanvasGroup_.alpha = arg_29_0
		self.chapterBehindCanvasGroup_.alpha = 1 - arg_29_0
	end))
	self.leanTweenHandler_:setOnComplete(System.Action(function()
		self:SwitchImageOver()
		LeanTween.cancel(self.chapterFrontImage_.gameObject)
		self.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		self.leanTweenHandler_ = nil
	end))
end

function ChapterSelectSubChapterView:RefreshData()
	self.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)
	self.isLock_ = not ChapterTools.IsUnlockSubPlotClient(ChapterClientCfg[self.selectChapterClientID_].chapter_list[1])

	SetActive(self.surveyBtn_.gameObject, SurveyData:GetChapterSurveyID(self.selectChapterClientID_) and SurveyData:GetChapterSurveyID(self.selectChapterClientID_) ~= 0 and ChapterTools.IsClearChapterClient(self.selectChapterClientID_))
end

function ChapterSelectSubChapterView:InitImage()
	self.chapterBehindImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint
	self.chapterFrontImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint
end

function ChapterSelectSubChapterView:RefreshUI()
	self:RefreshChapterUI()
	self:AutoSwitchImage()
end

function ChapterSelectSubChapterView:RefreshChapterUI()
	self.chapterSelectTitleView_:OnEnter(self.selectChapterClientID_)
	self:RefreshGroupToggle()
	self:AddActivityTimer()
	self:RefreshActivity()
	self:RefreshLock()
	self:RefreshSelectToggle()
end

function ChapterSelectSubChapterView:RefreshGroupToggle()
	self:AddMoveTimer(self:GetItemPositionX(self.selectChapterClientID_))
end

function ChapterSelectSubChapterView:RefreshActivity()
	return
end

function ChapterSelectSubChapterView:RefreshLock()
	if not manager.assetPend:CheckAssetPend(ChapterClientCfg[self.selectChapterClientID_].asset_pend_key) then
		self.lockController_:SetSelectedState("assetpend")
	else
		self.lockController_:SetSelectedState("false")
	end
end

function ChapterSelectSubChapterView:ChangeSelectChapterID()
	self:StopLeanTween()
	self:RefreshData()
	self:RefreshUI()
end

function ChapterSelectSubChapterView:GetActivityID()
	return ChapterCfg[ChapterClientCfg[self.selectChapterClientID_].chapter_list[1]].activity_id or 0
end

function ChapterSelectSubChapterView:AddActivityTimer()
	self:RemoveActivityTimer()

	local var_40_0 = ChapterClientCfg[self.selectChapterClientID_].chapter_list[1]
	local var_40_1 = self:GetActivityID()

	if var_40_1 == 0 then
		return
	end

	local var_40_2 = ActivityData:GetActivityData(var_40_1):IsActivitying()

	self.activityTimer_ = Timer.New(function()
		local var_41_0 = ActivityData:GetActivityData(var_40_1):IsActivitying()

		if var_41_0 ~= var_40_2 then
			var_40_2 = var_41_0
			self.isLock_ = not ChapterTools.IsUnlockSubPlotClient(var_40_0)

			self:RefreshLock()
			self:RefreshActivity()
		end
	end, 1, -1)

	self.activityTimer_:Start()
end

function ChapterSelectSubChapterView:RemoveActivityTimer()
	if self.activityTimer_ then
		self.activityTimer_:Stop()

		self.activityTimer_ = nil
	end
end

function ChapterSelectSubChapterView:AddMoveTimer(arg_43_1)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		local var_44_0 = self.chapterParentTf_.anchoredPosition
		local var_44_1 = arg_43_1 * -1

		if self.scrollTf_.rect.width / 2 >= self.chapterParentTf_.rect.width / 2 + arg_43_1 * -1 then
			var_44_1 = self.scrollTf_.rect.width / 2 - self.chapterParentTf_.rect.width / 2
		elseif self.scrollTf_.rect.width / 2 >= self.chapterParentTf_.rect.width / 2 - var_44_1 then
			var_44_1 = self.chapterParentTf_.rect.width / 2 - self.scrollTf_.rect.width / 2
		end

		self.tempVector2_.x = var_44_1
		self.tempVector2_.y = var_44_0.y
		self.chapterParentTf_.anchoredPosition = Vector2.Lerp(var_44_0, self.tempVector2_, 3 * math.pow(self.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if math.abs(var_44_0.x - var_44_1) <= 1 then
			self.chapterParentTf_.anchoredPosition = self.tempVector2_

			self:StopMoveTimer()
		end
	end, 1, -1)

	self.moveTimer_:Start()
end

function ChapterSelectSubChapterView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function ChapterSelectSubChapterView:StopLeanTween()
	if self.leanTweenHandler_ then
		LeanTween.cancel(self.chapterFrontImage_.gameObject)
		self.leanTweenHandler_:callOnCompletes()
	end
end

function ChapterSelectSubChapterView:StopAllTimer()
	self:StopMoveTimer()
	self:RemoveActivityTimer()
end

function ChapterSelectSubChapterView:RefreshViewContent()
	local var_48_0 = 0

	for iter_48_0, iter_48_1 in ipairs(self.groupDataList_) do
		var_48_0 = var_48_0 + 1
	end

	self.chapterParentTf_.sizeDelta = Vector2(self.layoutGroup_.padding.left + self.chapterItemTf_.rect.width * var_48_0 + self.layoutGroup_.spacing * (var_48_0 - 1) + self.layoutGroup_.padding.right, self.chapterParentTf_.sizeDelta.y)

	for iter_48_2, iter_48_3 in ipairs(self.groupDataList_) do
		self.positionList_[iter_48_2] = Vector3(self.layoutGroup_.padding.left + (self.chapterItemTf_.rect.width + self.layoutGroup_.spacing) * (iter_48_2 - 1) + self.chapterItemTf_.rect.width / 2 - (self.layoutGroup_.padding.left + self.chapterItemTf_.rect.width * var_48_0 + self.layoutGroup_.spacing * (var_48_0 - 1) + self.layoutGroup_.padding.right) / 2, 0, 0)
	end

	for iter_48_4 = 1, self.viewportTransform_.rect.width / (self.chapterItemTf_.rect.width + self.layoutGroup_.spacing) + 2 do
		if self.chapterToggleItemList_[iter_48_4] == nil then
			self.chapterToggleItemList_[iter_48_4] = ChapterSelectSubChapterToggleItem.New(self.chapterToggleItem_, self.chapterParentTf_)
		end
	end
end

function ChapterSelectSubChapterView:RefreshItemPosition()
	local var_49_0, var_49_1 = self:CalcStartToEndIndex()
	local var_49_2 = {}
	local var_49_3 = {}

	for iter_49_0 = #self.chapterToggleItemList_ + 1, var_49_1 - var_49_0 + 1 do
		self.chapterToggleItemList_[iter_49_0] = ChapterSelectSubChapterToggleItem.New(self.chapterToggleItem_, self.chapterParentTf_)
	end

	for iter_49_1 = var_49_0, var_49_1 do
		local var_49_4 = self.groupDataList_[iter_49_1][2]
		local var_49_5 = self:IsDisplayItem(self.groupDataList_[iter_49_1][2])

		if var_49_5 then
			self.chapterToggleItemList_[var_49_5]:SetData(var_49_4)
			self.chapterToggleItemList_[var_49_5]:SetLocalPosition(self.positionList_[iter_49_1])
			self.chapterToggleItemList_[var_49_5]:SetSelect(var_49_4 == self.selectChapterClientID_)
			table.insert(var_49_2, var_49_5)
		else
			table.insert(var_49_3, iter_49_1)
		end
	end

	for iter_49_2, iter_49_3 in ipairs(var_49_3) do
		for iter_49_4, iter_49_5 in ipairs(self.chapterToggleItemList_) do
			if not table.keyof(var_49_2, iter_49_4) then
				table.insert(var_49_2, iter_49_4)

				local var_49_6 = self.groupDataList_[iter_49_3][2]

				iter_49_5:SetData(self.groupDataList_[iter_49_3][2])
				iter_49_5:SetLocalPosition(self.positionList_[iter_49_3])
				iter_49_5:SetSelect(var_49_6 == self.selectChapterClientID_)

				break
			end
		end
	end

	for iter_49_6 = 1, #self.chapterToggleItemList_ do
		if not table.keyof(var_49_2, iter_49_6) then
			self.chapterToggleItemList_[iter_49_6]:Show(false)
		end
	end
end

function ChapterSelectSubChapterView:CalcStartToEndIndex()
	local var_50_0 = 1
	local var_50_1 = 1

	for iter_50_0, iter_50_1 in ipairs(self.groupDataList_) do
		if self.positionList_[iter_50_0].x + self.chapterParentTf_.localPosition.x - self.chapterItemTf_.rect.width / 2 < 0 then
			var_50_0 = iter_50_0
		end

		if self.positionList_[iter_50_0].x + self.chapterParentTf_.localPosition.x + self.chapterItemTf_.rect.width / 2 >= 0 and self.viewportTransform_.rect.width >= self.positionList_[iter_50_0].x + self.chapterParentTf_.localPosition.x - self.chapterItemTf_.rect.width / 2 then
			var_50_1 = iter_50_0
		end
	end

	if var_50_1 < var_50_0 then
		var_50_1 = var_50_0
	end

	return var_50_0, var_50_1
end

function ChapterSelectSubChapterView:IsDisplayItem(arg_51_1)
	for iter_51_0, iter_51_1 in ipairs(self.chapterToggleItemList_) do
		if arg_51_1 == iter_51_1:GetChapterClientID() then
			return iter_51_0
		end
	end
end

function ChapterSelectSubChapterView:GetItemPositionX(arg_52_1)
	for iter_52_0, iter_52_1 in ipairs(self.groupDataList_) do
		if iter_52_1[2] == arg_52_1 then
			return self.positionList_[iter_52_0].x
		end
	end

	return 0
end

function ChapterSelectSubChapterView:RefreshSelectToggle()
	for iter_53_0, iter_53_1 in ipairs(self.chapterToggleItemList_) do
		iter_53_1:SetSelect(iter_53_1:GetChapterClientID() == self.selectChapterClientID_)
	end
end

function ChapterSelectSubChapterView:OnAssetPendDownloadEnd(arg_54_1, arg_54_2)
	self:RefreshLock()
end

return ChapterSelectSubChapterView
