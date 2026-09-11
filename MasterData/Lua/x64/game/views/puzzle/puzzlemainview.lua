local PuzzleMainView = class("PuzzleMainView", ReduxView)

function PuzzleMainView:UIName()
	return "UI/VolumeIIIUI/Puzzle/VolumePuzzleMainUI"
end

function PuzzleMainView:UIParent()
	return manager.ui.uiMain.transform
end

function PuzzleMainView:Init()
	self.onSenceLoadedHandler_ = handler(self, self.OnPuzzleSceneLoaded)
	self.puzzleGameEnterHandler_ = handler(self, self.OnPuzzleGameEnter)
	self.puzzleGameExitHandler_ = handler(self, self.OnPuzzleGameExit)
	self.puzzleAnimStartHandler_ = handler(self, self.OnAnimStart)
	self.puzzleAnimEndHandler_ = handler(self, self.OnAnimEnd)
	self.clickSwitchItemHandler_ = handler(self, self.OnClickSwitchItem)

	self:InitUI()
	self:AddUIListener()

	self.gameStartController_ = ControllerUtil.GetController(self.transform_, "gameStart")
	self.switchItemList_ = {}

	for iter_3_0 = 1, self.contentTrans_.childCount do
		self.switchItemList_[iter_3_0] = PuzzleSelectItem.New(self.contentTrans_:GetChild(iter_3_0 - 1).gameObject)
	end
end

function PuzzleMainView:InitUI()
	self:BindCfgUI()
end

function PuzzleMainView:AddUIListener()
	return
end

function PuzzleMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_PUZZLE_DESCRIPE")
	manager.notify:RegistListener(PUZZLE_GAME_ENTER, self.puzzleGameEnterHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_EXIT, self.puzzleGameExitHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_ANIM_START, self.puzzleAnimStartHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_ANIM_END, self.puzzleAnimEndHandler_)
	self.gameStartController_:SetSelectedState("false")
	self:LoadPuzzleScene()

	self.activityID_ = self.params_.activityID
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
	self.contentTrans_.localPosition.x = PuzzleData:GetLastContentPosX(self.activityID_) or self.contentTrans_.localPosition.x
	self.contentTrans_.localPosition = self.contentTrans_.localPosition
end

function PuzzleMainView:OnTop()
	self.playingAnimCount_ = 0

	self:RefreshUI()
	self:AddTimer()
end

function PuzzleMainView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(PUZZLE_GAME_ENTER, self.puzzleGameEnterHandler_)
	manager.notify:RemoveListener(PUZZLE_GAME_EXIT, self.puzzleGameExitHandler_)
	manager.notify:RemoveListener(PUZZLE_GAME_ANIM_START, self.puzzleAnimStartHandler_)
	manager.notify:RemoveListener(PUZZLE_GAME_ANIM_END, self.puzzleAnimEndHandler_)

	for iter_8_0, iter_8_1 in ipairs(self.switchItemList_) do
		iter_8_1:OnExit()
	end

	self:UnLoadPuzzleScene()
	self:StopTimer()
	PuzzleData:SetLastContentPosX(self.activityID_, self.contentTrans_.localPosition.x)
end

function PuzzleMainView:Dispose()
	self.onSenceLoadedHandler_ = nil
	self.puzzleGameEnterHandler_ = nil
	self.puzzleGameExitHandler_ = nil
	self.puzzleAnimStartHandler_ = nil
	self.puzzleAnimEndHandler_ = nil
	self.clickSwitchItemHandler_ = nil

	for iter_9_0, iter_9_1 in ipairs(self.switchItemList_) do
		iter_9_1:Dispose()
	end

	PuzzleMainView.super.Dispose(self)
end

function PuzzleMainView:OnPuzzleGameEnter()
	self.startAnim_:Play("VolumePuzzleMain_exit", -1, 0)
	self:StopTimer()
end

function PuzzleMainView:OnPuzzleGameExit()
	for iter_11_0, iter_11_1 in ipairs(self.switchItemList_) do
		iter_11_1:Reset()
	end

	self.gameStartController_:SetSelectedState("false")
	self.startAnim_:Play("VolumePuzzleMain_recover", -1, 0)
	PuzzleTool:RecoverBg()
end

function PuzzleMainView:OnAnimStart()
	self.playingAnimCount_ = self.playingAnimCount_ + 1

	SetActive(self.fullMask_, true)
end

function PuzzleMainView:OnAnimEnd()
	PuzzleTool:SetPuzzleGo(true)
	PuzzleTool:RefreshPuzzlePanel((PuzzleData:IsCompleted(self.selectActivityID_)))

	self.playingAnimCount_ = self.playingAnimCount_ - 1

	if self.playingAnimCount_ == 0 then
		self.gameStartController_:SetSelectedState("true")
		SetActive(self.fullMask_, false)
	end
end

function PuzzleMainView:LoadPuzzleScene()
	manager.ui:SetMainCamera("puzzle")

	manager.ui.mainCameraCom_.orthographic = true

	PuzzleTool:LoadPuzzleLevel(self.onSenceLoadedHandler_)
end

function PuzzleMainView:UnLoadPuzzleScene()
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	PuzzleTool:UnLoadPuzzleLevel()
end

function PuzzleMainView:RefreshUI()
	self.subActivityList_ = ActivityCfg[self.activityID_].sub_activity_list

	for iter_16_0, iter_16_1 in ipairs(self.switchItemList_) do
		iter_16_1:SetData(self.activityID_, self.subActivityList_[iter_16_0], iter_16_0)
		iter_16_1:SetClickCallBack(self.clickSwitchItemHandler_)
		iter_16_1:Reset()
	end

	self:RefreshDesc()
	SetActive(self.fullMask_, false)
end

function PuzzleMainView:RefreshDesc()
	self.descText_.text = GetTips("ACTIVITY_PUZZLE_CONTENT")
end

function PuzzleMainView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)

	self:StopTimer()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		for iter_19_0, iter_19_1 in ipairs(self.switchItemList_) do
			iter_19_1:RefreshLock()
		end

		self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function PuzzleMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PuzzleMainView:OnPuzzleSceneLoaded()
	return
end

function PuzzleMainView:OnClickSwitchItem(arg_22_1, arg_22_2)
	self.selectActivityID_ = arg_22_2

	for iter_22_0, iter_22_1 in ipairs(self.switchItemList_) do
		iter_22_1:OnClickItem(arg_22_1)
	end
end

return PuzzleMainView
