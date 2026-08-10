local var_0_0 = class("ChallengeRogueTeamEntraceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.pointBtnView_ = ChallengeRogueTeamPointBtn.New(arg_3_0.pointGo_)
	arg_3_0.exitPlayingView_ = ChallengeRogueTeamExitPlayingPanel.New(arg_3_0.exitPlayingGo_)
	arg_3_0.exitPlayingController_ = arg_3_0.controllerEx_:GetController("file")
	arg_3_0.mutiRewardController_ = arg_3_0.controllerEx_:GetController("muti")
	arg_3_0.exitPlayController_ = arg_3_0.exitPlayControllerEx_:GetController("termination")
	arg_3_0.taskController_ = arg_3_0.taskControllerEx_:GetController("taskBtn")
	arg_3_0.illustratedController_ = arg_3_0.illustratedControllerEx_:GetController("IllustratedBtn")
	arg_3_0.skillController_ = arg_3_0.skillControllerEx_:GetController("skillBtn")
	arg_3_0.pointController_ = arg_3_0.pointControllerEx_:GetController("pointBtn")
	arg_3_0.onExitPlayingHandler_ = handler(arg_3_0, arg_3_0.OnExitPlaying)
end

function var_0_0.OnEnter(arg_4_0)
	ChallengeRogueTeamAction.ResetPopWindowCnt()
	ChallengeRogueTeamData:UISetEventIDAnimator()

	arg_4_0.templateID_ = arg_4_0.params_.templateID

	arg_4_0.pointBtnView_:OnEnter(ChallengeRogueTeamData:GetScoreActivityIDByTemple(arg_4_0.templateID_))
	arg_4_0:RefreshUI()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_EXIT, arg_4_0.onExitPlayingHandler_)

	local var_4_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTaskActivityID(arg_4_0.templateID_))

	manager.redPoint:bindUIandKey(arg_4_0.taskBtn_.transform, var_4_0)

	local var_4_1 = string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(arg_4_0.templateID_))

	manager.redPoint:bindUIandKey(arg_4_0.scoreBtn_.transform, var_4_1)

	local var_4_2 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED, arg_4_0.templateID_)

	manager.redPoint:bindUIandKey(arg_4_0.illustratedBtn_.transform, var_4_2)

	local var_4_3 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, arg_4_0.templateID_)

	manager.redPoint:bindUIandKey(arg_4_0.technologyTreeBtn_.transform, var_4_3)
	arg_4_0:RefreshBGM()
end

function var_0_0.OnEnterOver(arg_5_0)
	local var_5_0 = RogueTeamCfg[arg_5_0.templateID_].story_id

	if manager.story:IsStoryPlayed(var_5_0) then
		arg_5_0:CheckPopView()
	else
		manager.story:StartStoryById(var_5_0, function()
			arg_5_0:CheckPopView()
		end)
	end
end

function var_0_0.CheckPopView(arg_7_0)
	if getData("ChallengeRogueEnterPop", tostring(arg_7_0.templateID_)) == nil then
		arg_7_0.popTimer_ = FrameTimer.New(function()
			if manager.guide:IsPlaying() then
				return
			end

			JumpTools.OpenPageByJump("challengeRogueTeamEnterPop", {
				activityId = ChallengeRogueTeamData:GetScoreActivityIDByTemple(arg_7_0.templateID_)
			})
			saveData("ChallengeRogueEnterPop", tostring(arg_7_0.templateID_), 1)
		end, 30, 1)

		arg_7_0.popTimer_:Start()
	end
end

