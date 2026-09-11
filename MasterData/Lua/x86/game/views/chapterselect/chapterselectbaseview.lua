local ChaperSelectBaseView = class("ChaperSelectBaseView", ReduxView)

ChaperSelectBaseView.MAX_DRAG_LENGTH = 1500
ChaperSelectBaseView.MIN_DRAG_LENGTH = 200
ChaperSelectBaseView.SWITCH_STAGE_TIME = 0.8

function ChaperSelectBaseView:UIName()
	return
end

function ChaperSelectBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function ChaperSelectBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.tempVector2_ = Vector2.New(0, 0, 0)
	self.hardController_ = self.controllerEx_:GetController("isSubPlot")
	self.activityController_ = self.controllerEx_:GetController("isActivity")
	self.chapterSelectTitleView_ = ChapterSelectTitleView.New(self.titleGo_)
end

function ChaperSelectBaseView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	self:RefreshData()
	self:InitImage()
	self:RefreshUI()
	self.chapterSelectTitleView_:OnEnter(self.selectChapterClientID_)
end

function ChaperSelectBaseView:OnExit()
	manager.windowBar:HideBar()
	self.chapterSelectTitleView_:OnExit()
	self:StopAllTimer()
	self:StopLeanTween()
end

function ChaperSelectBaseView:Dispose()
	self.chapterSelectTitleView_:Dispose()

	self.chapterSelectTitleView_ = nil

	self:RemoveListeners()
	ChaperSelectBaseView.super.Dispose(self)
end

function ChaperSelectBaseView:AddListeners()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.DragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handler(self, self.PointerUpFun)))
	self.toggleEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginToggleDragFun)))
end

function ChaperSelectBaseView:BeginDragFun(arg_8_1, arg_8_2)
	self:StopLeanTween()
end

function ChaperSelectBaseView:DragFun(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.position.x - arg_9_2.pressPosition.x
	local var_9_1 = ChapterTools.GetNeighborClientID(self.selectChapterClientID_, arg_9_2.position.x - arg_9_2.pressPosition.x < 0)

	if var_9_1 == self.selectChapterClientID_ then
		return
	end

	if self.nextChapterClientID_ ~= var_9_1 then
		SetSpriteWithoutAtlasAsync(self.chapterBehindImage_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[var_9_1].chapter_paint)

		self.nextChapterClientID_ = var_9_1
	end

	local var_9_2 = math.min(math.max(0, math.abs(var_9_0)), ChaperSelectBaseView.MAX_DRAG_LENGTH) / ChaperSelectBaseView.MAX_DRAG_LENGTH

	self.chapterFrontCanvasGroup_.alpha = 1 - var_9_2
	self.chapterBehindCanvasGroup_.alpha = var_9_2
end

function ChaperSelectBaseView:EndDragFun(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.position.x - arg_10_2.pressPosition.x

	if ChapterTools.GetNeighborClientID(self.selectChapterClientID_, arg_10_2.position.x - arg_10_2.pressPosition.x < 0) == self.selectChapterClientID_ then
		return
	end

	if math.abs(var_10_0) > ChaperSelectBaseView.MIN_DRAG_LENGTH then
		self.selectChapterClientID_ = self.nextChapterClientID_
		self.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, self.selectChapterClientID_)
		self:RefreshData()

		if math.abs(var_10_0) > ChaperSelectBaseView.MAX_DRAG_LENGTH then
			self:RefreshChapterUI()
			self:SwitchImageOver()
		else
			self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 0, (ChaperSelectBaseView.MAX_DRAG_LENGTH - math.abs(var_10_0)) / ChaperSelectBaseView.MAX_DRAG_LENGTH * ChaperSelectBaseView.SWITCH_STAGE_TIME)

			self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
				self.chapterFrontCanvasGroup_.alpha = arg_11_0
				self.chapterBehindCanvasGroup_.alpha = 1 - arg_11_0
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
		self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 1, (1 - (ChaperSelectBaseView.MIN_DRAG_LENGTH - math.abs(var_10_0)) / ChaperSelectBaseView.MIN_DRAG_LENGTH) * 0.8)

		self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
			self.chapterFrontCanvasGroup_.alpha = arg_13_0
			self.chapterBehindCanvasGroup_.alpha = 1 - arg_13_0
		end))
		self.leanTweenHandler_:setOnComplete(System.Action(function()
			LeanTween.cancel(self.chapterFrontImage_.gameObject)
			self.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

			self.leanTweenHandler_ = nil
		end))
	end
