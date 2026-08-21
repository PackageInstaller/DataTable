local var_0_0 = import("game.views.activity.Submodule.Fishing.Game.FishingGameView")
local var_0_1 = class("SailFishingGameView", var_0_0)

function var_0_1.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.hookBtn_, nil, function()
		if arg_1_0.hook_ then
			arg_1_0.hook_:StartHooking()
		end
	end)
	FishGameManager.GetInstance():SetPauseHandler(handler(arg_1_0, arg_1_0.OnPause))
	FishGameManager.GetInstance():SetContinueHandler(handler(arg_1_0, arg_1_0.OnContinue))
	FishGameManager.GetInstance():SetScoreChangeHandler(handler(arg_1_0, arg_1_0.OnScoreChange))
	FishGameManager.GetInstance():SetScoreAddHandler(handler(arg_1_0, arg_1_0.OnScoreAdd))
	FishGameManager.GetInstance():AddBuffHandler(handler(arg_1_0, arg_1_0.OnBuffChange))
	arg_1_0:AddBtnListener(arg_1_0.pauseBtn_, nil, function()
		FishGameManager.GetInstance():Pause()
	end)
	arg_1_0:AddBtnListener(arg_1_0.continueBtn_, nil, function()
		FishGameManager.GetInstance():Continue()
	end)
	arg_1_0:AddBtnListener(arg_1_0.exitBtn_, nil, function()
		local var_5_0 = SailGameData:GetCurGameData(arg_1_0.params_.activityID).curStageIndex

		arg_1_0.tempScore_ = FishGameManager.GetInstance():GetScore()

		SailGameAction.EventOperate(arg_1_0.params_.activityID, var_5_0, nil, arg_1_0.tempScore_)
	end)

	arg_1_0.onAnimationCompleteHandler_ = handler(arg_1_0, arg_1_0.OnAnimationComplete)
	arg_1_0.roleSpine_.AnimationState.Complete = arg_1_0.roleSpine_.AnimationState.Complete + arg_1_0.onAnimationCompleteHandler_
end

function var_0_1.Update(arg_6_0)
	if arg_6_0.end_ then
		arg_6_0.roleSpine_.AnimationState.TimeScale = 0
		arg_6_0.waterSpine_.AnimationState.TimeScale = 0

		return
	end

	local var_6_0 = FishGameManager.GetInstance():GetStatus()

	if var_6_0 == "cast" then
		if animationStatus == "notPlayed" then
			arg_6_0:PlayRoleAnimation("PushButton", false)

			animationStatus = "playing"
		end
	elseif var_6_0 == "catch" then
		animationStatus = "notPlayed"

		arg_6_0:PlayRoleAnimation("Happy", true)
	elseif var_6_0 == "fail" then
		animationStatus = "notPlayed"

		arg_6_0:PlayRoleAnimation("Sad", true)
	elseif var_6_0 == "idle" then
		animationStatus = "notPlayed"

		arg_6_0:PlayRoleAnimation("idle", true)
	end

	local var_6_1 = FishGameManager.GetInstance():GetSeconds()

	if var_6_1 < 0 then
		var_6_1 = 0
	end

	arg_6_0.countdownLabel_.text = tostring(math.floor(var_6_1))

	if FishGameManager.GetInstance():GetIsEnd() then
		arg_6_0.end_ = true

		local var_6_2 = SailGameData:GetCurGameData(arg_6_0.params_.activityID).curStageIndex

		arg_6_0.tempScore_ = FishGameManager.GetInstance():GetScore()

		SailGameAction.EventOperate(arg_6_0.params_.activityID, var_6_2, nil, arg_6_0.tempScore_)
		manager.audio:StopEffect()
	end

	arg_6_0.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function var_0_1.OnEventOperateSuccess(arg_7_0)
	SDKTools.SendMessageToSDK("activity_skadi_sea_be_out_finish", {
		fish_event_level_id = arg_7_0.levelId_
	})
	SailGameAction.SetEventEndMark(arg_7_0.params_.activityID, SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS)
	JumpTools.OpenPageByJump("sailFishingGameResult", {
		activityID = arg_7_0.params_.activityID,
		score = arg_7_0.tempScore_
	})
end

return var_0_1
