local var_0_0 = class("OsirisPlayGameEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_ChapterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.items_ = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = OsirisPlayGameChapterItem.New(arg_4_0["itemGo_" .. iter_4_0], iter_4_0)

		arg_4_0.items_[iter_4_0] = var_4_0
	end

	arg_4_0.challengeCon_ = arg_4_0.challengeCtrl_:GetController("Challenge")
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_GENERALITY_DESC")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityID_ = arg_6_0.params_.activityID_

	arg_6_0:RefreshStory()
	arg_6_0:RefreshUI()
	arg_6_0:RefreshChallenge()
	arg_6_0:RefreshItems()

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		local var_6_0 = RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK

		manager.redPoint:bindUIandKey(arg_6_0.limitRewardBtn_.transform, var_6_0)
	end

	local var_6_1 = RedPointConst.OSIRIS_PLAY_GAME_LEVEL_REWARD .. "_" .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME

	manager.redPoint:bindUIandKey(arg_6_0.recordBtn_.transform, var_6_1)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/osirisPlayGameLimitRewardView", {
			activityID = ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.recordBtn_, nil, function()
		JumpTools.OpenPageByJump("/osirisPlayGameBattleRecordView", {
			activityID = arg_7_0.activityID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.challengeBtn_, nil, function()
		if OsirisPlayGameData:IsPassStagesByStageId(5260163) then
			JumpTools.OpenPageByJump("/osirisPlayGameChallegeStageView", {
				activityID_ = arg_7_0.activityID_
			})
		else
			ShowTips("CAPTURE_GAME_PRE_SECTION_UNREACHED")
		end
	end)
end

function var_0_0.RefreshStory(arg_11_0)
	local var_11_0 = GameSetting.activity_generality_start_story.value[1]

	if OsirisPlayGameData:GetPlayStory(var_11_0) ~= 1 then
		manager.story:StartStory(var_11_0)
		OsirisPlayGameData:SetPlayStory(var_11_0)
	end
end

function var_0_0.RefreshChallenge(arg_12_0)
	local var_12_0 = OsirisPlayGameData:IsPassStagesByStageId(5260163)

	arg_12_0.challengeAnim_:Play("UI_Challenge_cx", -1, 0)
	arg_12_0.challengeAnim_:Update(0)

	arg_12_0.firstUnlockChapterId = OsirisPlayGameData:GetFirstUnlock()

	if arg_12_0.firstUnlockChapterId == 7 then
		arg_12_0.challengeCon_:SetSelectedIndex(0)

		arg_12_0.challengeTimer_ = Timer.New(function()
			arg_12_0:ChallengeStopTimer_()
			arg_12_0.challengeCon_:SetSelectedIndex(1)
			arg_12_0.challengeAnim_:Play("UI_Challenge_cx_01", -1, 0)
			arg_12_0.challengeAnim_:Update(0)
			OsirisPlayGameData:SetFirstUnlock(0)
		end, 0.5, 1)

		arg_12_0.challengeTimer_:Start()
	else
		arg_12_0.challengeCon_:SetSelectedIndex(var_12_0 and 1 or 0)
	end
end

function var_0_0.ChallengeStopTimer_(arg_14_0)
	if arg_14_0.challengeTimer_ then
		arg_14_0.challengeTimer_:Stop()

		arg_14_0.challengeTimer_ = nil
	end
end

function var_0_0.RefreshUI(arg_15_0)
	local var_15_0 = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[arg_15_0.activityID_][1]]

	if var_15_0 and var_15_0.name ~= "" and arg_15_0.titleTxt_ then
		arg_15_0.titleTxt_.text = GetI18NText(var_15_0.name)
	end

	arg_15_0.curLv_, arg_15_0.maxLv_ = arg_15_0:GetLevelInfo()
	arg_15_0.recordNumTxt_.text = arg_15_0.curLv_ .. "/" .. arg_15_0.maxLv_

	arg_15_0:RefreshLimitTime()
end

function var_0_0.GetLevelInfo(arg_16_0)
	local var_16_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_16_0.activityID_]

	return OsirisPlayGameData:GetNum(), #var_16_0
end

function var_0_0.RefreshLimitTime(arg_17_0)
	local var_17_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK) then
		SetActive(arg_17_0.limitRewardBtn_.gameObject, true)

		arg_17_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_17_0.stopTime)
	else
		SetActive(arg_17_0.limitRewardBtn_.gameObject, false)
	end

	if arg_17_0.timer_ == nil then
		arg_17_0.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(arg_17_0.activityID_) then
				arg_17_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_17_0.stopTime)
			else
				if manager.time:GetServerTime() < var_17_0.startTime then
					arg_17_0.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_17_0.startTime))
				elseif manager.time:GetServerTime() > var_17_0.stopTime then
					arg_17_0.limitTimeTxt_.text = GetTips("TIME_OVER")
				end

				SetActive(arg_17_0.limitRewardBtn_, false)
			end
		end, 1, -1)
	end

	arg_17_0.timer_:Start()
end

function var_0_0.RefreshItems(arg_19_0)
	for iter_19_0 = 1, #arg_19_0.items_ do
		arg_19_0.items_[iter_19_0]:RefreshView()
	end
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:StopTimer()
	manager.windowBar:HideBar()
	arg_21_0:ChallengeStopTimer_()

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		local var_21_0 = RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK

		manager.redPoint:unbindUIandKey(arg_21_0.limitRewardBtn_.transform, var_21_0)
	end

	local var_21_1 = RedPointConst.OSIRIS_PLAY_GAME_LEVEL_REWARD .. "_" .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME

	manager.redPoint:unbindUIandKey(arg_21_0.recordBtn_.transform, var_21_1)
	var_0_0.super.OnExit(arg_21_0)
end

function var_0_0.Dispose(arg_22_0)
	for iter_22_0 = 1, #arg_22_0.items_ do
		arg_22_0.items_[iter_22_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
