local var_0_0 = class("PuzzleMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/Puzzle/VolumePuzzleMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.onSenceLoadedHandler_ = handler(arg_3_0, arg_3_0.OnPuzzleSceneLoaded)
	arg_3_0.puzzleGameEnterHandler_ = handler(arg_3_0, arg_3_0.OnPuzzleGameEnter)
	arg_3_0.puzzleGameExitHandler_ = handler(arg_3_0, arg_3_0.OnPuzzleGameExit)
	arg_3_0.puzzleAnimStartHandler_ = handler(arg_3_0, arg_3_0.OnAnimStart)
	arg_3_0.puzzleAnimEndHandler_ = handler(arg_3_0, arg_3_0.OnAnimEnd)
	arg_3_0.clickSwitchItemHandler_ = handler(arg_3_0, arg_3_0.OnClickSwitchItem)

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.gameStartController_ = ControllerUtil.GetController(arg_3_0.transform_, "gameStart")
	arg_3_0.switchItemList_ = {}

	local var_3_0 = arg_3_0.contentTrans_.childCount
	local var_3_1

	for iter_3_0 = 1, var_3_0 do
		local var_3_2 = arg_3_0.contentTrans_:GetChild(iter_3_0 - 1).gameObject

		arg_3_0.switchItemList_[iter_3_0] = PuzzleSelectItem.New(var_3_2)
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_PUZZLE_DESCRIPE")
	manager.notify:RegistListener(PUZZLE_GAME_ENTER, arg_6_0.puzzleGameEnterHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_EXIT, arg_6_0.puzzleGameExitHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_ANIM_START, arg_6_0.puzzleAnimStartHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_ANIM_END, arg_6_0.puzzleAnimEndHandler_)
	arg_6_0.gameStartController_:SetSelectedState("false")
	arg_6_0:LoadPuzzleScene()

	arg_6_0.activityID_ = arg_6_0.params_.activityID
	arg_6_0.stopTime_ = ActivityData:GetActivityData(arg_6_0.activityID_).stopTime

	local var_6_0 = arg_6_0.contentTrans_.localPosition

	var_6_0.x = PuzzleData:GetLastContentPosX(arg_6_0.activityID_) or var_6_0.x
	arg_6_0.contentTrans_.localPosition = var_6_0
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0.playingAnimCount_ = 0

	arg_7_0:RefreshUI()
	arg_7_0:AddTimer()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(PUZZLE_GAME_ENTER, arg_8_0.puzzleGameEnterHandler_)
	manager.notify:RemoveListener(PUZZLE_GAME_EXIT, arg_8_0.puzzleGameExitHandler_)
	manager.notify:RemoveListener(PUZZLE_GAME_ANIM_START, arg_8_0.puzzleAnimStartHandler_)
	manager.notify:RemoveListener(PUZZLE_GAME_ANIM_END, arg_8_0.puzzleAnimEndHandler_)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.switchItemList_) do
		iter_8_1:OnExit()
	end

	arg_8_0:UnLoadPuzzleScene()
	arg_8_0:StopTimer()
	PuzzleData:SetLastContentPosX(arg_8_0.activityID_, arg_8_0.contentTrans_.localPosition.x)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.onSenceLoadedHandler_ = nil
	arg_9_0.puzzleGameEnterHandler_ = nil
	arg_9_0.puzzleGameExitHandler_ = nil
	arg_9_0.puzzleAnimStartHandler_ = nil
	arg_9_0.puzzleAnimEndHandler_ = nil
	arg_9_0.clickSwitchItemHandler_ = nil

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.switchItemList_) do
		iter_9_1:Dispose()
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.OnPuzzleGameEnter(arg_10_0)
	arg_10_0.startAnim_:Play("VolumePuzzleMain_exit", -1, 0)
	arg_10_0:StopTimer()
end

function var_0_0.OnPuzzleGameExit(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.switchItemList_) do
		iter_11_1:Reset()
	end

	arg_11_0.gameStartController_:SetSelectedState("false")
	arg_11_0.startAnim_:Play("VolumePuzzleMain_recover", -1, 0)
	PuzzleTool:RecoverBg()
end

function var_0_0.OnAnimStart(arg_12_0)
	arg_12_0.playingAnimCount_ = arg_12_0.playingAnimCount_ + 1

	SetActive(arg_12_0.fullMask_, true)
end

function var_0_0.OnAnimEnd(arg_13_0)
	PuzzleTool:SetPuzzleGo(true)

	local var_13_0 = PuzzleData:IsCompleted(arg_13_0.selectActivityID_)

	PuzzleTool:RefreshPuzzlePanel(var_13_0)

	arg_13_0.playingAnimCount_ = arg_13_0.playingAnimCount_ - 1

	if arg_13_0.playingAnimCount_ == 0 then
		arg_13_0.gameStartController_:SetSelectedState("true")
		SetActive(arg_13_0.fullMask_, false)
	end
end

function var_0_0.LoadPuzzleScene(arg_14_0)
	manager.ui:SetMainCamera("puzzle")

	manager.ui.mainCameraCom_.orthographic = true

	PuzzleTool:LoadPuzzleLevel(arg_14_0.onSenceLoadedHandler_)
end

function var_0_0.UnLoadPuzzleScene(arg_15_0)
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	PuzzleTool:UnLoadPuzzleLevel()
end

function var_0_0.RefreshUI(arg_16_0)
	arg_16_0.subActivityList_ = ActivityCfg[arg_16_0.activityID_].sub_activity_list

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.switchItemList_) do
		iter_16_1:SetData(arg_16_0.activityID_, arg_16_0.subActivityList_[iter_16_0], iter_16_0)
		iter_16_1:SetClickCallBack(arg_16_0.clickSwitchItemHandler_)
		iter_16_1:Reset()
	end

	arg_16_0:RefreshDesc()
	SetActive(arg_16_0.fullMask_, false)
end

function var_0_0.RefreshDesc(arg_17_0)
	arg_17_0.descText_.text = GetTips("ACTIVITY_PUZZLE_CONTENT")
end

function var_0_0.AddTimer(arg_18_0)
	if manager.time:GetServerTime() >= arg_18_0.stopTime_ then
		arg_18_0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_18_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_18_0.stopTime_)

	arg_18_0:StopTimer()

	arg_18_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_18_0.stopTime_ then
			arg_18_0:StopTimer()

			arg_18_0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		for iter_19_0, iter_19_1 in ipairs(arg_18_0.switchItemList_) do
			iter_19_1:RefreshLock()
		end

		arg_18_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_18_0.stopTime_)
	end, 1, -1)

	arg_18_0.timer_:Start()
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

function var_0_0.OnPuzzleSceneLoaded(arg_21_0)
	return
end

function var_0_0.OnClickSwitchItem(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.selectActivityID_ = arg_22_2

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.switchItemList_) do
		iter_22_1:OnClickItem(arg_22_1)
	end
end

return var_0_0
