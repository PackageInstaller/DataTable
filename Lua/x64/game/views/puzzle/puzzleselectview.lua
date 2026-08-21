local var_0_0 = class("PuzzleSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/Puzzle/VolumePuzzleGamePlayUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rewardItemList_ = {}
	arg_3_0.onItemSelectHandler_ = handler(arg_3_0, arg_3_0.OnItemSelected)
	arg_3_0.onCompleteHandler_ = handler(arg_3_0, arg_3_0.CompletedPuzzle)
	arg_3_0.onMoveHandler_ = handler(arg_3_0, arg_3_0.OnMovePuzzle)
	arg_3_0.operationType_ = PuzzleAction.OPERATION_TYPE

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.completedController_ = ControllerUtil.GetController(arg_4_0.transform_, "complete")
	arg_4_0.resetBtnController_ = ControllerUtil.GetController(arg_4_0.transform_, "resetBtn")
	arg_4_0.stepCountController_ = ControllerUtil.GetController(arg_4_0.transform_, "stepCount")
	arg_4_0.lastRecordController_ = ControllerUtil.GetController(arg_4_0.transform_, "lastRecord")
	arg_4_0.retryController_ = ControllerUtil.GetController(arg_4_0.transform_, "retry")
	arg_4_0.rewardState_ = ControllerUtil.GetController(arg_4_0.transform_, "reward")
	arg_4_0.previewController_ = ControllerUtil.GetController(arg_4_0.transform_, "preview")
end

function var_0_0.OnEnter(arg_5_0)
	manager.notify:Invoke(PUZZLE_GAME_ENTER)

	arg_5_0.canMove_ = true
	arg_5_0.retry_ = false
	arg_5_0.activityID_ = arg_5_0.params_.activityID
	arg_5_0.isCompleted_ = PuzzleData:IsCompleted(arg_5_0.activityID_)

	arg_5_0:InitializePuzzle()
	arg_5_0:RefreshUI()

	arg_5_0.videoRedPointStr_ = string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, arg_5_0.params_.mainActivityID, arg_5_0.params_.activityID)

	manager.redPoint:bindUIandKey(arg_5_0.watchBtnTrans_, arg_5_0.videoRedPointStr_)
end

function var_0_0.OnExit(arg_6_0)
	manager.notify:Invoke(PUZZLE_GAME_EXIT)

	if arg_6_0.timer_ ~= nil then
		arg_6_0.timer_:Stop()

		arg_6_0.timer_ = nil
	end

	PuzzleTool:SetPuzzleGo(false)
	PuzzleTool:SetPuzzleAnswerPanel(false)
	SetActive(arg_6_0.previewPanel_, false)
	manager.redPoint:unbindUIandKey(arg_6_0.watchBtnTrans_, arg_6_0.videoRedPointStr_)
end

function var_0_0.OnEnterReTry(arg_7_0)
	arg_7_0.retryController_:SetSelectedState("uncompleted")
	arg_7_0.completedController_:SetSelectedState("retry")
	arg_7_0.resetBtnController_:SetSelectedState("reset")
	arg_7_0.previewController_:SetSelectedState("true")

	arg_7_0.retry_ = true

	manager.windowBar:HideBar()
	arg_7_0:ResetLevel()
	arg_7_0:RefreshUI()
	PuzzleTool:RefreshPuzzlePanel(false)

	local var_7_0 = PuzzleData:GetMinStepCount(arg_7_0.activityID_)

	arg_7_0:RefreshRecord(false, var_7_0)
end

function var_0_0.OnExitRetry(arg_8_0)
	arg_8_0.retryController_:SetSelectedState("none")

	arg_8_0.retry_ = false

	SetActive(arg_8_0.newRecordFlag_, false)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_PUZZLE_DESCRIPE")
	arg_8_0:RefreshUI()
	PuzzleTool:RefreshPuzzlePanel(arg_8_0.isCompleted_)
end

