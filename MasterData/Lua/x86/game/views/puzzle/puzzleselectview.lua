local PuzzleSelectView = class("PuzzleSelectView", ReduxView)

function PuzzleSelectView:UIName()
	return "UI/VolumeIIIUI/Puzzle/VolumePuzzleGamePlayUI"
end

function PuzzleSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function PuzzleSelectView:Init()
	self.rewardItemList_ = {}
	self.onItemSelectHandler_ = handler(self, self.OnItemSelected)
	self.onCompleteHandler_ = handler(self, self.CompletedPuzzle)
	self.onMoveHandler_ = handler(self, self.OnMovePuzzle)
	self.operationType_ = PuzzleAction.OPERATION_TYPE

	self:InitUI()
	self:AddUIListener()
end

function PuzzleSelectView:InitUI()
	self:BindCfgUI()

	self.completedController_ = ControllerUtil.GetController(self.transform_, "complete")
	self.resetBtnController_ = ControllerUtil.GetController(self.transform_, "resetBtn")
	self.stepCountController_ = ControllerUtil.GetController(self.transform_, "stepCount")
	self.lastRecordController_ = ControllerUtil.GetController(self.transform_, "lastRecord")
	self.retryController_ = ControllerUtil.GetController(self.transform_, "retry")
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "reward")
	self.previewController_ = ControllerUtil.GetController(self.transform_, "preview")
end

function PuzzleSelectView:OnEnter()
	manager.notify:Invoke(PUZZLE_GAME_ENTER)

	self.canMove_ = true
	self.retry_ = false
	self.activityID_ = self.params_.activityID
	self.isCompleted_ = PuzzleData:IsCompleted(self.activityID_)

	self:InitializePuzzle()
	self:RefreshUI()

	self.videoRedPointStr_ = string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, self.params_.mainActivityID, self.params_.activityID)

	manager.redPoint:bindUIandKey(self.watchBtnTrans_, self.videoRedPointStr_)
end

function PuzzleSelectView:OnExit()
	manager.notify:Invoke(PUZZLE_GAME_EXIT)

	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	PuzzleTool:SetPuzzleGo(false)
	PuzzleTool:SetPuzzleAnswerPanel(false)
	SetActive(self.previewPanel_, false)
	manager.redPoint:unbindUIandKey(self.watchBtnTrans_, self.videoRedPointStr_)
end

function PuzzleSelectView:OnEnterReTry()
	self.retryController_:SetSelectedState("uncompleted")
	self.completedController_:SetSelectedState("retry")
	self.resetBtnController_:SetSelectedState("reset")
	self.previewController_:SetSelectedState("true")

	self.retry_ = true

	manager.windowBar:HideBar()
	self:ResetLevel()
	self:RefreshUI()
	PuzzleTool:RefreshPuzzlePanel(false)
	self:RefreshRecord(false, (PuzzleData:GetMinStepCount(self.activityID_)))
end

function PuzzleSelectView:OnExitRetry()
	self.retryController_:SetSelectedState("none")

	self.retry_ = false

	SetActive(self.newRecordFlag_, false)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_PUZZLE_DESCRIPE")
	self:RefreshUI()
	PuzzleTool:RefreshPuzzlePanel(self.isCompleted_)
end

function PuzzleSelectView:InitializePuzzle()
	self.curStateList_ = PuzzleData:GetStateList(self.activityID_)
	self.puzzleSize_ = ActivityPuzzleCfg[self.activityID_].type
	self.answerList_ = ActivityPuzzleCfg[self.activityID_].correct_array
	self.maxStep_ = ActivityPuzzleCfg[self.activityID_].max_step
	self.emptyFlag_ = ActivityPuzzleCfg[self.activityID_].block
	self.pieceList_ = PuzzleTool:InitPuzzlePiece(self.activityID_, self.curStateList_, self.onItemSelectHandler_)

	self:RefreshPreviewImg()
end

