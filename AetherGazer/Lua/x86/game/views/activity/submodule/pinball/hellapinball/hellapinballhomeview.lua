local var_0_0 = class("HellaPinballHomeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.progressControlller_ = arg_4_0.controllerEx_:GetController("progress")
	arg_4_0.vibeControlller_ = arg_4_0.controllerEx_:GetController("vibe")
	arg_4_0.newSkillController_ = arg_4_0.controllerEx_:GetController("newSkill")
	arg_4_0.tabController_ = arg_4_0.controllerEx_:GetController("tab")
	arg_4_0.modeController_ = arg_4_0.controllerEx_:GetController("mode")
	arg_4_0.talkBubbleController_ = arg_4_0.controllerEx_:GetController("talkBubble")
	arg_4_0.bossController_ = arg_4_0.controllerEx_:GetController("boss")
	arg_4_0.storyController_ = arg_4_0.storyControllerEx_:GetController("status")
	arg_4_0.challengeController_ = arg_4_0.challengeControllerEx_:GetController("status")
	arg_4_0.bubbleController_ = arg_4_0.controllerEx_:GetController("talkBubble")
	arg_4_0.skillItemList_ = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = arg_4_0["skillItem" .. iter_4_0 .. "_"]
		local var_4_1 = HellaPinballSkillItem.New(var_4_0)

		table.insert(arg_4_0.skillItemList_, var_4_1)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.chapterBtn_, nil, function()
		JumpTools.OpenPageByJump("pinballChapterSelectPop")
	end)
	arg_5_0:AddBtnListener(arg_5_0.skillBtn_, nil, function()
		PinballBridge.ShowBackGroundMask(true)
		JumpTools.OpenPageByJump("/pinballHero", {
			roleID = arg_5_0.selectRole_
		})
		PinballBridge.PlayTimelineWithCallBack("skill_stand", function()
			PinballBridge.SetPlayerAniState("skill_stand")
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		if arg_5_0.selectTypeTab_ == 1 then
			local var_9_0, var_9_1 = PinballData:GetStageUnlocked(arg_5_0.selectStage_)
			local var_9_2 = PinballStageCfg[arg_5_0.selectStage_].barrier_id

			if var_9_0 then
				TimelineTools.StopAllCallBack()

				if PinballStageCfg[arg_5_0.selectStage_].barrier_type == 2 then
					PinballAction.OpenBattle(arg_5_0.selectStage_)
				else
					manager.story:CheckBattleStory(var_9_2, manager.story.BEFORE, function()
						PinballAction.PlayPinballGame(arg_5_0.selectStage_, arg_5_0.selectRole_)
						manager.story:RemovePlayer()
					end)
				end
			else
				ShowTips(var_9_1)
			end
		else
			PinballAction.PlayPinballChallengeGame(PinballData:GetChallengeStageID(), arg_5_0.selectRole_)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/hellaPinballLimitTask", {
			activityID = arg_5_0.limitTaskActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.progressRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/hellaPinballTask")
	end)
	arg_5_0:AddBtnListener(arg_5_0.storyTabBtn_, nil, function()
		if arg_5_0.selectTypeTab_ == 1 then
			return
		end

		arg_5_0.selectTypeTab_ = 1

		arg_5_0:UpdateData()
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.challengeTabBtn_, nil, function()
		if arg_5_0.selectTypeTab_ == 2 then
			return
		end

		arg_5_0.selectTypeTab_ = 2

		arg_5_0:UpdateData()
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/pinballRank")
	end)
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.selectRole_ = PinballData:GetRoleID()
	arg_16_0.canTick = true
	arg_16_0.isChange_ = false
	PinballAction.CanPlayGuide = false

	arg_16_0:PopBubble(false)
	arg_16_0:UpdateData()

	if arg_16_0.params_.isEnter then
		PinballBridge.SetPlayerAniState("home_stand_s")

		if arg_16_0.params_.isEnterHome then
			if arg_16_0.hasPassAllStage_ then
				arg_16_0.selectTypeTab_ = 2
			else
				arg_16_0.selectTypeTab_ = 1
			end

			arg_16_0.params_.isEnterHome = nil
		end
	end

	SetActive(arg_16_0.tipsGo_, false)
	arg_16_0:StopTimer()
	arg_16_0:AddTimer()
	arg_16_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_17_0)
	local var_17_0 = PinballData:GetActivityID()

	arg_17_0.limitTaskActivityID_ = ActivityCfg[arg_17_0.activityID_].sub_activity_list[2]
	arg_17_0.newUnlockSkillKey = RedPointConst.HELLA_PINBALL_NEW_UNLOCK_SKILL .. var_17_0
	arg_17_0.taskGroup = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_17_0)
	arg_17_0.limitTaskGroup = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_17_0.limitTaskActivityID_)

	local var_17_1 = manager.redPoint:getTipValue(arg_17_0.newUnlockSkillKey) > 0

	manager.redPoint:bindUIandKey(arg_17_0.rewardBtn_.transform, arg_17_0.limitTaskGroup)
	manager.redPoint:bindUIandKey(arg_17_0.progressRewardBtn_.transform, arg_17_0.taskGroup)
	manager.redPoint:SetRedPointIndependent(arg_17_0.skillBtn_.transform, var_17_1, nil, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.UnBindRedPoint(arg_18_0)
	manager.redPoint:unBindUIandKey(arg_18_0.rewardBtn_.transform, arg_18_0.limitTaskGroup)
	manager.redPoint:unBindUIandKey(arg_18_0.progressRewardBtn_.transform, arg_18_0.taskGroup)
end

function var_0_0.OnEnterOver(arg_19_0)
	arg_19_0:RefreshUI()
	arg_19_0:RefreshVibeController()
	PinballBridge.ShowBackGroundMask(false)
end

function var_0_0.UpdateData(arg_20_0)
	arg_20_0.selectStage_ = PinballData:GetLastEnterStageCategory()
	arg_20_0.progress_ = PinballData:GetStageFinishProgress()
	arg_20_0.roleLevel_ = PinballData:GetRoleLevel(arg_20_0.selectRole_)
	arg_20_0.chapterList_ = PinballData:GetDisplayStageList()
	arg_20_0.selectIndex_ = table.indexof(arg_20_0.chapterList_, arg_20_0.selectStage_) or 1
	arg_20_0.rewardActivityID_ = PinballData:GetRewardActivityID()
	arg_20_0.activityID_ = PinballData:GetActivityID()
	arg_20_0.extraEquipSkill_ = PinballData:GetEquipedActiveSkill()
	arg_20_0.unLockChallenge_ = arg_20_0.progress_ >= 1
	arg_20_0.challengePoint_ = PinballData:GetMaxChallengeScore()
	arg_20_0.hasPassAllStage_ = PinballData:HasPassAllStage()
end

function var_0_0.RefreshUI(arg_21_0)
	arg_21_0.chapterText_.text = PinballStageCfg[arg_21_0.selectStage_].name
	arg_21_0.progressSlider_.value = arg_21_0.progress_
	arg_21_0.progressText_.text = math.floor(arg_21_0.progress_ * 100) .. "%"
	arg_21_0.levelText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), arg_21_0.roleLevel_)
	arg_21_0.stageDesc_.text = PinballStageCfg[arg_21_0.selectStage_].barrier_desc

	for iter_21_0 = 1, 2 do
		local var_21_0 = arg_21_0.extraEquipSkill_[iter_21_0]
		local var_21_1 = arg_21_0.skillItemList_[iter_21_0]

		var_21_1:SetData(iter_21_0, var_21_0)
		var_21_1:RefreshUI()
	end

	arg_21_0.isBossStage_, arg_21_0.bossType_ = PinballData:IsBossStage(arg_21_0.selectStage_)

	arg_21_0.bossController_:SetSelectedState(tostring(arg_21_0.IsBossStage_))
	arg_21_0.tabController_:SetSelectedState(tostring(arg_21_0.unLockChallenge_))

	if arg_21_0.selectTypeTab_ == 1 then
		arg_21_0.modeController_:SetSelectedState("story")
		arg_21_0.storyController_:SetSelectedState("select")
		arg_21_0.challengeController_:SetSelectedState("normal")
	else
		arg_21_0.modeController_:SetSelectedState("challenge")
		arg_21_0.challengeController_:SetSelectedState("select")
		arg_21_0.storyController_:SetSelectedState("normal")

		arg_21_0.challengePointText_.text = arg_21_0.challengePoint_
	end