function var_0_0.InitializePuzzle(arg_9_0)
	arg_9_0.curStateList_ = PuzzleData:GetStateList(arg_9_0.activityID_)
	arg_9_0.puzzleSize_ = ActivityPuzzleCfg[arg_9_0.activityID_].type
	arg_9_0.answerList_ = ActivityPuzzleCfg[arg_9_0.activityID_].correct_array
	arg_9_0.maxStep_ = ActivityPuzzleCfg[arg_9_0.activityID_].max_step
	arg_9_0.emptyFlag_ = ActivityPuzzleCfg[arg_9_0.activityID_].block
	arg_9_0.pieceList_ = PuzzleTool:InitPuzzlePiece(arg_9_0.activityID_, arg_9_0.curStateList_, arg_9_0.onItemSelectHandler_)

	arg_9_0:RefreshPreviewImg()
end

function var_0_0.RefreshPreviewImg(arg_10_0)
	local var_10_0 = ActivityPuzzleCfg[arg_10_0.activityID_].picture_id
	local var_10_1 = ActivityPuzzleCfg[arg_10_0.activityID_].path

	arg_10_0.previewBigImg_.sprite = getSprite(var_10_1, var_10_0)
	arg_10_0.previewSmallImg_.sprite = getSprite(var_10_1, var_10_0)

	local var_10_2 = PuzzleTool:GetPuzzlePanelWidth()

	arg_10_0.previewBigTrans_.sizeDelta = Vector2(var_10_2, var_10_2)

	local var_10_3 = PuzzleTool:GetPanelTrans()
	local var_10_4 = manager.ui.mainCameraCom_
	local var_10_5 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_10_6 = var_10_4:WorldToScreenPoint(var_10_3.position)
	local var_10_7 = Vector2(1, 1)
	local var_10_8, var_10_9 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_10_0.previewPanel_.transform, var_10_6, var_10_5, var_10_7)

	arg_10_0.previewBigTrans_.localPosition = var_10_9
end

function var_0_0.ResetLevel(arg_11_0)
	PuzzleData:ResetData(arg_11_0.activityID_)

	arg_11_0.curStateList_ = PuzzleData:GetStateList(arg_11_0.activityID_)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.curStateList_) do
		if arg_11_0.pieceList_[iter_11_0] then
			arg_11_0.pieceList_[iter_11_0]:SetID(iter_11_1)
		end
	end
end

function var_0_0.RefreshUI(arg_12_0)
	if arg_12_0.retry_ == false then
		arg_12_0:RefreshReward(formatRewardCfgList(ActivityPuzzleCfg[arg_12_0.activityID_].reward_item_list))
		arg_12_0.completedController_:SetSelectedState(tostring(arg_12_0.isCompleted_))

		if not arg_12_0.isCompleted_ then
			arg_12_0.stepCountController_:SetSelectedState("cur")
			arg_12_0.resetBtnController_:SetSelectedState("reset")
			arg_12_0.previewController_:SetSelectedState("true")
		else
			arg_12_0.resetBtnController_:SetSelectedState("retry")
			arg_12_0.previewController_:SetSelectedState("false")

			if PuzzleData:GetMinStepCount(arg_12_0.activityID_) == 0 then
				arg_12_0.stepCountController_:SetSelectedState("none")
			else
				arg_12_0.stepCountController_:SetSelectedState("min")
			end

			PuzzleTool:RefreshAnswer(arg_12_0.activityID_)

			local var_12_0 = ActivityPuzzleCfg[arg_12_0.activityID_].story_id ~= 0

			SetActive(arg_12_0.playStoryBtnGo_, var_12_0)
		end

		arg_12_0:RefreshHelpBtn()
	else
		arg_12_0.stepCountController_:SetSelectedState("cur")
	end

	arg_12_0:RefreshStepCount()
end