end

function ChaperSelectBaseView:PointerUpFun(arg_15_1, arg_15_2)
	if arg_15_2.dragging then
		return
	end

	local var_15_0 = BattleFieldData:GetCacheChapter(self.selectChapterClientID_)
	local var_15_1, var_15_2 = ChapterTools.IsFinishPreChapter(var_15_0)

	if not var_15_1 then
		ShowTips(ChapterTools.GetChapterLockText(var_15_0, var_15_2))

		return
	end

	ChapterTools.GotoChapterSection(var_15_0)
end

function ChaperSelectBaseView:BeginToggleDragFun(arg_16_1, arg_16_2)
	self:StopMoveTimer()
	self.scrollView_:OnBeginDrag(arg_16_2)
end

function ChaperSelectBaseView:RemoveListeners()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	self.toggleEventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
end

function ChaperSelectBaseView:SwitchImageOver()
	self.chapterBehindImage_, self.chapterFrontImage_ = self.chapterFrontImage_, self.chapterBehindImage_
	self.chapterBehindCanvasGroup_, self.chapterFrontCanvasGroup_ = self.chapterFrontCanvasGroup_, self.chapterBehindCanvasGroup_
end

function ChaperSelectBaseView:AutoSwitchImage()
	SetSpriteWithoutAtlasAsync(self.chapterBehindImage_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint)

	self.leanTweenHandler_ = LeanTween.value(self.chapterFrontImage_.gameObject, self.chapterFrontCanvasGroup_.alpha, 0, ChaperSelectBaseView.SWITCH_STAGE_TIME)

	self.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
		self.chapterFrontCanvasGroup_.alpha = arg_20_0
		self.chapterBehindCanvasGroup_.alpha = 1 - arg_20_0
	end))
	self.leanTweenHandler_:setOnComplete(System.Action(function()
		self:SwitchImageOver()
		LeanTween.cancel(self.chapterFrontImage_.gameObject)
		self.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		self.leanTweenHandler_ = nil
	end))
end

function ChaperSelectBaseView:RefreshData()
	return
end

function ChaperSelectBaseView:InitImage()
	SetSpriteWithoutAtlasAsync(self.chapterBehindImage_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint)
	SetSpriteWithoutAtlasAsync(self.chapterFrontImage_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.selectChapterClientID_].chapter_paint)
end

function ChaperSelectBaseView:RefreshUI()
	return
end

function ChaperSelectBaseView:AddMoveTimer(arg_25_1)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		local var_26_0 = self.contentTf_.anchoredPosition
		local var_26_1 = arg_25_1:GetLocalPosition().x * -1

		if self.scrollTf_.rect.width / 2 >= self.contentTf_.rect.width / 2 + var_26_1 then
			var_26_1 = self.scrollTf_.rect.width / 2 - self.contentTf_.rect.width / 2
		elseif self.scrollTf_.rect.width / 2 >= self.contentTf_.rect.width / 2 - var_26_1 then
			var_26_1 = self.contentTf_.rect.width / 2 - self.scrollTf_.rect.width / 2
		end

		self.tempVector2_.x = var_26_1
		self.tempVector2_.y = var_26_0.y
		self.contentTf_.anchoredPosition = Vector2.Lerp(var_26_0, self.tempVector2_, 3 * math.pow(self.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if math.abs(var_26_0.x - var_26_1) <= 1 then
			self.contentTf_.anchoredPosition = self.tempVector2_

			self:StopMoveTimer()
		end
	end, 1, -1)

	self.moveTimer_:Start()
end

function ChaperSelectBaseView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function ChaperSelectBaseView:StopLeanTween()
	if self.leanTweenHandler_ then
		LeanTween.cancel(self.chapterFrontImage_.gameObject)
		self.leanTweenHandler_:callOnCompletes()
	end
end

function ChaperSelectBaseView:StopAllTimer()
	self:StopMoveTimer()
end

return ChaperSelectBaseView
