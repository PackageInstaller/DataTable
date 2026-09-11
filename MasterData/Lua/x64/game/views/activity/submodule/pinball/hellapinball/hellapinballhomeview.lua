local HellaPinballHomeView = class("HellaPinballHomeView", ReduxView)

function HellaPinballHomeView:UIName()
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_HomeUI"
end

function HellaPinballHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaPinballHomeView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
end

function HellaPinballHomeView:InitUI()
	self.progressControlller_ = self.controllerEx_:GetController("progress")
	self.vibeControlller_ = self.controllerEx_:GetController("vibe")
	self.newSkillController_ = self.controllerEx_:GetController("newSkill")
	self.tabController_ = self.controllerEx_:GetController("tab")
	self.modeController_ = self.controllerEx_:GetController("mode")
	self.talkBubbleController_ = self.controllerEx_:GetController("talkBubble")
	self.bossController_ = self.controllerEx_:GetController("boss")
	self.storyController_ = self.storyControllerEx_:GetController("status")
	self.challengeController_ = self.challengeControllerEx_:GetController("status")
	self.bubbleController_ = self.controllerEx_:GetController("talkBubble")
	self.skillItemList_ = {}

	for iter_4_0 = 1, 2 do
		table.insert(self.skillItemList_, (HellaPinballSkillItem.New(self["skillItem" .. iter_4_0 .. "_"])))
	end
end

function HellaPinballHomeView:AddUIListener()
	self:AddBtnListener(self.chapterBtn_, nil, function()
		JumpTools.OpenPageByJump("pinballChapterSelectPop")
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		PinballBridge.ShowBackGroundMask(true)
		JumpTools.OpenPageByJump("/pinballHero", {
			roleID = self.selectRole_
		})
		PinballBridge.PlayTimelineWithCallBack("skill_stand", function()
			PinballBridge.SetPlayerAniState("skill_stand")
		end)
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if self.selectTypeTab_ == 1 then
			local var_9_0, var_9_1 = PinballData:GetStageUnlocked(self.selectStage_)

			if var_9_0 then
				TimelineTools.StopAllCallBack()

				if PinballStageCfg[self.selectStage_].barrier_type == 2 then
					PinballAction.OpenBattle(self.selectStage_)
				else
					manager.story:CheckBattleStory(PinballStageCfg[self.selectStage_].barrier_id, manager.story.BEFORE, function()
						PinballAction.PlayPinballGame(self.selectStage_, self.selectRole_)
						manager.story:RemovePlayer()
					end)
				end
			else
				ShowTips(var_9_1)
			end
		else
			PinballAction.PlayPinballChallengeGame(PinballData:GetChallengeStageID(), self.selectRole_)
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/hellaPinballLimitTask", {
			activityID = self.limitTaskActivityID_
		})
	end)
	self:AddBtnListener(self.progressRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/hellaPinballTask")
	end)
	self:AddBtnListener(self.storyTabBtn_, nil, function()
		if self.selectTypeTab_ == 1 then
			return
		end

		self.selectTypeTab_ = 1

		self:UpdateData()
		self:RefreshUI()
	end)
	self:AddBtnListener(self.challengeTabBtn_, nil, function()
		if self.selectTypeTab_ == 2 then
			return
		end

		self.selectTypeTab_ = 2

		self:UpdateData()
		self:RefreshUI()
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/pinballRank")
	end)
end

function HellaPinballHomeView:OnEnter()
	self.selectRole_ = PinballData:GetRoleID()
	self.canTick = true
	self.isChange_ = false
	PinballAction.CanPlayGuide = false

	self:PopBubble(false)
	self:UpdateData()

	if self.params_.isEnter then
		PinballBridge.SetPlayerAniState("home_stand_s")

		if self.params_.isEnterHome then
			self.selectTypeTab_ = self.hasPassAllStage_ and 2 or 1
			self.params_.isEnterHome = nil
		end
	end

	SetActive(self.tipsGo_, false)
	self:StopTimer()
	self:AddTimer()
	self:BindRedPoint()
end

function HellaPinballHomeView:BindRedPoint()
	local var_17_0 = PinballData:GetActivityID()

	self.limitTaskActivityID_ = ActivityCfg[self.activityID_].sub_activity_list[2]
	self.newUnlockSkillKey = RedPointConst.HELLA_PINBALL_NEW_UNLOCK_SKILL .. var_17_0
	self.taskGroup = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_17_0)
	self.limitTaskGroup = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.limitTaskActivityID_)

	local var_17_1 = manager.redPoint:getTipValue(self.newUnlockSkillKey) > 0

	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, self.limitTaskGroup)
	manager.redPoint:bindUIandKey(self.progressRewardBtn_.transform, self.taskGroup)
	manager.redPoint:SetRedPointIndependent(self.skillBtn_.transform, var_17_1, nil, RedPointStyle.SHOW_NEW_TAG)