end

function var_0_0.ChangeVibe(arg_22_0, arg_22_1)
	local var_22_0
	local var_22_1

	if arg_22_1 then
		var_22_0 = PinballData:GetTargetStageFinishProgress(arg_22_1)
		var_22_1 = arg_22_0.progress_
	else
		var_22_0 = PinballData:GetTargetStageFinishProgress(arg_22_0.selectStage_)
		var_22_1 = getData("PinBallGame", "progress") or 0
	end

	if var_22_0 < 0.5 then
		if var_22_1 >= 0.5 then
			arg_22_0.isChange_ = true
		end

		if not arg_22_1 and PinballData:GetStageFinishProgress() < 0.42 then
			arg_22_0.progressControlller_:SetSelectedState("yellow")
		end

		if arg_22_0.progress_ < 1 then
			arg_22_0.vibeControlller_:SetSelectedState("vibe01")
		end

		if arg_22_0.selectIndex_ >= 2 then
			arg_22_0.bubbleIndex_ = 1
		end
	elseif var_22_0 < 0.75 then
		if var_22_1 < 0.5 or var_22_1 >= 0.75 then
			arg_22_0.isChange_ = true
		end

		if not arg_22_1 and PinballData:GetStageFinishProgress() < 0.66 then
			arg_22_0.progressControlller_:SetSelectedState("orange")
		end

		if arg_22_0.progress_ < 1 then
			arg_22_0.vibeControlller_:SetSelectedState("vibe02")
		end

		arg_22_0.bubbleIndex_ = 2
	elseif var_22_0 <= 1 then
		if var_22_1 < 0.75 or var_22_1 > 1 then
			arg_22_0.isChange_ = true
		end

		if not arg_22_1 and PinballData:GetStageFinishProgress() > 0.66 then
			arg_22_0.progressControlller_:SetSelectedState("red")
		end

		if arg_22_0.progress_ < 1 then
			arg_22_0.vibeControlller_:SetSelectedState("vibe03")
		end

		arg_22_0.bubbleIndex_ = 3
	end

	if PinballData:HasPassAllStage() then
		if not arg_22_1 and PinballData:GetStageFinishProgress() == 1 then
			arg_22_0.progressControlller_:SetSelectedState("green")
		end

		arg_22_0.vibeControlller_:SetSelectedState("vibe04")

		arg_22_0.bubbleIndex_ = 4
	end

	arg_22_0.canTick = true

	arg_22_0:UpdateBar()

	arg_22_0.triggerBubbleTime = 0