function var_0_0.RefreshStepCount(arg_13_0)
	local var_13_0 = 0

	if not arg_13_0.isCompleted_ or arg_13_0.retry_ == true then
		local var_13_1 = PuzzleData:GetStepCount(arg_13_0.activityID_)

		arg_13_0.curStepCountText_.text = var_13_1
	else
		local var_13_2 = PuzzleData:GetMinStepCount(arg_13_0.activityID_)

		arg_13_0.minStepCountText_.text = var_13_2
	end
end

function var_0_0.RefreshRecord(arg_14_0, arg_14_1, arg_14_2)
	SetActive(arg_14_0.newRecordFlag_, arg_14_1)

	if arg_14_2 ~= 0 then
		arg_14_0.lastRecordController_:SetSelectedState("true")

		arg_14_0.lastRecordText_.text = arg_14_2
	else
		arg_14_0.lastRecordController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshHelpBtn(arg_15_0)
	local var_15_0 = PuzzleData:GetStepCount(arg_15_0.activityID_)

	if var_15_0 < arg_15_0.maxStep_ then
		arg_15_0.helpText_.text = string.format(GetTips("PUZZLE_HELP_REMAIN"), arg_15_0.maxStep_ - var_15_0)
		arg_15_0.helpBtn_.interactable = false
	else
		arg_15_0.helpText_.text = GetTips("PUZZLE_HELP")
		arg_15_0.helpBtn_.interactable = true
	end

	if var_15_0 == arg_15_0.maxStep_ then
		local var_15_1 = getData(string.format("Puzzle_%d", arg_15_0.activityID_), "canPlayHelpAnim")

		if var_15_1 == nil or var_15_1 == true then
			arg_15_0.helpAnim_:Play("VolumePuzzleGamePlayUI_help", -1, 0)
			saveData(string.format("Puzzle_%d", arg_15_0.activityID_), "canPlayHelpAnim", false)
			manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzlehelp", "")
		end
	end
end

function var_0_0.OnItemSelected(arg_16_0, arg_16_1)
	if not arg_16_0.canMove_ then
		return
	end

	local var_16_0 = arg_16_1
	local var_16_1 = var_16_0 - 1
	local var_16_2 = var_16_0 + 1
	local var_16_3 = var_16_0 - arg_16_0.puzzleSize_
	local var_16_4 = var_16_0 + arg_16_0.puzzleSize_

	if var_16_0 % arg_16_0.puzzleSize_ ~= 1 and arg_16_0.curStateList_[var_16_1] == arg_16_0.emptyFlag_ then
		arg_16_0:ExChangeItem(var_16_0, var_16_1, arg_16_1)
	elseif var_16_0 % arg_16_0.puzzleSize_ ~= 0 and arg_16_0.curStateList_[var_16_2] == arg_16_0.emptyFlag_ then
		arg_16_0:ExChangeItem(var_16_0, var_16_2, arg_16_1)
	elseif var_16_3 > 0 and arg_16_0.curStateList_[var_16_3] == arg_16_0.emptyFlag_ then
		arg_16_0:ExChangeItem(var_16_0, var_16_3, arg_16_1)
	elseif var_16_4 <= #arg_16_0.curStateList_ and arg_16_0.curStateList_[var_16_4] == arg_16_0.emptyFlag_ then
		arg_16_0:ExChangeItem(var_16_0, var_16_4, arg_16_1)
	end
end