end

function HellaPinballHomeView:UnBindRedPoint()
	manager.redPoint:unBindUIandKey(self.rewardBtn_.transform, self.limitTaskGroup)
	manager.redPoint:unBindUIandKey(self.progressRewardBtn_.transform, self.taskGroup)
end

function HellaPinballHomeView:OnEnterOver()
	self:RefreshUI()
	self:RefreshVibeController()
	PinballBridge.ShowBackGroundMask(false)
end

function HellaPinballHomeView:UpdateData()
	self.selectStage_ = PinballData:GetLastEnterStageCategory()
	self.progress_ = PinballData:GetStageFinishProgress()
	self.roleLevel_ = PinballData:GetRoleLevel(self.selectRole_)
	self.chapterList_ = PinballData:GetDisplayStageList()
	self.selectIndex_ = table.indexof(self.chapterList_, self.selectStage_) or 1
	self.rewardActivityID_ = PinballData:GetRewardActivityID()
	self.activityID_ = PinballData:GetActivityID()
	self.extraEquipSkill_ = PinballData:GetEquipedActiveSkill()
	self.unLockChallenge_ = self.progress_ >= 1
	self.challengePoint_ = PinballData:GetMaxChallengeScore()
	self.hasPassAllStage_ = PinballData:HasPassAllStage()
end

function HellaPinballHomeView:RefreshUI()
	self.chapterText_.text = PinballStageCfg[self.selectStage_].name
	self.progressSlider_.value = self.progress_
	self.progressText_.text = math.floor(self.progress_ * 100) .. "%"
	self.levelText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), self.roleLevel_)
	self.stageDesc_.text = PinballStageCfg[self.selectStage_].barrier_desc

	for iter_21_0 = 1, 2 do
		self.skillItemList_[iter_21_0]:SetData(iter_21_0, self.extraEquipSkill_[iter_21_0])
		self.skillItemList_[iter_21_0]:RefreshUI()
	end

	self.isBossStage_, self.bossType_ = PinballData:IsBossStage(self.selectStage_)

	self.bossController_:SetSelectedState(tostring(self.IsBossStage_))
	self.tabController_:SetSelectedState(tostring(self.unLockChallenge_))

	if self.selectTypeTab_ == 1 then
		self.modeController_:SetSelectedState("story")
		self.storyController_:SetSelectedState("select")
		self.challengeController_:SetSelectedState("normal")
	else
		self.modeController_:SetSelectedState("challenge")
		self.challengeController_:SetSelectedState("select")
		self.storyController_:SetSelectedState("normal")

		self.challengePointText_.text = self.challengePoint_
	end
end

function HellaPinballHomeView:ChangeVibe(arg_22_1)
	local var_22_0
	local var_22_1

	if arg_22_1 then
		var_22_0 = PinballData:GetTargetStageFinishProgress(arg_22_1)
		var_22_1 = self.progress_
	else
		var_22_0 = PinballData:GetTargetStageFinishProgress(self.selectStage_)
		var_22_1 = getData("PinBallGame", "progress") or 0
	end

	if var_22_0 < 0.5 then
		if var_22_1 >= 0.5 then
			self.isChange_ = true
		end

		if not arg_22_1 and PinballData:GetStageFinishProgress() < 0.42 then
			self.progressControlller_:SetSelectedState("yellow")
		end

		if self.progress_ < 1 then
			self.vibeControlller_:SetSelectedState("vibe01")
		end

		if self.selectIndex_ >= 2 then
			self.bubbleIndex_ = 1
		end
	elseif var_22_0 < 0.75 then
		if var_22_1 < 0.5 or var_22_1 >= 0.75 then
			self.isChange_ = true
		end

		if not arg_22_1 and PinballData:GetStageFinishProgress() < 0.66 then
			self.progressControlller_:SetSelectedState("orange")
		end

		if self.progress_ < 1 then
			self.vibeControlller_:SetSelectedState("vibe02")
		end

		self.bubbleIndex_ = 2
	elseif var_22_0 <= 1 then
		if var_22_1 < 0.75 or var_22_1 > 1 then
			self.isChange_ = true
		end

		if not arg_22_1 and PinballData:GetStageFinishProgress() > 0.66 then
			self.progressControlller_:SetSelectedState("red")
		end

		if self.progress_ < 1 then
			self.vibeControlller_:SetSelectedState("vibe03")
		end

		self.bubbleIndex_ = 3
	end

	if PinballData:HasPassAllStage() then
		if not arg_22_1 and PinballData:GetStageFinishProgress() == 1 then
			self.progressControlller_:SetSelectedState("green")
		end

		self.vibeControlller_:SetSelectedState("vibe04")

		self.bubbleIndex_ = 4
	end

	self.canTick = true

	self:UpdateBar()

	self.triggerBubbleTime = 0