end

function var_0_0.RefreshVibeController(arg_23_0)
	local var_23_0 = getData("PinBallGame", "progress") or 0
	local var_23_1 = PinballData:GetTargetStageFinishProgress(arg_23_0.selectStage_)

	local function var_23_2()
		PinballBridge.PlayTimelineWithCallBack("home_stand")
		arg_23_0.animator_:Play("Activity_Hel_HomeUI", -1, 0)
		manager.audio:PlayEffect("minigame_activity_4_6", "minigame_activity_4_6_marble_finish", "")

		local var_24_0 = 0.2 * arg_23_0.progress_

		Timer.New(function()
			manager.audio:PlayEffect("minigame_activity_4_6", "minigame_activity_4_6_finish_stop", "")
		end, var_24_0, 1):Start()
		arg_23_0.animator_:Update(0)

		arg_23_0.pushCallBackTimer_ = Timer.New(function()
			arg_23_0:ChangeVibe()
			arg_23_0:CheckActiveSkillUnlock()
			arg_23_0:UpdateBar()

			arg_23_0.canTick = true
		end, 0.5, 1):Start()

		saveData("PinBallGame", "progress", arg_23_0.progress_)
	end

	print("self.progress_" .. var_23_1 .. "oldProgress" .. var_23_0)

	if arg_23_0.progress_ ~= var_23_0 then
		if arg_23_0.progress_ == 1 then
			SetActive(arg_23_0.tipsGo_, true)
			PinballBridge.SetEndDefaultHomeBg()
			PinballBridge.PlayBgPushAnimator(false, true)
			var_23_2()

			PinballAction.CanPlayGuide = false
			arg_23_0.finishCallBackTimer_ = Timer.New(function()
				PinballAction.CanPlayGuide = true
			end, 1.5, 1):Start()
		else
			arg_23_0.isChange_ = false

			if var_23_1 < 0.5 then
				if var_23_0 >= 0.5 then
					arg_23_0.isChange_ = true
				end
			elseif var_23_1 < 0.75 then
				if var_23_0 < 0.42 or var_23_0 >= 0.75 then
					arg_23_0.isChange_ = true
				end
			elseif var_23_1 < 1 then
				if var_23_0 < 0.66 or var_23_0 > 1 then
					arg_23_0.isChange_ = true
				end
			elseif var_23_0 < 0.66 then
				arg_23_0.isChange_ = true
			end

			if arg_23_0.isChange_ then
				PinballBridge.SetEndDefaultHomeBg()
			end

			arg_23_0:PlayPushAni(var_23_0, var_23_2)
		end
	else
		PinballBridge.SetDefaultHomeBg()
		arg_23_0:ChangeVibe()
		arg_23_0:CheckActiveSkillUnlock()
	end
