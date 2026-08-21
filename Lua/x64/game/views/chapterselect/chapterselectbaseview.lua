local var_0_0 = class("ChaperSelectBaseView", ReduxView)

var_0_0.MAX_DRAG_LENGTH = 1500
var_0_0.MIN_DRAG_LENGTH = 200
var_0_0.SWITCH_STAGE_TIME = 0.8

function var_0_0.UIName(arg_1_0)
	return
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.tempVector2_ = Vector2.New(0, 0, 0)
	arg_3_0.hardController_ = arg_3_0.controllerEx_:GetController("isSubPlot")
	arg_3_0.activityController_ = arg_3_0.controllerEx_:GetController("isActivity")
	arg_3_0.chapterSelectTitleView_ = ChapterSelectTitleView.New(arg_3_0.titleGo_)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	arg_4_0:RefreshData()
	arg_4_0:InitImage()
	arg_4_0:RefreshUI()
	arg_4_0.chapterSelectTitleView_:OnEnter(arg_4_0.selectChapterClientID_)
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	arg_5_0.chapterSelectTitleView_:OnExit()
	arg_5_0:StopAllTimer()
	arg_5_0:StopLeanTween()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.chapterSelectTitleView_:Dispose()

	arg_6_0.chapterSelectTitleView_ = nil

	arg_6_0:RemoveListeners()
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.BeginDragFun)))
	arg_7_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.DragFun)))
	arg_7_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.EndDragFun)))
	arg_7_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.PointerUpFun)))
	arg_7_0.toggleEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_7_0, arg_7_0.BeginToggleDragFun)))
end

function var_0_0.BeginDragFun(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:StopLeanTween()
end

function var_0_0.DragFun(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.position.x - arg_9_2.pressPosition.x
	local var_9_1 = ChapterTools.GetNeighborClientID(arg_9_0.selectChapterClientID_, var_9_0 < 0)

	if var_9_1 == arg_9_0.selectChapterClientID_ then
		return
	end

	if arg_9_0.nextChapterClientID_ ~= var_9_1 then
		local var_9_2 = ChapterClientCfg[var_9_1]
		local var_9_3 = SpritePathCfg.ChapterPaint.path .. var_9_2.chapter_paint

		SetSpriteWithoutAtlasAsync(arg_9_0.chapterBehindImage_, var_9_3)

		arg_9_0.nextChapterClientID_ = var_9_1
	end

	local var_9_4 = math.min(math.max(0, math.abs(var_9_0)), var_0_0.MAX_DRAG_LENGTH) / var_0_0.MAX_DRAG_LENGTH

	arg_9_0.chapterFrontCanvasGroup_.alpha = 1 - var_9_4
	arg_9_0.chapterBehindCanvasGroup_.alpha = var_9_4
end

function var_0_0.EndDragFun(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.position.x - arg_10_2.pressPosition.x

	if ChapterTools.GetNeighborClientID(arg_10_0.selectChapterClientID_, var_10_0 < 0) == arg_10_0.selectChapterClientID_ then
		return
	end

	if math.abs(var_10_0) > var_0_0.MIN_DRAG_LENGTH then
		arg_10_0.selectChapterClientID_ = arg_10_0.nextChapterClientID_
		arg_10_0.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, arg_10_0.selectChapterClientID_)
		arg_10_0:RefreshData()

		if math.abs(var_10_0) > var_0_0.MAX_DRAG_LENGTH then
			arg_10_0:RefreshChapterUI()
			arg_10_0:SwitchImageOver()
		else
			local var_10_1 = (var_0_0.MAX_DRAG_LENGTH - math.abs(var_10_0)) / var_0_0.MAX_DRAG_LENGTH * var_0_0.SWITCH_STAGE_TIME

			arg_10_0.leanTweenHandler_ = LeanTween.value(arg_10_0.chapterFrontImage_.gameObject, arg_10_0.chapterFrontCanvasGroup_.alpha, 0, var_10_1)

			arg_10_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
				arg_10_0.chapterFrontCanvasGroup_.alpha = arg_11_0
				arg_10_0.chapterBehindCanvasGroup_.alpha = 1 - arg_11_0
			end))
			arg_10_0.leanTweenHandler_:setOnComplete(System.Action(function()
				arg_10_0:RefreshChapterUI()
				arg_10_0:SwitchImageOver()
				LeanTween.cancel(arg_10_0.chapterFrontImage_.gameObject)
				arg_10_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

				arg_10_0.leanTweenHandler_ = nil
			end))
		end
	else
		local var_10_2 = (1 - (var_0_0.MIN_DRAG_LENGTH - math.abs(var_10_0)) / var_0_0.MIN_DRAG_LENGTH) * 0.8

		arg_10_0.leanTweenHandler_ = LeanTween.value(arg_10_0.chapterFrontImage_.gameObject, arg_10_0.chapterFrontCanvasGroup_.alpha, 1, var_10_2)

		arg_10_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
			arg_10_0.chapterFrontCanvasGroup_.alpha = arg_13_0
			arg_10_0.chapterBehindCanvasGroup_.alpha = 1 - arg_13_0
		end))
		arg_10_0.leanTweenHandler_:setOnComplete(System.Action(function()
			LeanTween.cancel(arg_10_0.chapterFrontImage_.gameObject)
			arg_10_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

			arg_10_0.leanTweenHandler_ = nil
		end))
	end