end

function HellaPinballHomeView:RefreshVibeController()
	local var_23_0 = getData("PinBallGame", "progress") or 0
	local var_23_1 = PinballData:GetTargetStageFinishProgress(self.selectStage_)

	local function var_23_2()
		PinballBridge.PlayTimelineWithCallBack("home_stand")
		self.animator_:Play("Activity_Hel_HomeUI", -1, 0)
		manager.audio:PlayEffect("minigame_activity_4_6", "minigame_activity_4_6_marble_finish", "")
		Timer.New(function()
			manager.audio:PlayEffect("minigame_activity_4_6", "minigame_activity_4_6_finish_stop", "")
		end, 0.2 * self.progress_, 1):Start()
		self.animator_:Update(0)

		self.pushCallBackTimer_ = Timer.New(function()
			self:ChangeVibe()
			self:CheckActiveSkillUnlock()
			self:UpdateBar()

			self.canTick = true
		end, 0.5, 1):Start()

		saveData("PinBallGame", "progress", self.progress_)
	end

	print("self.progress_" .. var_23_1 .. "oldProgress" .. var_23_0)

	if self.progress_ ~= var_23_0 then
		if self.progress_ == 1 then
			SetActive(self.tipsGo_, true)
			PinballBridge.SetEndDefaultHomeBg()
			PinballBridge.PlayBgPushAnimator(false, true)
			var_23_2()

			PinballAction.CanPlayGuide = false
			self.finishCallBackTimer_ = Timer.New(function()
				PinballAction.CanPlayGuide = true
			end, 1.5, 1):Start()
		else
			self.isChange_ = false

			if var_23_1 < 0.5 then
				if var_23_0 >= 0.5 then
					self.isChange_ = true
				end
			elseif var_23_1 < 0.75 then
				if var_23_0 < 0.42 or var_23_0 >= 0.75 then
					self.isChange_ = true
				end
			elseif var_23_1 < 1 then
				if var_23_0 < 0.66 or var_23_0 > 1 then
					self.isChange_ = true
				end
			elseif var_23_0 < 0.66 then
				self.isChange_ = true
			end

			if self.isChange_ then
				PinballBridge.SetEndDefaultHomeBg()
			end

			self:PlayPushAni(var_23_0, var_23_2)
		end
	else
		PinballBridge.SetDefaultHomeBg()
		self:ChangeVibe()
		self:CheckActiveSkillUnlock()
	end
end

function HellaPinballHomeView:CheckActiveSkillUnlock()
	if (getData("Hella_Pinball", "Unlock_Active_Skill") or -1) > 0 then
		if not manager.guide:IsPlaying() then
			self.needPopUnlock_ = true

			return
		end

		JumpTools.OpenPageByJump("hellaPinballActiveSkillUnlockPop")
	end
end

function HellaPinballHomeView:PlayChangeAni(arg_29_1, arg_29_2)
	arg_29_2()
end

function HellaPinballHomeView:PlayPushAni(arg_30_1, arg_30_2)
	self:PopBubble(false)

	self.canTick = false
	PinballAction.CanPlayGuide = false

	manager.windowBar:HideBar()
	self.animator_:Play("billboard_P", -1, 0)
	self.animator_:Update(0)

	self.pushBgCallBackTimer_ = Timer.New(function()
		PinballBridge.PlayBgPushAnimator(self.isChange_)
	end, 1, 1):Start()

	PinballBridge.PlayTimelineWithCallBack("home_move", arg_30_2)
end

function HellaPinballHomeView:OnTop()
	local var_32_0 = PinballData:GetLastEnterStageCategory()

	self:UpdateBar()

	if var_32_0 ~= self.selectStage_ then
		self.isChange_ = false
		self.progress_ = PinballData:GetTargetStageFinishProgress(self.selectStage_)

		self:ChangeVibe(var_32_0)
		PinballBridge.PlayBgChangeAniWithTarget(var_32_0, self.isChange_)

		if self.isChange_ then
			self:PopBubble(false)

			self.canTick = false

			self.animator_:Play("billboard_P", -1, 0)
			manager.windowBar:HideBar()
			self.animator_:Update(0)
			PinballBridge.PlayBgPushAnimator(self.isChange_)
			PinballBridge.PlayTimelineWithCallBack("home_move", function()
				PinballBridge.PlayTimelineWithCallBack("home_stand")
				self.animator_:Play("Activity_Hel_HomeUI", -1, 0)
				self.animator_:Update(0)
				manager.audio:PlayEffect("minigame_activity_4_6", "minigame_activity_4_6_marble_finish", "")
				Timer.New(function()
					manager.audio:PlayEffect("minigame_activity_4_6", "minigame_activity_4_6_finish_stop", "")
				end, 0.2 * self.progress_, 1):Start()

				self.pushCallBackTimer_ = Timer.New(function()
					self:ChangeVibe(var_32_0)
					self:UpdateBar()

					self.canTick = true
					PinballAction.CanPlayGuide = true
				end, 1.5, 1):Start()
			end)
		end
	end

	self:UpdateData()
	self:RefreshUI()