end

function var_0_0.CheckActiveSkillUnlock(arg_28_0)
	if (getData("Hella_Pinball", "Unlock_Active_Skill") or -1) > 0 then
		if not manager.guide:IsPlaying() then
			arg_28_0.needPopUnlock_ = true

			return
		end

		JumpTools.OpenPageByJump("hellaPinballActiveSkillUnlockPop")
	end
end

function var_0_0.PlayChangeAni(arg_29_0, arg_29_1, arg_29_2)
	arg_29_2()
end

function var_0_0.PlayPushAni(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:PopBubble(false)

	arg_30_0.canTick = false
	PinballAction.CanPlayGuide = false

	manager.windowBar:HideBar()
	arg_30_0.animator_:Play("billboard_P", -1, 0)
	arg_30_0.animator_:Update(0)

	arg_30_0.pushBgCallBackTimer_ = Timer.New(function()
		PinballBridge.PlayBgPushAnimator(arg_30_0.isChange_)
	end, 1, 1):Start()

	PinballBridge.PlayTimelineWithCallBack("home_move", arg_30_2)
end

function var_0_0.OnTop(arg_32_0)
	local var_32_0 = PinballData:GetLastEnterStageCategory()

	arg_32_0:UpdateBar()

	if var_32_0 ~= arg_32_0.selectStage_ then
		arg_32_0.isChange_ = false
		arg_32_0.progress_ = PinballData:GetTargetStageFinishProgress(arg_32_0.selectStage_)

		arg_32_0:ChangeVibe(var_32_0)
		PinballBridge.PlayBgChangeAniWithTarget(var_32_0, arg_32_0.isChange_)

		if arg_32_0.isChange_ then
			arg_32_0:PopBubble(false)

			arg_32_0.canTick = false

			arg_32_0.animator_:Play("billboard_P", -1, 0)
			manager.windowBar:HideBar()
			arg_32_0.animator_:Update(0)
			PinballBridge.PlayBgPushAnimator(arg_32_0.isChange_)
			PinballBridge.PlayTimelineWithCallBack("home_move", function()
				PinballBridge.PlayTimelineWithCallBack("home_stand")
				arg_32_0.animator_:Play("Activity_Hel_HomeUI", -1, 0)
				arg_32_0.animator_:Update(0)
				manager.audio:PlayEffect("minigame_activity_4_6", "minigame_activity_4_6_marble_finish", "")

				local var_33_0 = 0.2 * arg_32_0.progress_

				Timer.New(function()
					manager.audio:PlayEffect("minigame_activity_4_6", "minigame_activity_4_6_finish_stop", "")
				end, var_33_0, 1):Start()

				arg_32_0.pushCallBackTimer_ = Timer.New(function()
					arg_32_0:ChangeVibe(var_32_0)
					arg_32_0:UpdateBar()

					arg_32_0.canTick = true
					PinballAction.CanPlayGuide = true
				end, 1.5, 1):Start()
			end)
		end
	end

	arg_32_0:UpdateData()
	arg_32_0:RefreshUI()
end

function var_0_0.UpdateBar(arg_36_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_36_0:StopTimer()
		TimelineTools.StopAllCallBack()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		if ActivityData:GetActivityData(ActivityConst.ACTIVITY_HELLA_PINBALL_TASK).stopTime >= manager.time:GetServerTime() then
			local var_37_0 = ActivityTools.GetActivityTheme(arg_36_0.activityID_)
			local var_37_1 = ActivityEntraceCfg.get_id_list_by_theme[var_37_0][1]
			local var_37_2 = ActivityEntraceCfg[var_37_1].jump_system
			local var_37_3 = SystemLinkCfg[var_37_2[1]].link
			local var_37_4 = var_37_2[2]

			subActivityID = ActivityVersionData:GetSelectActivityID(var_37_4)

			OpenPageUntilLoaded(var_37_3, {
				activityID = var_37_4,
				subActivityID = subActivityID
			})
		end
	end)
	manager.windowBar:RegistInfoCallBack(function()
		local var_38_0 = GetTips("PINBALLGAME_GAME_ENTRANCE_TITLE")

		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = var_38_0
		})
	end)