end

function var_0_0.PointerUpFun(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2.dragging then
		return
	end

	local var_15_0 = arg_15_0.selectChapterClientID_
	local var_15_1 = BattleFieldData:GetCacheChapter(var_15_0)
	local var_15_2, var_15_3 = ChapterTools.IsFinishPreChapter(var_15_1)

	if not var_15_2 then
		ShowTips(ChapterTools.GetChapterLockText(var_15_1, var_15_3))

		return
	end

	ChapterTools.GotoChapterSection(var_15_1)
end

function var_0_0.BeginToggleDragFun(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:StopMoveTimer()
	arg_16_0.scrollView_:OnBeginDrag(arg_16_2)
end

function var_0_0.RemoveListeners(arg_17_0)
	arg_17_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_17_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_17_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_17_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	arg_17_0.toggleEventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
end

function var_0_0.SwitchImageOver(arg_18_0)
	arg_18_0.chapterBehindImage_, arg_18_0.chapterFrontImage_ = arg_18_0.chapterFrontImage_, arg_18_0.chapterBehindImage_
	arg_18_0.chapterBehindCanvasGroup_, arg_18_0.chapterFrontCanvasGroup_ = arg_18_0.chapterFrontCanvasGroup_, arg_18_0.chapterBehindCanvasGroup_
end

function var_0_0.AutoSwitchImage(arg_19_0)
	local var_19_0 = arg_19_0.selectChapterClientID_
	local var_19_1 = ChapterClientCfg[var_19_0]
	local var_19_2 = SpritePathCfg.ChapterPaint.path .. var_19_1.chapter_paint

	SetSpriteWithoutAtlasAsync(arg_19_0.chapterBehindImage_, var_19_2)

	local var_19_3 = var_0_0.SWITCH_STAGE_TIME

	arg_19_0.leanTweenHandler_ = LeanTween.value(arg_19_0.chapterFrontImage_.gameObject, arg_19_0.chapterFrontCanvasGroup_.alpha, 0, var_19_3)

	arg_19_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
		arg_19_0.chapterFrontCanvasGroup_.alpha = arg_20_0
		arg_19_0.chapterBehindCanvasGroup_.alpha = 1 - arg_20_0
	end))
	arg_19_0.leanTweenHandler_:setOnComplete(System.Action(function()
		arg_19_0:SwitchImageOver()
		LeanTween.cancel(arg_19_0.chapterFrontImage_.gameObject)
		arg_19_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		arg_19_0.leanTweenHandler_ = nil
	end))
end

function var_0_0.RefreshData(arg_22_0)
	return
end

function var_0_0.InitImage(arg_23_0)
	local var_23_0 = ChapterClientCfg[arg_23_0.selectChapterClientID_]
	local var_23_1 = SpritePathCfg.ChapterPaint.path .. var_23_0.chapter_paint

	SetSpriteWithoutAtlasAsync(arg_23_0.chapterBehindImage_, var_23_1)
	SetSpriteWithoutAtlasAsync(arg_23_0.chapterFrontImage_, var_23_1)
end

function var_0_0.RefreshUI(arg_24_0)
	return
end

function var_0_0.AddMoveTimer(arg_25_0, arg_25_1)
	arg_25_0:StopMoveTimer()

	arg_25_0.moveTimer_ = FrameTimer.New(function()
		local var_26_0 = arg_25_0.contentTf_.rect.width / 2
		local var_26_1 = arg_25_0.scrollTf_.rect.width / 2
		local var_26_2 = arg_25_0.contentTf_.anchoredPosition
		local var_26_3 = arg_25_1:GetLocalPosition().x * -1

		if var_26_1 >= var_26_0 + var_26_3 then
			var_26_3 = var_26_1 - var_26_0
		elseif var_26_1 >= var_26_0 - var_26_3 then
			var_26_3 = var_26_0 - var_26_1
		end

		local var_26_4 = 3 * math.pow(arg_25_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_25_0.tempVector2_.x = var_26_3
		arg_25_0.tempVector2_.y = var_26_2.y
		arg_25_0.contentTf_.anchoredPosition = Vector2.Lerp(var_26_2, arg_25_0.tempVector2_, var_26_4)

		if math.abs(var_26_2.x - var_26_3) <= 1 then
			arg_25_0.contentTf_.anchoredPosition = arg_25_0.tempVector2_

			arg_25_0:StopMoveTimer()
		end
	end, 1, -1)

	arg_25_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_27_0)
	if arg_27_0.moveTimer_ then
		arg_27_0.moveTimer_:Stop()

		arg_27_0.moveTimer_ = nil
	end
end

function var_0_0.StopLeanTween(arg_28_0)
	if arg_28_0.leanTweenHandler_ then
		LeanTween.cancel(arg_28_0.chapterFrontImage_.gameObject)
		arg_28_0.leanTweenHandler_:callOnCompletes()
	end
end

function var_0_0.StopAllTimer(arg_29_0)
	arg_29_0:StopMoveTimer()
end

return var_0_0