end

function HellaPinballHomeView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:StopTimer()
		TimelineTools.StopAllCallBack()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		if ActivityData:GetActivityData(ActivityConst.ACTIVITY_HELLA_PINBALL_TASK).stopTime >= manager.time:GetServerTime() then
			local var_37_0 = ActivityEntraceCfg[ActivityEntraceCfg.get_id_list_by_theme[ActivityTools.GetActivityTheme(self.activityID_)][1]].jump_system

			subActivityID = ActivityVersionData:GetSelectActivityID(var_37_0[2])

			OpenPageUntilLoaded(SystemLinkCfg[var_37_0[1]].link, {
				activityID = var_37_0[2],
				subActivityID = subActivityID
			})
		end
	end)
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("PINBALLGAME_GAME_ENTRANCE_TITLE")
		})
	end)
end

function HellaPinballHomeView:OnExit()
	TimelineTools.StopAllCallBack()
	PinballBridge.SetPlayerAniState("home_stand")
	self:StopTimer()
	manager.windowBar:HideBar()
end

function HellaPinballHomeView:AddTimer()
	local var_40_0 = ActivityData:GetActivityData(self.rewardActivityID_)

	self.startTime_ = var_40_0.startTime
	self.stopTime_ = var_40_0.stopTime
	self.rankActivityID_ = ActivityCfg[PinballData:GetActivityID()].sub_activity_list[1]
	self.rankStopTime_ = ActivityData:GetActivityData(self.rankActivityID_).stopTime

	self:RefreshTimeText()

	self.triggerBubbleTime = 0

	SetActive(self.rewardBtn_.transform.gameObject, manager.time:GetServerTime() <= self.stopTime_)
	SetActive(self.rankBtn_.transform.gameObject, manager.time:GetServerTime() <= self.rankStopTime_)

	self.timer_ = Timer.New(function()
		if not manager.guide:IsPlaying() and self.needPopUnlock_ then
			self.needPopUnlock_ = false

			JumpTools.OpenPageByJump("hellaPinballActiveSkillUnlockPop")
		end

		if self.canTick and not manager.guide:IsPlaying() then
			self.triggerBubbleTime = self.triggerBubbleTime + 1
		end

		if self.triggerBubbleTime == 7 then
			self:PopBubble(true)
		end

		if self.triggerBubbleTime == 10 then
			self:PopBubble(false)

			self.triggerBubbleTime = 0
		end

		SetActive(self.rankBtn_.transform.gameObject, manager.time:GetServerTime() <= self.rankStopTime_)
		SetActive(self.rewardBtn_.transform.gameObject, manager.time:GetServerTime() <= self.stopTime_)
		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function HellaPinballHomeView:PopBubble(arg_42_1)
	if arg_42_1 then
		self.bubbleText_.text = (self.bubbleIndex_ or 1) <= 3 and GameSetting.marbles_barrier_chat.value[self.bubbleIndex_ or 1][math.random(1, 2)] or GameSetting.marbles_barrier_final_chat.value[1]

		self.bubbleController_:SetSelectedState("show")
	else
		self.bubbleController_:SetSelectedState("hide")
	end
end

function HellaPinballHomeView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.pushCallBackTimer_ then
		self.pushCallBackTimer_:Stop()

		self.pushCallBackTimer_ = nil
	end

	if self.pushBgCallBackTimer_ then
		self.pushBgCallBackTimer_:Stop()

		self.pushBgCallBackTimer_ = nil
	end

	if self.finishCallBackTimer_ then
		self.finishCallBackTimer_:Stop()

		self.finishCallBackTimer_ = nil
	end
end

function HellaPinballHomeView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStr2(self.stopTime_, nil, true))
	end
end

function HellaPinballHomeView:Dispose()
	self.super.Dispose(self)
	self:StopTimer()

	for iter_45_0, iter_45_1 in pairs(self.skillItemList_) do
		iter_45_1:Dispose()
	end

	if PinballBridge.hasSceneLoaded then
		PinballBridge:UnLoadScene()
	end

	TimelineTools.StopAllCallBack()
end

return HellaPinballHomeView
