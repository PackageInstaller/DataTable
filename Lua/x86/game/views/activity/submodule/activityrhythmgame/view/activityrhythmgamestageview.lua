local var_0_0 = class("ActivityRhythmGameStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MuiscUI/SummerUI_3_4_MuiscUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitOwnData()
	arg_3_0:BindCfgUI()

	arg_3_0.scrollView_ = StageScrollView.New(arg_3_0.scrollViewGo_)

	arg_3_0.scrollView_:RegistPointerUp(handler(arg_3_0, arg_3_0.TryCloseSectionView))
	arg_3_0.scrollView_:RegistBeginDrag(handler(arg_3_0, arg_3_0.TryCloseSectionView))
	arg_3_0:BindController()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitOwnData(arg_4_0)
	arg_4_0.activityID_ = -1
	arg_4_0.stageNodeList_ = {}
end

function var_0_0.BindController(arg_5_0)
	arg_5_0.stageController_ = arg_5_0.controllerEx_:GetController("stageState")
	arg_5_0.canswitchController_ = arg_5_0.controllerEx_:GetController("chapterNum")
	arg_5_0.chapterController_ = arg_5_0.switchControllerEx_:GetController("chapter")
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(nil, arg_6_0.taskBtn_, function()
		if arg_6_0:IsOpenSectionView() then
			JumpTools.Back()
		end

		JumpTools.OpenPageByJump("/summerChessBoardTask", {
			taskActivityID = ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_TASK
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.commandBtn_, function()
		if arg_6_0:IsOpenSectionView() then
			JumpTools.Back()
		end

		JumpTools.OpenPageByJump("/activityRhythmGameCommandView", {
			chapterID = ActivityRhythmGameData:GetCurPage(),
			activityID = arg_6_0.activityID_
		})
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.switchHeroBtn_, function()
		local var_9_0 = ActivityRhythmGameData:GetCurPage() == ActivityRhythmGameConst.Chapter_ID.ONE and ActivityRhythmGameConst.Chapter_ID.TWO or ActivityRhythmGameConst.Chapter_ID.ONE

		arg_6_0:SwtichChapter(var_9_0)
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_RHYTHM_DESCRIPE")

	if ActivityRhythmGameData:GetCanSwitchChapter() then
		arg_10_0.switchHeroBtn_.interactable = true
	else
		arg_10_0.switchHeroBtn_.interactable = false
	end

	arg_10_0:ChangeStageController(0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.stageNodeList_) do
		if iter_10_1 and iter_10_1.ChangeSelectController then
			iter_10_1:ChangeSelectController(0)
		end
	end

	arg_10_0.curSelectStageID_ = nil

	arg_10_0:RefreshSelectStage()
	arg_10_0.scrollView_:Recover()
end

function var_0_0.OnBehind(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_12_0)
	if not arg_12_0.params_.isBack or not not arg_12_0.params_.activityID then
		arg_12_0.activityID_ = arg_12_0.params_.activityID
	end

	if not ActivityData:GetActivityIsOpen(arg_12_0.activityID_) then
		ShowTips("TIME_OVER")

		return
	end

	arg_12_0:CheckPlayStory()
end

function var_0_0.CheckPlayStory(arg_13_0)
	local var_13_0 = false
	local var_13_1 = GameSetting.activity_rhythm_game_story.value
	local var_13_2 = -1

	ActivityRhythmGameData:InitUnlockStageData()
	ActivityRhythmGameData:InitUnlockCommandData()

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if IsConditionAchieved(iter_13_1[1]) then
			var_13_2 = iter_13_1[2]

			if var_13_2 ~= -1 and not ActivityRhythmGameData:IsStroyPlayed(var_13_2) then
				var_13_0 = true

				break
			end
		end
	end

	if var_13_0 and var_13_2 then
		gameContext:Go("/blank")
		manager.story:StartStoryById(var_13_2, function()
			ActivityRhythmGameAction.PlayStory(ActivityConst.SUMMER_CHESS_BOARD_RHYTHM_MAIN, var_13_2, function()
				arg_13_0:EnterOther()
				gameContext:Back()
			end)
		end)
	else
		arg_13_0:EnterOther()
	end
end

function var_0_0.EnterOther(arg_16_0)
	var_0_0.super.OnEnter(arg_16_0)
	arg_16_0:RefreshUI()
	arg_16_0:RefreshNodePos()
	arg_16_0:BindRedPoint()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.SUMMER_CHESS_BOARD_RHYTHM, 0, RedPointStyle.NORMAL)
end

function var_0_0.OnExit(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.stageNodeList_) do
		if iter_17_1 and iter_17_1.OnExit then
			iter_17_1:OnExit()
		end
	end

	arg_17_0.scrollView_:OnExit()
	arg_17_0:UnbindRedPoint()
	var_0_0.super.OnExit(arg_17_0)
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.stageNodeList_) do
		if iter_18_1 and iter_18_1.Dispose then
			iter_18_1:Dispose()
		end
	end

	if arg_18_0.firstTimer then
		arg_18_0.firstTimer:Stop()
		manager.ui:UIEventEnabledByUI(true, false)

		arg_18_0.firstTimer = nil
	end

	arg_18_0.scrollView_:Dispose()

	arg_18_0.scrollView_ = nil

	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.ChangeChapterController(arg_19_0, arg_19_1)
	arg_19_0.chapterController_:SetSelectedIndex(arg_19_1)
end

function var_0_0.ChangeStageController(arg_20_0, arg_20_1)
	arg_20_0.stageController_:SetSelectedIndex(arg_20_1)

	if arg_20_1 == 1 then
		arg_20_0.heroNodeCanvasGroup_.blocksRaycasts = false
	else
		arg_20_0.heroNodeCanvasGroup_.blocksRaycasts = true
	end
end

function var_0_0.ChangeCanSwitchController(arg_21_0, arg_21_1)
	arg_21_0.canswitchController_:SetSelectedIndex(arg_21_1)
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0:RefreshStageNode()
	arg_22_0:RefreshChapter()
end

function var_0_0.RefreshChapter(arg_23_0)
	if ActivityRhythmGameData:GetCanSwitchChapter() then
		SetActive(arg_23_0.switchHeroGo_, true)

		arg_23_0.switchHeroBtn_.interactable = true

		arg_23_0:ChangeCanSwitchController(1)
		arg_23_0:RefreshSwitchHeroEffect()
	else
		SetActive(arg_23_0.switchHeroGo_, false)

		arg_23_0.switchHeroBtn_.interactable = false

		arg_23_0:ChangeCanSwitchController(0)
	end

	if ActivityRhythmGameData:GetCurPage() == ActivityRhythmGameConst.Chapter_ID.ONE then
		arg_23_0.heroAnimator_:Play("RoleChange02")
	else
		arg_23_0.heroAnimator_:Play("RoleChange01")
	end

	arg_23_0:ChangeChapterController(ActivityRhythmGameData:GetCurPage() == ActivityRhythmGameConst.Chapter_ID.ONE and 0 or 1)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.stageNodeList_) do
		if iter_23_1 and iter_23_1.ChangeSelectController then
			iter_23_1:ChangeStageController(ActivityRhythmGameData:GetCurPage() == ActivityRhythmGameConst.Chapter_ID.ONE and 0 or 1)
		end
	end

	arg_23_0.stageAnimator_:Play("Stage")
end

function var_0_0.RefreshStageNode(arg_24_0)
	local var_24_0 = ActivityRhythmGameData:GetShowCfgIDsByChapterID(ActivityRhythmGameData:GetCurPage())

	for iter_24_0 = #var_24_0 + 1, #arg_24_0.stageNodeList_ do
		arg_24_0.stageNodeList_[iter_24_0]:Show(false)
	end

	arg_24_0.stageContentTrs_.sizeDelta = Vector2(892, arg_24_0.stageContentTrs_.rect.height)

	for iter_24_1 = 1, #var_24_0 do
		arg_24_0.stageContentTrs_.sizeDelta = Vector2(arg_24_0.stageContentTrs_.rect.width + 210, arg_24_0.stageContentTrs_.rect.height)

		local var_24_1 = arg_24_0.stageNodeList_[iter_24_1]

		if var_24_1 == nil then
			var_24_1 = ActivityRhythmGameStageItem.New(arg_24_0.stageItemGo_, arg_24_0.stageContentGo_)

			var_24_1:SetAddPos(ActivityRhythmGameTools.GetAddPos(iter_24_1))

			arg_24_0.stageNodeList_[iter_24_1] = var_24_1

			var_24_1:SetClickHandler(function(arg_25_0, arg_25_1, arg_25_2)
				arg_24_0:OnClickSectionItem(arg_25_0, arg_25_1, arg_25_2)
			end)
		else
			var_24_1:Show(true)
		end

		var_24_1:SetData(var_24_0[iter_24_1])

		if iter_24_1 == 1 then
			if #var_24_0 == 1 then
				var_24_1:SetLine(5)
			else
				var_24_1:SetLine(0)
			end
		elseif iter_24_1 == #var_24_0 then
			var_24_1:SetLine(iter_24_1 % 2 == 0 and 3 or 4)
		else
			var_24_1:SetLine(iter_24_1 % 2 == 0 and 2 or 1)
		end

		var_24_1:RefreshUI()
	end
end

function var_0_0.RefreshNodePos(arg_26_0)
	if arg_26_0.params_.stageID then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0.stageNodeList_) do
			if iter_26_1 and iter_26_1.stageID_ and iter_26_1.stageID_ == arg_26_0.params_.stageID then
				local var_26_0 = iter_26_1:GetPosition()

				arg_26_0:MoveStageContent(var_26_0)
			end
		end
	end