function PuzzleSelectView:RefreshPreviewImg()
	self.previewBigImg_.sprite = getSprite(ActivityPuzzleCfg[self.activityID_].path, ActivityPuzzleCfg[self.activityID_].picture_id)
	self.previewSmallImg_.sprite = getSprite(ActivityPuzzleCfg[self.activityID_].path, ActivityPuzzleCfg[self.activityID_].picture_id)

	local var_10_0 = PuzzleTool:GetPuzzlePanelWidth()

	self.previewBigTrans_.sizeDelta = Vector2(var_10_0, var_10_0)

	local var_10_1, var_10_2 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.previewPanel_.transform, manager.ui.mainCameraCom_:WorldToScreenPoint(PuzzleTool:GetPanelTrans().position), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, (Vector2(1, 1)))

	self.previewBigTrans_.localPosition = var_10_2
end

function PuzzleSelectView:ResetLevel()
	PuzzleData:ResetData(self.activityID_)

	self.curStateList_ = PuzzleData:GetStateList(self.activityID_)

	for iter_11_0, iter_11_1 in ipairs(self.curStateList_) do
		if self.pieceList_[iter_11_0] then
			self.pieceList_[iter_11_0]:SetID(iter_11_1)
		end
	end
end

function PuzzleSelectView:RefreshUI()
	if self.retry_ == false then
		self:RefreshReward(formatRewardCfgList(ActivityPuzzleCfg[self.activityID_].reward_item_list))
		self.completedController_:SetSelectedState(tostring(self.isCompleted_))

		if not self.isCompleted_ then
			self.stepCountController_:SetSelectedState("cur")
			self.resetBtnController_:SetSelectedState("reset")
			self.previewController_:SetSelectedState("true")
		else
			self.resetBtnController_:SetSelectedState("retry")
			self.previewController_:SetSelectedState("false")

			if PuzzleData:GetMinStepCount(self.activityID_) == 0 then
				self.stepCountController_:SetSelectedState("none")
			else
				self.stepCountController_:SetSelectedState("min")
			end

			PuzzleTool:RefreshAnswer(self.activityID_)
			SetActive(self.playStoryBtnGo_, ActivityPuzzleCfg[self.activityID_].story_id ~= 0)
		end

		self:RefreshHelpBtn()
	else
		self.stepCountController_:SetSelectedState("cur")
	end

	self:RefreshStepCount()
end

function PuzzleSelectView:RefreshStepCount()
	if self.isCompleted_ then
		if self.retry_ == true then
			self.curStepCountText_.text = PuzzleData:GetStepCount(self.activityID_)

			goto label_13_0
		end
	end

	self.minStepCountText_.text = PuzzleData:GetMinStepCount(self.activityID_)

	::label_13_0::
end

function PuzzleSelectView:RefreshRecord(arg_14_1, arg_14_2)
	SetActive(self.newRecordFlag_, arg_14_1)

	if arg_14_2 ~= 0 then
		self.lastRecordController_:SetSelectedState("true")

		self.lastRecordText_.text = arg_14_2
	else
		self.lastRecordController_:SetSelectedState("false")
	end
end

function PuzzleSelectView:RefreshHelpBtn()
	local var_15_0 = PuzzleData:GetStepCount(self.activityID_)

	if var_15_0 < self.maxStep_ then
		self.helpText_.text = string.format(GetTips("PUZZLE_HELP_REMAIN"), self.maxStep_ - var_15_0)
		self.helpBtn_.interactable = false
	else
		self.helpText_.text = GetTips("PUZZLE_HELP")
		self.helpBtn_.interactable = true
	end

	if var_15_0 == self.maxStep_ then
		local var_15_1 = getData(string.format("Puzzle_%d", self.activityID_), "canPlayHelpAnim")

		if var_15_1 == nil or var_15_1 == true then
			self.helpAnim_:Play("VolumePuzzleGamePlayUI_help", -1, 0)
			saveData(string.format("Puzzle_%d", self.activityID_), "canPlayHelpAnim", false)
			manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzlehelp", "")
		end
	end
end