end

function var_0_0.OnExit(arg_39_0)
	TimelineTools.StopAllCallBack()
	PinballBridge.SetPlayerAniState("home_stand")
	arg_39_0:StopTimer()
	manager.windowBar:HideBar()
end

function var_0_0.AddTimer(arg_40_0)
	local var_40_0 = ActivityData:GetActivityData(arg_40_0.rewardActivityID_)

	arg_40_0.startTime_ = var_40_0.startTime
	arg_40_0.stopTime_ = var_40_0.stopTime

	local var_40_1 = PinballData:GetActivityID()

	arg_40_0.rankActivityID_ = ActivityCfg[var_40_1].sub_activity_list[1]
	arg_40_0.rankStopTime_ = ActivityData:GetActivityData(arg_40_0.rankActivityID_).stopTime

	arg_40_0:RefreshTimeText()

	arg_40_0.triggerBubbleTime = 0

	SetActive(arg_40_0.rewardBtn_.transform.gameObject, manager.time:GetServerTime() <= arg_40_0.stopTime_)
	SetActive(arg_40_0.rankBtn_.transform.gameObject, manager.time:GetServerTime() <= arg_40_0.rankStopTime_)

	arg_40_0.timer_ = Timer.New(function()
		if not manager.guide:IsPlaying() and arg_40_0.needPopUnlock_ then
			arg_40_0.needPopUnlock_ = false

			JumpTools.OpenPageByJump("hellaPinballActiveSkillUnlockPop")
		end

		if arg_40_0.canTick and not manager.guide:IsPlaying() then
			arg_40_0.triggerBubbleTime = arg_40_0.triggerBubbleTime + 1
		end

		if arg_40_0.triggerBubbleTime == 7 then
			arg_40_0:PopBubble(true)
		end

		if arg_40_0.triggerBubbleTime == 10 then
			arg_40_0:PopBubble(false)

			arg_40_0.triggerBubbleTime = 0
		end

		SetActive(arg_40_0.rankBtn_.transform.gameObject, manager.time:GetServerTime() <= arg_40_0.rankStopTime_)
		SetActive(arg_40_0.rewardBtn_.transform.gameObject, manager.time:GetServerTime() <= arg_40_0.stopTime_)
		arg_40_0:RefreshTimeText()
	end, 1, -1)

	arg_40_0.timer_:Start()
end

function var_0_0.PopBubble(arg_42_0, arg_42_1)
	if arg_42_1 then
		local var_42_0
		local var_42_1 = math.random(1, 2)

		if (arg_42_0.bubbleIndex_ or 1) <= 3 then
			var_42_0 = GameSetting.marbles_barrier_chat.value[arg_42_0.bubbleIndex_ or 1][var_42_1]
		else
			var_42_0 = GameSetting.marbles_barrier_final_chat.value[1]
		end

		arg_42_0.bubbleText_.text = var_42_0

		arg_42_0.bubbleController_:SetSelectedState("show")
	else
		arg_42_0.bubbleController_:SetSelectedState("hide")
	end
end

function var_0_0.StopTimer(arg_43_0)
	if arg_43_0.timer_ then
		arg_43_0.timer_:Stop()

		arg_43_0.timer_ = nil
	end

	if arg_43_0.pushCallBackTimer_ then
		arg_43_0.pushCallBackTimer_:Stop()

		arg_43_0.pushCallBackTimer_ = nil
	end

	if arg_43_0.pushBgCallBackTimer_ then
		arg_43_0.pushBgCallBackTimer_:Stop()

		arg_43_0.pushBgCallBackTimer_ = nil
	end

	if arg_43_0.finishCallBackTimer_ then
		arg_43_0.finishCallBackTimer_:Stop()

		arg_43_0.finishCallBackTimer_ = nil
	end
end

function var_0_0.RefreshTimeText(arg_44_0)
	if arg_44_0.timeText_ then
		arg_44_0.timeText_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStr2(arg_44_0.stopTime_, nil, true))
	end
end

function var_0_0.Dispose(arg_45_0)
	arg_45_0.super.Dispose(arg_45_0)
	arg_45_0:StopTimer()

	for iter_45_0, iter_45_1 in pairs(arg_45_0.skillItemList_) do
		iter_45_1:Dispose()
	end

	if PinballBridge.hasSceneLoaded then
		PinballBridge:UnLoadScene()
	end

	TimelineTools.StopAllCallBack()
end

return var_0_0