function var_0_0.ExChangeItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0.pieceList_[arg_17_1].ID_

	arg_17_0.pieceList_[arg_17_1]:SetID(arg_17_0.pieceList_[arg_17_2].ID_)

	arg_17_0.curStateList_[arg_17_1] = arg_17_0.pieceList_[arg_17_2].ID_

	arg_17_0.pieceList_[arg_17_2]:SetID(var_17_0)

	arg_17_0.curStateList_[arg_17_2] = var_17_0

	PuzzleData:SetPuzzleState(arg_17_0.activityID_, arg_17_1, arg_17_0.curStateList_[arg_17_1], arg_17_2, arg_17_0.curStateList_[arg_17_2])
	arg_17_0:RefreshHelpBtn()

	local var_17_1 = arg_17_0:CheckAnswer()

	arg_17_0:RefreshStepCount(var_17_1)

	if not var_17_1 then
		arg_17_0.canMove_ = false

		PuzzleAction.Operate(arg_17_0.activityID_, arg_17_0.operationType_.move, arg_17_0.onMoveHandler_, arg_17_3)
	else
		arg_17_0.canMove_ = false

		PuzzleAction.Operate(arg_17_0.activityID_, arg_17_0.operationType_.complete, arg_17_0.onCompleteHandler_, arg_17_3)
	end

	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_slide", "")
end

function var_0_0.OnMovePuzzle(arg_18_0)
	arg_18_0.canMove_ = true
end

function var_0_0.CheckAnswer(arg_19_0)
	local var_19_0 = true

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.answerList_) do
		if arg_19_0.answerList_[iter_19_0] ~= arg_19_0.curStateList_[iter_19_0] then
			var_19_0 = false

			break
		end
	end

	return var_19_0
end

function var_0_0.CompletedPuzzle(arg_20_0, arg_20_1)
	arg_20_0.canMove_ = true

	PuzzleData:SetCompletedActivityList(arg_20_0.activityID_)

	arg_20_0.isCompleted_ = true

	PuzzleTool:RefreshPuzzlePanel(arg_20_0.isCompleted_)
	PuzzleTool:RefreshAnswer(arg_20_0.activityID_)

	if not arg_20_1 then
		local var_20_0, var_20_1 = PuzzleData:SetMinStepCount(arg_20_0.activityID_)

		if arg_20_0.retry_ == true then
			arg_20_0.retryController_:SetSelectedState("completed")
			arg_20_0.resetBtnController_:SetSelectedState("none")
			arg_20_0:RefreshRecord(var_20_0, var_20_1)
		end
	end

	arg_20_0.previewController_:SetSelectedState("false")
	arg_20_0:RefreshUI()
	arg_20_0:PlaySuccessAnim()
end

function var_0_0.PlaySuccessAnim(arg_21_0)
	SetActive(arg_21_0.fullMask_, true)
	PuzzleTool:SetPuzzleAnswerPanel(true)

	local var_21_0 = PuzzleTool:GetAnswerAnim()
	local var_21_1 = "VolumePuzzleGamePlayUI_success"

	var_21_0:Play(var_21_1, -1, 0)

	arg_21_0.timer_ = Timer.New(function()
		local var_22_0 = var_21_0:GetCurrentAnimatorStateInfo(0)

		if var_22_0:IsName(var_21_1) and var_22_0.normalizedTime >= 1 then
			if arg_21_0.timer_ ~= nil then
				arg_21_0.timer_:Stop()

				arg_21_0.timer_ = nil
			end

			SetActive(arg_21_0.fullMask_, false)
			PuzzleTool:SetPuzzleAnswerPanel(false)
		end
	end, 0.033, -1)

	arg_21_0.timer_:Start()
	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzlecomplete", "")
end