function PuzzleSelectView:OnItemSelected(arg_16_1)
	if not self.canMove_ then
		return
	end

	local var_16_0 = arg_16_1

	if arg_16_1 % self.puzzleSize_ ~= 1 and self.curStateList_[arg_16_1 - 1] == self.emptyFlag_ then
		self:ExChangeItem(var_16_0, arg_16_1 - 1, arg_16_1)
	elseif var_16_0 % self.puzzleSize_ ~= 0 and self.curStateList_[arg_16_1 + 1] == self.emptyFlag_ then
		self:ExChangeItem(var_16_0, arg_16_1 + 1, arg_16_1)
	elseif arg_16_1 - self.puzzleSize_ > 0 and self.curStateList_[arg_16_1 - self.puzzleSize_] == self.emptyFlag_ then
		self:ExChangeItem(var_16_0, arg_16_1 - self.puzzleSize_, arg_16_1)
	elseif arg_16_1 + self.puzzleSize_ <= #self.curStateList_ and self.curStateList_[arg_16_1 + self.puzzleSize_] == self.emptyFlag_ then
		self:ExChangeItem(var_16_0, arg_16_1 + self.puzzleSize_, arg_16_1)
	end
end

function PuzzleSelectView:ExChangeItem(arg_17_1, arg_17_2, arg_17_3)
	self.pieceList_[arg_17_1]:SetID(self.pieceList_[arg_17_2].ID_)

	self.curStateList_[arg_17_1] = self.pieceList_[arg_17_2].ID_

	self.pieceList_[arg_17_2]:SetID(self.pieceList_[arg_17_1].ID_)

	self.curStateList_[arg_17_2] = self.pieceList_[arg_17_1].ID_

	PuzzleData:SetPuzzleState(self.activityID_, arg_17_1, self.curStateList_[arg_17_1], arg_17_2, self.curStateList_[arg_17_2])
	self:RefreshHelpBtn()

	local var_17_0 = self:CheckAnswer()

	self:RefreshStepCount(var_17_0)

	if not var_17_0 then
		self.canMove_ = false

		PuzzleAction.Operate(self.activityID_, self.operationType_.move, self.onMoveHandler_, arg_17_3)
	else
		self.canMove_ = false

		PuzzleAction.Operate(self.activityID_, self.operationType_.complete, self.onCompleteHandler_, arg_17_3)
	end

	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_slide", "")
end

function PuzzleSelectView:OnMovePuzzle()
	self.canMove_ = true
end

function PuzzleSelectView:CheckAnswer()
	local var_19_0 = true

	for iter_19_0, iter_19_1 in ipairs(self.answerList_) do
		if self.answerList_[iter_19_0] ~= self.curStateList_[iter_19_0] then
			var_19_0 = false

			break
		end
	end

	return var_19_0
end

function PuzzleSelectView:CompletedPuzzle(arg_20_1)
	self.canMove_ = true

	PuzzleData:SetCompletedActivityList(self.activityID_)

	self.isCompleted_ = true

	PuzzleTool:RefreshPuzzlePanel(self.isCompleted_)
	PuzzleTool:RefreshAnswer(self.activityID_)

	if not arg_20_1 then
		local var_20_0, var_20_1 = PuzzleData:SetMinStepCount(self.activityID_)

		if self.retry_ == true then
			self.retryController_:SetSelectedState("completed")
			self.resetBtnController_:SetSelectedState("none")
			self:RefreshRecord(var_20_0, var_20_1)
		end
	end

	self.previewController_:SetSelectedState("false")
	self:RefreshUI()
	self:PlaySuccessAnim()
end

function PuzzleSelectView:PlaySuccessAnim()
	SetActive(self.fullMask_, true)
	PuzzleTool:SetPuzzleAnswerPanel(true)

	local var_21_0 = PuzzleTool:GetAnswerAnim()
	local var_21_1 = "VolumePuzzleGamePlayUI_success"

	var_21_0:Play("VolumePuzzleGamePlayUI_success", -1, 0)

	self.timer_ = Timer.New(function()
		local var_22_0 = var_21_0:GetCurrentAnimatorStateInfo(0)

		if var_22_0:IsName(var_21_1) and var_22_0.normalizedTime >= 1 then
			if self.timer_ ~= nil then
				self.timer_:Stop()

				self.timer_ = nil
			end

			SetActive(self.fullMask_, false)
			PuzzleTool:SetPuzzleAnswerPanel(false)
		end
	end, 0.033, -1)

	self.timer_:Start()
	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzlecomplete", "")
