local ChallengeRogueTeamEntraceView = class("ChallengeRogueTeamEntraceView", ReduxView)

function ChallengeRogueTeamEntraceView:UIName()
	return "Widget/System/Activity_Roulike/RogueMainUI"
end

function ChallengeRogueTeamEntraceView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamEntraceView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.pointBtnView_ = ChallengeRogueTeamPointBtn.New(self.pointGo_)
	self.exitPlayingView_ = ChallengeRogueTeamExitPlayingPanel.New(self.exitPlayingGo_)
	self.exitPlayingController_ = self.controllerEx_:GetController("file")
	self.mutiRewardController_ = self.controllerEx_:GetController("muti")
	self.exitPlayController_ = self.exitPlayControllerEx_:GetController("termination")
	self.taskController_ = self.taskControllerEx_:GetController("taskBtn")
	self.illustratedController_ = self.illustratedControllerEx_:GetController("IllustratedBtn")
	self.skillController_ = self.skillControllerEx_:GetController("skillBtn")
	self.pointController_ = self.pointControllerEx_:GetController("pointBtn")
	self.onExitPlayingHandler_ = handler(self, self.OnExitPlaying)
end

function ChallengeRogueTeamEntraceView:OnEnter()
	ChallengeRogueTeamAction.ResetPopWindowCnt()
	ChallengeRogueTeamData:UISetEventIDAnimator()

	self.templateID_ = self.params_.templateID

	self.pointBtnView_:OnEnter(ChallengeRogueTeamData:GetScoreActivityIDByTemple(self.templateID_))
	self:RefreshUI()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_EXIT, self.onExitPlayingHandler_)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTaskActivityID(self.templateID_))))
	manager.redPoint:bindUIandKey(self.scoreBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(self.templateID_))))
	manager.redPoint:bindUIandKey(self.illustratedBtn_.transform, (string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED, self.templateID_)))
	manager.redPoint:bindUIandKey(self.technologyTreeBtn_.transform, (string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, self.templateID_)))
	self:RefreshBGM()
end

function ChallengeRogueTeamEntraceView:OnEnterOver()
	if manager.story:IsStoryPlayed(RogueTeamCfg[self.templateID_].story_id) then
		self:CheckPopView()
	else
		manager.story:StartStoryById(RogueTeamCfg[self.templateID_].story_id, function()
			self:CheckPopView()
		end)
	end
end

function ChallengeRogueTeamEntraceView:CheckPopView()
	if getData("ChallengeRogueEnterPop", tostring(self.templateID_)) == nil then
		self.popTimer_ = FrameTimer.New(function()
			if manager.guide:IsPlaying() then
				return
			end

			JumpTools.OpenPageByJump("challengeRogueTeamEnterPop", {
				activityId = ChallengeRogueTeamData:GetScoreActivityIDByTemple(self.templateID_)
			})
			saveData("ChallengeRogueEnterPop", tostring(self.templateID_), 1)
		end, 30, 1)

		self.popTimer_:Start()
	end
end

function ChallengeRogueTeamEntraceView:OnExit()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetTaskActivityID(self.templateID_))))
	manager.redPoint:unbindUIandKey(self.scoreBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(self.templateID_))))
	manager.redPoint:unbindUIandKey(self.illustratedBtn_.transform, (string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED, self.templateID_)))
	manager.redPoint:unbindUIandKey(self.technologyTreeBtn_.transform, (string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, self.templateID_)))
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_EXIT, self.onExitPlayingHandler_)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.popTimer_ then
		self.popTimer_:Stop()

		self.popTimer_ = nil
	end
end

function ChallengeRogueTeamEntraceView:Dispose()
	self.onExitPlayingHandler_ = nil

	self.pointBtnView_:Dispose()

	self.pointBtnView_ = nil

	self.exitPlayingView_:Dispose()

	self.exitPlayingView_ = nil

	ChallengeRogueTeamEntraceView.super.Dispose(self)