function var_0_0.RefreshReward(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if arg_23_0.rewardItemList_[iter_23_0] then
			arg_23_0.rewardItemList_[iter_23_0]:SetData(iter_23_1, false)
		else
			arg_23_0.rewardItemList_[iter_23_0] = RewardPoolItem.New(arg_23_0.goRewardPanel_, iter_23_1)
		end
	end

	for iter_23_2 = #arg_23_1 + 1, #arg_23_0.rewardItemList_ do
		arg_23_0.rewardItemList_[iter_23_2]:Show(false)
	end

	local var_23_0 = PuzzleData:IsCompleted(arg_23_0.activityID_)
	local var_23_1 = PuzzleData:IsReceived(arg_23_0.activityID_)

	if not var_23_0 then
		arg_23_0.rewardState_:SetSelectedState("uncompleted")
	elseif not var_23_1 then
		arg_23_0.rewardState_:SetSelectedState("unreceived")
	else
		arg_23_0.rewardState_:SetSelectedState("received")
	end
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.onItemSelectHandler_ = nil
	arg_24_0.onCompleteHandler_ = nil
	arg_24_0.operationType_ = nil

	for iter_24_0, iter_24_1 in pairs(arg_24_0.rewardItemList_) do
		iter_24_1:Dispose()
	end

	arg_24_0.rewardItemList_ = nil
	arg_24_0.pieceList_ = nil

	var_0_0.super.Dispose(arg_24_0)
end

function var_0_0.AddUIListener(arg_25_0)
	arg_25_0:AddBtnListener(arg_25_0.resetBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_25_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(arg_25_0.activityID_, arg_25_0.operationType_.reset, function()
			arg_25_0:ResetLevel()
			arg_25_0:RefreshUI()
			saveData(string.format("Puzzle_%d", arg_25_0.activityID_), "canPlayHelpAnim", true)
		end)
	end)
	arg_25_0:AddBtnListener(arg_25_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_25_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(arg_25_0.activityID_, arg_25_0.operationType_.receive, function(arg_29_0, arg_29_1)
			getReward(arg_29_1.reward_list)
			PuzzleData:SetReceivedActivityList(arg_25_0.activityID_)
			arg_25_0:RefreshReward(arg_29_1.reward_list)
		end)
	end)
	arg_25_0:AddBtnListener(arg_25_0.helpBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_25_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(arg_25_0.activityID_, arg_25_0.operationType_.help, arg_25_0.onCompleteHandler_)
	end)
	arg_25_0:AddBtnListener(arg_25_0.reTryBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_25_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(arg_25_0.activityID_, arg_25_0.operationType_.reset, function()
			arg_25_0:OnEnterReTry()
		end)
	end)
	arg_25_0:AddBtnListener(arg_25_0.playStoryBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_25_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleData:SetWatchedVideo(arg_25_0.activityID_)

		local var_33_0 = ActivityPuzzleCfg[arg_25_0.activityID_].story_id

		manager.ui.mainCameraCom_.orthographic = false

		manager.ui:ResetMainCamera()

		local var_33_1 = StoryCfg[var_33_0]

		if var_33_1.trigger[4] == 1 then
			gameContext:Go("blank")
			manager.audio:Pause("music", true)
			manager.video:Play(var_33_1.videoPath, function()
				gameContext:Back(nil, {
					isEnter = false
				})
				PlayerAction.ChangeStoryList(var_33_0)
				manager.audio:Pause("music", false)
				manager.ui:SetMainCamera("puzzle")

				manager.ui.mainCameraCom_.orthographic = true
			end, nil, nil, nil, var_33_1.videoId)

			return
		end
	end)
	arg_25_0:AddBtnListener(arg_25_0.tryAgainBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_25_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(arg_25_0.activityID_, arg_25_0.operationType_.reset, function()
			arg_25_0:OnEnterReTry()
		end)
	end)
	arg_25_0:AddBtnListener(arg_25_0.retrunBtn_, nil, function()
		arg_25_0:OnExitRetry()
	end)
	arg_25_0:AddBtnListener(arg_25_0.giveUpBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_PUZZLE"),
			OkCallback = function()
				PuzzleAction.Operate(arg_25_0.activityID_, arg_25_0.operationType_.reset, function()
					arg_25_0:OnExitRetry()
				end)
			end
		})
	end)
	arg_25_0:AddBtnListener(arg_25_0.previewBtn_, nil, function()
		SetActive(arg_25_0.previewPanel_, true)
	end)
	arg_25_0:AddBtnListener(arg_25_0.previewReturnBtn_, nil, function()
		SetActive(arg_25_0.previewPanel_, false)
	end)
end

return var_0_0