end

function var_0_0.RefreshSwitchHeroEffect(arg_27_0)
	if not getData("activity_rhythm_game_main", "switchHeroEffect") then
		SetActive(arg_27_0.switchBtnEffect_, true)

		if arg_27_0.firstTimer then
			arg_27_0.firstTimer:Stop()
			manager.ui:UIEventEnabledByUI(true, false)

			arg_27_0.firstTimer = nil
		end

		arg_27_0.firstTimer = Timer.New(function()
			manager.ui:UIEventEnabledByUI(false, true)

			local var_28_0 = arg_27_0.switchBtnAni_:GetCurrentAnimatorStateInfo(0)

			if var_28_0:IsName("eff_unlock") and var_28_0.normalizedTime >= 1 and arg_27_0.firstTimer then
				arg_27_0.firstTimer:Stop()

				arg_27_0.firstTimer = nil

				saveData("activity_rhythm_game_main", "switchHeroEffect", true)
				arg_27_0:SwtichChapter(ActivityRhythmGameConst.Chapter_ID.TWO)
				manager.ui:UIEventEnabledByUI(true, false)
			end
		end, 0.033, -1)

		arg_27_0.firstTimer:Start()
	else
		SetActive(arg_27_0.switchBtnEffect_, false)
	end
end

function var_0_0.BindRedPoint(arg_29_0)
	manager.redPoint:bindUIandKey(arg_29_0.taskBtn_.transform, RedPointConst.ACTIVITY_RHYTHM_GIFT)