end

function ChallengeRogueTeamEntraceView:AddListeners()
	self:AddBtnListener(self.taskBtn_, nil, function()
		local var_12_0

		if not ChallengeRogueTeamData:IsFinishGuide() then
			ShowTips("ROGUE_TEAM_FINISH_GUIDE_THEN_OPEN")

			do return end

			var_12_0 = {}
		end

		var_12_0.activityId = ChallengeRogueTeamData:GetTaskActivityIDByTemple((ChallengeRogueTeamData:GetCacheTemplateID()))

		JumpTools.OpenPageByJump("challengeRogueTeamRewardPop", var_12_0)
	end)
	self:AddBtnListener(self.technologyTreeBtn_, nil, function()
		if not ChallengeRogueTeamData:IsFinishGuide() then
			ShowTips("ROGUE_TEAM_FINISH_GUIDE_THEN_OPEN")

			return
		end

		JumpTools.OpenPageByJump("/challengeRogueTeamSkillTree")
	end)
	self:AddBtnListener(self.illustratedBtn_, nil, function()
		if not ChallengeRogueTeamData:IsFinishGuide() then
			ShowTips("ROGUE_TEAM_FINISH_GUIDE_THEN_OPEN")

			return
		end

		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedEntrace", {
			templateID = ChallengeRogueTeamData:GetCacheTemplateID()
		})
	end)
	self:AddBtnListener(self.scoreBtn_, nil, function()
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
	self:AddBtnListener(self.startBtn_, nil, function()
		ChallengeRogueTeamData:ModifyAllHeroInfo((ChallengeRogueTeamData:GetCacheTemplateID()))
		ChallengeRogueTeamAction.GotoRogueTeamSystem()
	end)
end

function ChallengeRogueTeamEntraceView:RefreshUI()
	self.pointBtnView_:RefreshUI()
	self.exitPlayingView_:RefreshUI()
	self:OnExitPlaying()
	self:RefreshMutiReward()
end

function ChallengeRogueTeamEntraceView:OnExitPlaying()
	if ChallengeRogueTeamData:GetSelectDifficultyID((ChallengeRogueTeamData:GetCacheTemplateID())) == 0 then
		self.exitPlayingController_:SetSelectedState("close")

		self.btnText_.text = GetTips("ROGUE_TEAM_START")
	else
		self.exitPlayingController_:SetSelectedState("open")

		self.btnText_.text = GetTips("ROGUE_TEAM_CONTINUE")
	end

	if not ChallengeRogueTeamData:IsFinishGuide() then
		self.exitPlayController_:SetSelectedState("ash")
		self.taskController_:SetSelectedState("ash")
		self.illustratedController_:SetSelectedState("ash")
		self.skillController_:SetSelectedState("ash")
	else
		self.exitPlayController_:SetSelectedState("normal")
		self.taskController_:SetSelectedState("normal")
		self.illustratedController_:SetSelectedState("normal")
		self.skillController_:SetSelectedState("normal")
	end
end

function ChallengeRogueTeamEntraceView:RefreshMutiReward()
	local var_19_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUE_DOUBLE_REWARD_4_4)
	local var_19_1 = var_19_0:IsActivitying()

	self.mutiRewardController_:SetSelectedState(tostring(var_19_1))

	self.mutiText_.text = GameSetting.rogue_team_multi_reward.value[1]

	if var_19_1 then
		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		self.timer_ = Timer.New(function()
			self.mutiTimeText_.text = manager.time:GetLostTimeStr2(var_19_0.stopTime)
		end, 1, -1)

		self.timer_:Start()
	end
end

function ChallengeRogueTeamEntraceView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_DESC")
	self:RefreshUI()
end

function ChallengeRogueTeamEntraceView:RefreshBGM()
	ChallengeRogueTeamTools.PlayAudio("main_audio_id")
end

return ChallengeRogueTeamEntraceView