function var_0_0.OnExit(arg_9_0)
	local var_9_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTaskActivityID(arg_9_0.templateID_))

	manager.redPoint:unbindUIandKey(arg_9_0.taskBtn_.transform, var_9_0)

	local var_9_1 = string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(arg_9_0.templateID_))

	manager.redPoint:unbindUIandKey(arg_9_0.scoreBtn_.transform, var_9_1)

	local var_9_2 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED, arg_9_0.templateID_)

	manager.redPoint:unbindUIandKey(arg_9_0.illustratedBtn_.transform, var_9_2)

	local var_9_3 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, arg_9_0.templateID_)

	manager.redPoint:unbindUIandKey(arg_9_0.technologyTreeBtn_.transform, var_9_3)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_EXIT, arg_9_0.onExitPlayingHandler_)

	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end

	if arg_9_0.popTimer_ then
		arg_9_0.popTimer_:Stop()

		arg_9_0.popTimer_ = nil
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.onExitPlayingHandler_ = nil

	arg_10_0.pointBtnView_:Dispose()

	arg_10_0.pointBtnView_ = nil

	arg_10_0.exitPlayingView_:Dispose()

	arg_10_0.exitPlayingView_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.taskBtn_, nil, function()
		if not ChallengeRogueTeamData:IsFinishGuide() then
			ShowTips("ROGUE_TEAM_FINISH_GUIDE_THEN_OPEN")

			return
		end

		local var_12_0 = ChallengeRogueTeamData:GetCacheTemplateID()

		JumpTools.OpenPageByJump("challengeRogueTeamRewardPop", {
			activityId = ChallengeRogueTeamData:GetTaskActivityIDByTemple(var_12_0)
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.technologyTreeBtn_, nil, function()
		if not ChallengeRogueTeamData:IsFinishGuide() then
			ShowTips("ROGUE_TEAM_FINISH_GUIDE_THEN_OPEN")

			return
		end

		JumpTools.OpenPageByJump("/challengeRogueTeamSkillTree")
	end)
	arg_11_0:AddBtnListener(arg_11_0.illustratedBtn_, nil, function()
		if not ChallengeRogueTeamData:IsFinishGuide() then
			ShowTips("ROGUE_TEAM_FINISH_GUIDE_THEN_OPEN")

			return
		end

		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedEntrace", {
			templateID = ChallengeRogueTeamData:GetCacheTemplateID()
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.scoreBtn_, nil, function()
		local var_15_0 = ChallengeRogueTeamData:GetCacheTemplateID()

		JumpTools.OpenPageByJump("challengeRogueTeamScorePop", {
			activityId = ChallengeRogueTeamData:GetScoreActivityIDByTemple(var_15_0)
		})

		local var_15_1, var_15_2 = ChallengeRogueTeamTools.GetIsNewScoreReward(var_15_0)

		if var_15_1 then
			ChallengeRogueTeamAction.SetLastScoreId(var_15_0, var_15_2)
			manager.redPoint:setTip(RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD, 0)
		end
	end)
	arg_11_0:AddBtnListener(arg_11_0.startBtn_, nil, function()
		local var_16_0 = ChallengeRogueTeamData:GetCacheTemplateID()

		ChallengeRogueTeamData:ModifyAllHeroInfo(var_16_0)
		ChallengeRogueTeamAction.GotoRogueTeamSystem()
	end)
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0.pointBtnView_:RefreshUI()
	arg_17_0.exitPlayingView_:RefreshUI()
	arg_17_0:OnExitPlaying()
	arg_17_0:RefreshMutiReward()
end

function var_0_0.OnExitPlaying(arg_18_0)
	local var_18_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	if ChallengeRogueTeamData:GetSelectDifficultyID(var_18_0) == 0 then
		arg_18_0.exitPlayingController_:SetSelectedState("close")

		arg_18_0.btnText_.text = GetTips("ROGUE_TEAM_START")
	else
		arg_18_0.exitPlayingController_:SetSelectedState("open")

		arg_18_0.btnText_.text = GetTips("ROGUE_TEAM_CONTINUE")
	end

	if not ChallengeRogueTeamData:IsFinishGuide() then
		arg_18_0.exitPlayController_:SetSelectedState("ash")
		arg_18_0.taskController_:SetSelectedState("ash")
		arg_18_0.illustratedController_:SetSelectedState("ash")
		arg_18_0.skillController_:SetSelectedState("ash")
	else
		arg_18_0.exitPlayController_:SetSelectedState("normal")
		arg_18_0.taskController_:SetSelectedState("normal")
		arg_18_0.illustratedController_:SetSelectedState("normal")
		arg_18_0.skillController_:SetSelectedState("normal")
	end
end

function var_0_0.RefreshMutiReward(arg_19_0)
	local var_19_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUE_DOUBLE_REWARD_4_4)
	local var_19_1 = var_19_0:IsActivitying()

	arg_19_0.mutiRewardController_:SetSelectedState(tostring(var_19_1))

	arg_19_0.mutiText_.text = GameSetting.rogue_team_multi_reward.value[1]

	if var_19_1 then
		if arg_19_0.timer_ then
			arg_19_0.timer_:Stop()

			arg_19_0.timer_ = nil
		end

		arg_19_0.timer_ = Timer.New(function()
			arg_19_0.mutiTimeText_.text = manager.time:GetLostTimeStr2(var_19_0.stopTime)
		end, 1, -1)

		arg_19_0.timer_:Start()
	end
end

function var_0_0.OnTop(arg_21_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_DESC")
	arg_21_0:RefreshUI()
end

function var_0_0.RefreshBGM(arg_22_0)
	ChallengeRogueTeamTools.PlayAudio("main_audio_id")
end

return var_0_0
