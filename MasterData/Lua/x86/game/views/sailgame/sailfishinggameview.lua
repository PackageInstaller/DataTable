local SailFishingGameView = class("SailFishingGameView", (import("game.views.activity.Submodule.Fishing.Game.FishingGameView")))

function SailFishingGameView:AddUIListener()
	self:AddBtnListener(self.hookBtn_, nil, function()
		if self.hook_ then
			self.hook_:StartHooking()
		end
	end)
	FishGameManager.GetInstance():SetPauseHandler(handler(self, self.OnPause))
	FishGameManager.GetInstance():SetContinueHandler(handler(self, self.OnContinue))
	FishGameManager.GetInstance():SetScoreChangeHandler(handler(self, self.OnScoreChange))
	FishGameManager.GetInstance():SetScoreAddHandler(handler(self, self.OnScoreAdd))
	FishGameManager.GetInstance():AddBuffHandler(handler(self, self.OnBuffChange))
	self:AddBtnListener(self.pauseBtn_, nil, function()
		FishGameManager.GetInstance():Pause()
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		FishGameManager.GetInstance():Continue()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		self.tempScore_ = FishGameManager.GetInstance():GetScore()

		SailGameAction.EventOperate(self.params_.activityID, SailGameData:GetCurGameData(self.params_.activityID).curStageIndex, nil, self.tempScore_)
	end)

	self.onAnimationCompleteHandler_ = handler(self, self.OnAnimationComplete)
	self.roleSpine_.AnimationState.Complete = self.roleSpine_.AnimationState.Complete + self.onAnimationCompleteHandler_
end

function SailFishingGameView:Update()
	if self.end_ then
		self.roleSpine_.AnimationState.TimeScale = 0
		self.waterSpine_.AnimationState.TimeScale = 0

		return
	end

	local var_6_0 = FishGameManager.GetInstance():GetStatus()

	if var_6_0 == "cast" then
		if animationStatus == "notPlayed" then
			self:PlayRoleAnimation("PushButton", false)

			animationStatus = "playing"
		end
	elseif var_6_0 == "catch" then
		animationStatus = "notPlayed"

		self:PlayRoleAnimation("Happy", true)
	elseif var_6_0 == "fail" then
		animationStatus = "notPlayed"

		self:PlayRoleAnimation("Sad", true)
	elseif var_6_0 == "idle" then
		animationStatus = "notPlayed"

		self:PlayRoleAnimation("idle", true)
	end

	local var_6_1 = FishGameManager.GetInstance():GetSeconds()

	if var_6_1 < 0 then
		var_6_1 = 0
	end

	self.countdownLabel_.text = tostring(math.floor(var_6_1))

	if FishGameManager.GetInstance():GetIsEnd() then
		self.end_ = true
		self.tempScore_ = FishGameManager.GetInstance():GetScore()

		SailGameAction.EventOperate(self.params_.activityID, SailGameData:GetCurGameData(self.params_.activityID).curStageIndex, nil, self.tempScore_)
		manager.audio:StopEffect()
	end

	self.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function SailFishingGameView:OnEventOperateSuccess()
	SDKTools.SendMessageToSDK("activity_skadi_sea_be_out_finish", {
		fish_event_level_id = self.levelId_
	})
	SailGameAction.SetEventEndMark(self.params_.activityID, SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS)
	JumpTools.OpenPageByJump("sailFishingGameResult", {
		activityID = self.params_.activityID,
		score = self.tempScore_
	})
end

return SailFishingGameView
