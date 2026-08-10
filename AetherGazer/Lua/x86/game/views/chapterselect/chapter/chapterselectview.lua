ChapterSelectBaseView = import("..ChapterSelectBaseView")

local var_0_0 = class("ChapterSelectView", ChapterSelectBaseView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationMainUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.changeSelectChapterHandler_ = handler(arg_2_0, arg_2_0.ChangeSelectChapterID)
	arg_2_0.hardLevelView_ = HardLevelChapterView.New(arg_2_0.selectDifficultBtn_)
	arg_2_0.chapterToggleItemList_ = {}
	arg_2_0.groupToggleItemList_ = {}
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0.hardLevelView_:OnEnter()
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, arg_3_0.changeSelectChapterHandler_)
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, arg_4_0.changeSelectChapterHandler_)
	arg_4_0.hardLevelView_:OnExit()
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.changeSelectChapterHandler_ = nil

	arg_5_0.hardLevelView_:Dispose()

	arg_5_0.hardLevelView_ = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.groupToggleItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.groupToggleItemList_ = nil

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.chapterToggleItemList_) do
		iter_5_3:Dispose()
	end

	arg_5_0.chapterToggleItemList_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.EndDragFun(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2.position.x - arg_6_2.pressPosition.x

	if ChapterTools.GetNeighborClientID(arg_6_0.selectChapterClientID_, var_6_0 < 0) == arg_6_0.selectChapterClientID_ then
		return
	end

	if math.abs(var_6_0) > var_0_0.MIN_DRAG_LENGTH then
		arg_6_0.selectChapterClientID_ = arg_6_0.nextChapterClientID_
		arg_6_0.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, arg_6_0.selectChapterClientID_)
		arg_6_0:RefreshData()

		if math.abs(var_6_0) > var_0_0.MAX_DRAG_LENGTH then
			arg_6_0:RefreshChapterUI()
			arg_6_0:SwitchImageOver()
		else
			local var_6_1 = (var_0_0.MAX_DRAG_LENGTH - math.abs(var_6_0)) / var_0_0.MAX_DRAG_LENGTH * var_0_0.SWITCH_STAGE_TIME

			arg_6_0.leanTweenHandler_ = LeanTween.value(arg_6_0.chapterFrontImage_.gameObject, arg_6_0.chapterFrontCanvasGroup_.alpha, 0, var_6_1)

			arg_6_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
				arg_6_0.chapterFrontCanvasGroup_.alpha = arg_7_0
				arg_6_0.chapterBehindCanvasGroup_.alpha = 1 - arg_7_0
			end))
			arg_6_0.leanTweenHandler_:setOnComplete(System.Action(function()
				arg_6_0:RefreshChapterUI()
				arg_6_0:SwitchImageOver()
				LeanTween.cancel(arg_6_0.chapterFrontImage_.gameObject)
				arg_6_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

				arg_6_0.leanTweenHandler_ = nil
			end))
		end
	else
		local var_6_2 = (1 - (var_0_0.MIN_DRAG_LENGTH - math.abs(var_6_0)) / var_0_0.MIN_DRAG_LENGTH) * 0.8

		arg_6_0.leanTweenHandler_ = LeanTween.value(arg_6_0.chapterFrontImage_.gameObject, arg_6_0.chapterFrontCanvasGroup_.alpha, 1, var_6_2)

		arg_6_0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
			arg_6_0.chapterFrontCanvasGroup_.alpha = arg_9_0
			arg_6_0.chapterBehindCanvasGroup_.alpha = 1 - arg_9_0
		end))
		arg_6_0.leanTweenHandler_:setOnComplete(System.Action(function()
			LeanTween.cancel(arg_6_0.chapterFrontImage_.gameObject)
			arg_6_0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

			arg_6_0.leanTweenHandler_ = nil
		end))
	end
end