end

function PuzzleSelectView:RefreshReward(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if self.rewardItemList_[iter_23_0] then
			self.rewardItemList_[iter_23_0]:SetData(iter_23_1, false)
		else
			self.rewardItemList_[iter_23_0] = RewardPoolItem.New(self.goRewardPanel_, iter_23_1)
		end
	end

	for iter_23_2 = #arg_23_1 + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_23_2]:Show(false)
	end

	if not PuzzleData:IsCompleted(self.activityID_) then
		self.rewardState_:SetSelectedState("uncompleted")
	elseif not PuzzleData:IsReceived(self.activityID_) then
		self.rewardState_:SetSelectedState("unreceived")
	else
		self.rewardState_:SetSelectedState("received")
	end
end

function PuzzleSelectView:Dispose()
	self.onItemSelectHandler_ = nil
	self.onCompleteHandler_ = nil
	self.operationType_ = nil

	for iter_24_0, iter_24_1 in pairs(self.rewardItemList_) do
		iter_24_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.pieceList_ = nil

	PuzzleSelectView.super.Dispose(self)
end

function PuzzleSelectView:AddUIListener()
	self:AddBtnListener(self.resetBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(self.activityID_, self.operationType_.reset, function()
			self:ResetLevel()
			self:RefreshUI()
			saveData(string.format("Puzzle_%d", self.activityID_), "canPlayHelpAnim", true)
		end)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(self.activityID_, self.operationType_.receive, function(arg_29_0, arg_29_1)
			getReward(arg_29_1.reward_list)
			PuzzleData:SetReceivedActivityList(self.activityID_)
			self:RefreshReward(arg_29_1.reward_list)
		end)
	end)
	self:AddBtnListener(self.helpBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(self.activityID_, self.operationType_.help, self.onCompleteHandler_)
	end)
	self:AddBtnListener(self.reTryBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(self.activityID_, self.operationType_.reset, function()
			self:OnEnterReTry()
		end)
	end)
	self:AddBtnListener(self.playStoryBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleData:SetWatchedVideo(self.activityID_)

		local var_33_0 = ActivityPuzzleCfg[self.activityID_].story_id

		manager.ui.mainCameraCom_.orthographic = false

		manager.ui:ResetMainCamera()

		if StoryCfg[ActivityPuzzleCfg[self.activityID_].story_id].trigger[4] == 1 then
			gameContext:Go("blank")
			manager.audio:Pause("music", true)
			manager.video:Play(StoryCfg[ActivityPuzzleCfg[self.activityID_].story_id].videoPath, function()
				gameContext:Back(nil, {
					isEnter = false
				})
				PlayerAction.ChangeStoryList(var_33_0)
				manager.audio:Pause("music", false)
				manager.ui:SetMainCamera("puzzle")

				manager.ui.mainCameraCom_.orthographic = true
			end, nil, nil, nil, StoryCfg[ActivityPuzzleCfg[self.activityID_].story_id].videoId)

			return
		end
	end)
	self:AddBtnListener(self.tryAgainBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(self.activityID_, self.operationType_.reset, function()
			self:OnEnterReTry()
		end)
	end)
	self:AddBtnListener(self.retrunBtn_, nil, function()
		self:OnExitRetry()
	end)
	self:AddBtnListener(self.giveUpBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_PUZZLE"),
			OkCallback = function()
				PuzzleAction.Operate(self.activityID_, self.operationType_.reset, function()
					self:OnExitRetry()
				end)
			end
		})
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		SetActive(self.previewPanel_, true)
	end)
	self:AddBtnListener(self.previewReturnBtn_, nil, function()
		SetActive(self.previewPanel_, false)
	end)
end

return PuzzleSelectView