end

function var_0_0.UnbindRedPoint(arg_30_0)
	manager.redPoint:unbindUIandKey(arg_30_0.taskBtn_.transform)
end

function var_0_0.IsOpenSectionView(arg_31_0)
	return arg_31_0:IsOpenRoute("activityRhythmGameStageInfoView")
end

function var_0_0.TryCloseSectionView(arg_32_0)
	if arg_32_0:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function var_0_0.OnClickSectionItem(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_0.curSelectStageID_ == arg_33_1 then
		return
	end

	arg_33_0.curSelectStageID_ = arg_33_1

	arg_33_0:RefreshSelectStage(arg_33_0.curSelectStageID_)
	JumpTools.OpenPageByJump("activityRhythmGameStageInfoView", {
		activityID = arg_33_0.activityID_,
		stageID = arg_33_2,
		cfgID = arg_33_1
	})

	arg_33_0.switchHeroBtn_.interactable = false

	arg_33_0:ChangeStageController(1)
	arg_33_0:MoveStageContent(arg_33_3)
end

function var_0_0.MoveStageContent(arg_34_0, arg_34_1)
	local var_34_0 = UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, arg_34_1).x - Screen.width / 2

	arg_34_0.scrollView_:MoveContentScreenPosXDelta(var_34_0)
end

function var_0_0.RefreshSelectStage(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.stageNodeList_) do
		iter_35_1:RefreshSelect(arg_35_1)
	end
end

function var_0_0.SwtichChapter(arg_36_0, arg_36_1)
	if arg_36_0:IsOpenSectionView() then
		JumpTools.Back()
	end

	if arg_36_1 == ActivityRhythmGameData:GetCurPage() then
		return
	end

	ActivityRhythmGameData:SetCurPage(arg_36_1)
	arg_36_0:RefreshUI()
end

return var_0_0