function var_0_0.PointerUpFun(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2.dragging then
		return
	end

	local var_11_0 = arg_11_0.selectChapterClientID_
	local var_11_1 = BattleFieldData:GetCacheChapter(var_11_0)
	local var_11_2, var_11_3 = ChapterTools.IsFinishPreChapter(var_11_1)

	if not var_11_2 then
		ShowTips(ChapterTools.GetChapterLockText(var_11_1, var_11_3))

		return
	end

	ChapterTools.GotoChapterSection(var_11_1)
end

function var_0_0.RefreshData(arg_12_0)
	arg_12_0.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	arg_12_0.groupDataList_ = ChapterTools.GetChapterGroupList(arg_12_0.selectChapterClientID_)
	arg_12_0.hardLevel_ = ChapterClientCfg[arg_12_0.selectChapterClientID_].difficulty
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshChapterUI()
	arg_13_0:AutoSwitchImage()
	arg_13_0:RefreshSelectDifficult()
end

function var_0_0.RefreshChapterUI(arg_14_0)
	arg_14_0.chapterSelectTitleView_:OnEnter(arg_14_0.selectChapterClientID_)
	arg_14_0:RefreshGroupToggle()
	arg_14_0:AddActivityTimer()
	arg_14_0:RefreshActivity()
	arg_14_0:RefreshLock()
end

function var_0_0.RefreshGroupToggle(arg_15_0)
	local var_15_0 = 0
	local var_15_1 = 0
	local var_15_2

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.groupDataList_) do
		if iter_15_1[1] == 1 then
			var_15_0 = var_15_0 + 1

			if arg_15_0.groupToggleItemList_[var_15_0] == nil then
				arg_15_0.groupToggleItemList_[var_15_0] = ChapterSelectGroupToggleItem.New(arg_15_0.groupToggleItem_, arg_15_0.toggleItemParent_)
			end

			arg_15_0.groupToggleItemList_[var_15_0]:SetData(iter_15_1[2])
		else
			var_15_1 = var_15_1 + 1

			if arg_15_0.chapterToggleItemList_[var_15_1] == nil then
				arg_15_0.chapterToggleItemList_[var_15_1] = ChapterSelectChapterToggleItem.New(arg_15_0.chapterToggleItem_, arg_15_0.toggleItemParent_)
			end

			local var_15_3 = arg_15_0.selectChapterClientID_ == iter_15_1[2]

			arg_15_0.chapterToggleItemList_[var_15_1]:SetData(iter_15_1[2], var_15_3)

			if var_15_3 then
				var_15_2 = arg_15_0.chapterToggleItemList_[var_15_1]
			end
		end
	end

	for iter_15_2 = var_15_0 + 1, #arg_15_0.groupToggleItemList_ do
		arg_15_0.groupToggleItemList_[iter_15_2]:Show(false)
	end

	for iter_15_3 = var_15_1 + 1, #arg_15_0.chapterToggleItemList_ do
		arg_15_0.chapterToggleItemList_[iter_15_3]:Show(false)
	end

	if var_15_2 then
		arg_15_0:AddMoveTimer(var_15_2)
	end
end

function var_0_0.RefreshActivity(arg_16_0)
	local var_16_0 = arg_16_0.selectChapterClientID_
	local var_16_1 = ChapterClientCfg[var_16_0].chapter_list[1]
	local var_16_2 = ChapterCfg[var_16_1]

	arg_16_0.activityController_:SetSelectedState(tostring(ActivityData:GetActivityIsOpen(var_16_2.activity_id)))
end

function var_0_0.RefreshLock(arg_17_0)
	return
end

function var_0_0.RefreshSelectDifficult(arg_18_0)
	arg_18_0.hardLevelView_:SetData(arg_18_0.hardLevel_)
end

function var_0_0.ChangeSelectChapterID(arg_19_0)
	arg_19_0:StopLeanTween()
	arg_19_0:RefreshData()
	arg_19_0:RefreshUI()
end

function var_0_0.StopAllTimer(arg_20_0)
	var_0_0.super.StopAllTimer(arg_20_0)
	arg_20_0:RemoveActivityTimer()
end

function var_0_0.AddActivityTimer(arg_21_0)
	arg_21_0:RemoveActivityTimer()

	local var_21_0 = arg_21_0.selectChapterClientID_
	local var_21_1 = ChapterClientCfg[var_21_0].chapter_list[1]
	local var_21_2 = ChapterCfg[var_21_1].activity_id

	if var_21_2 == 0 then
		return
	end

	local var_21_3 = ActivityData:GetActivityData(var_21_2):IsActivitying()

	arg_21_0.activityTimer_ = Timer.New(function()
		local var_22_0 = ActivityData:GetActivityData(var_21_2):IsActivitying()

		if var_22_0 ~= var_21_3 then
			var_21_3 = var_22_0
			arg_21_0.isLock_ = not ChapterTools.IsFinishPreChapter(var_21_1)

			arg_21_0:RefreshLock()
			arg_21_0:RefreshActivity()
		end
	end, 1, -1)

	arg_21_0.activityTimer_:Start()
end

function var_0_0.RemoveActivityTimer(arg_23_0)
	if arg_23_0.activityTimer_ then
		arg_23_0.activityTimer_:Stop()

		arg_23_0.activityTimer_ = nil
	end
end

return var_0_0
