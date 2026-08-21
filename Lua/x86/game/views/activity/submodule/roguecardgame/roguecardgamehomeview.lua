local var_0_0 = class("RogueCardGameHomeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.challengeCon_ = arg_4_0.challengeController_:GetController("Challenge")
	arg_4_0.stateCon_ = arg_4_0.stateController_:GetController("state")
	arg_4_0.skinCon_ = arg_4_0.skinController_:GetController("state")
	arg_4_0.items_ = {}
	arg_4_0.onRefreshDLCHandler = handler(arg_4_0, arg_4_0.OnRefreshDLC)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.forumBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameForumView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_ROGUECARD_TASK
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("rogueCardGameSkinDLCPopView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.recordBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameIllustratedView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.challengeBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameChallengeSelectView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.challengeLock_, nil, function()
		local var_11_0 = GetI18NText(ConditionCfg[1270101].desc)

		ShowTips(var_11_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.illustratedBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameRecordView")
	end)
end

function var_0_0.StopUpdateTimer(arg_13_0)
	if arg_13_0.updateTimer then
		arg_13_0.updateTimer:Stop()

		arg_13_0.updateTimer = nil
	end
end

function var_0_0.UpdateTimeTxt(arg_14_0)
	local var_14_0 = os.time()
	local var_14_1 = os.difftime(var_14_0, os.time(os.date("!*t", var_14_0)))
	local var_14_2 = os.date("!*t", var_14_0 + var_14_1)

	arg_14_0.dayText_.text = string.format("%s/%s", var_14_2.month, var_14_2.day)
	arg_14_0.timeText_.text = manager.time:GetTwelveHourClockTimeText()
end

function var_0_0.OnEnter(arg_15_0)
	var_0_0.super.OnEnter(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.rewardBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK)
	manager.redPoint:bindUIandKey(arg_15_0.illustratedBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_RESIDENT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_5_0)
	manager.redPoint:bindUIandKey(arg_15_0.skinBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_15_0.onRefreshDLCHandler)
	manager.redPoint:bindUIandKey(arg_15_0.recordBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED)
	arg_15_0:IsOpenGuide()
	arg_15_0:BindRedPoint()

	if arg_15_0.params_.isHome then
		arg_15_0.progressAnim_.enabled = true

		local var_15_0 = arg_15_0.playableGo_.playableAsset

		if arg_15_0.playableGo_ and var_15_0 then
			TimelineTools.PlayTimelineWithCallback(arg_15_0.playableGo_, var_15_0, function()
				arg_15_0.forumBtn_.enabled = true
				arg_15_0.rewardBtn_.enabled = true
				arg_15_0.skinBtn_.enabled = true
				arg_15_0.recordBtn_.enabled = true
				arg_15_0.challengeBtn_.enabled = true
				arg_15_0.challengeLock_.enabled = true
				arg_15_0.illustratedBtn_.enabled = true
			end)
		end

		arg_15_0.playableGo_:Play()
		arg_15_0:BtnTimer()

		arg_15_0.params_.isHome = nil
	else
		arg_15_0.progressAnim_.enabled = false
		arg_15_0.forumBtn_.enabled = true
		arg_15_0.rewardBtn_.enabled = true
		arg_15_0.skinBtn_.enabled = true
		arg_15_0.recordBtn_.enabled = true
		arg_15_0.challengeBtn_.enabled = true
		arg_15_0.challengeLock_.enabled = true
		arg_15_0.illustratedBtn_.enabled = true
	end

	arg_15_0:RefreshView()
end

function var_0_0.BtnTimer(arg_17_0)
	arg_17_0:StopBtnTimer()

	arg_17_0.btnTimer = FrameTimer.New(function()
		arg_17_0.forumBtn_.enabled = false
		arg_17_0.rewardBtn_.enabled = false
		arg_17_0.skinBtn_.enabled = false
		arg_17_0.recordBtn_.enabled = false
		arg_17_0.challengeBtn_.enabled = false
		arg_17_0.challengeLock_.enabled = false
		arg_17_0.illustratedBtn_.enabled = false

		arg_17_0:StopBtnTimer()
	end, 3, -1)

	arg_17_0.btnTimer:Start()
end

function var_0_0.StopBtnTimer(arg_19_0)
	if arg_19_0.btnTimer then
		arg_19_0.btnTimer:Stop()

		arg_19_0.btnTimer = nil
	end
end

function var_0_0.IsOpenGuide(arg_20_0)
	arg_20_0:StopTimer()

	arg_20_0.openingTimer = FrameTimer.New(function()
		if manager.guide:IsPlaying() then
			arg_20_0.playableGo_.enabled = false
		else
			arg_20_0.playableGo_.enabled = true

			arg_20_0:StopTimer()
		end
	end, 1, -1)

	arg_20_0.openingTimer:Start()
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.openingTimer then
		arg_22_0.openingTimer:Stop()

		arg_22_0.openingTimer = nil
	end
end

function var_0_0.RefreshView(arg_23_0)
	if RogueCardGameTools.IsCompleteForum() then
		arg_23_0.challengeCon_:SetSelectedIndex(1)
	else
		arg_23_0.challengeCon_:SetSelectedIndex(0)
	end

	local var_23_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ROGUECARD_5_0]
	local var_23_1 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_ROGUECARD_5_0)

	arg_23_0.recordNum_.text = var_23_1 .. "/" .. #var_23_0

	arg_23_0:AddTimer()
	arg_23_0:RefreshDLCState()
end

function var_0_0.RefreshDLCState(arg_24_0)
	local var_24_0 = ActivityConst.ACTIVITY_ROGUECARD_SKIN
	local var_24_1 = AssignmentCfg.get_id_list_by_activity_id[var_24_0] or {}
	local var_24_2 = 0
	local var_24_3 = false

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		local var_24_4 = TaskData2:GetTaskProgress(iter_24_1)
		local var_24_5 = TaskData2:GetTaskComplete(iter_24_1)
		local var_24_6 = var_24_4 >= AssignmentCfg[iter_24_1].need

		if var_24_5 then
			var_24_2 = var_24_2 + 1
		elseif var_24_6 then
			var_24_3 = true
		end
	end

	if var_24_2 == 2 then
		arg_24_0.skinCon_:SetSelectedIndex(2)
	elseif var_24_3 then
		arg_24_0.skinCon_:SetSelectedIndex(1)
	else
		arg_24_0.skinCon_:SetSelectedIndex(0)
	end
end

function var_0_0.OnRefreshDLC(arg_25_0)
	arg_25_0:RefreshDLCState()
end

function var_0_0.AddTimer(arg_26_0)
	arg_26_0:taskStopTimer()

	local var_26_0 = ActivityConst.ACTIVITY_ROGUECARD_TASK
	local var_26_1 = ActivityData:GetActivityData(var_26_0)
	local var_26_2 = ActivityConst.ACTIVITY_ROGUECARD_SKIN
	local var_26_3 = ActivityData:GetActivityData(var_26_2)

	arg_26_0.taskTimeText_.text = manager.time:GetLostTimeStr(var_26_1.stopTime, true)
	arg_26_0.skinTimeText_.text = manager.time:GetLostTimeStr(var_26_3.stopTime, true)

	SetActive(arg_26_0.rewardGo_, var_26_1.stopTime >= manager.time:GetServerTime())
	SetActive(arg_26_0.dlcGo_, var_26_3.stopTime >= manager.time:GetServerTime())

	arg_26_0.tasktimer_ = Timer.New(function()
		arg_26_0.taskTimeText_.text = manager.time:GetLostTimeStr(var_26_1.stopTime, true)
		arg_26_0.skinTimeText_.text = manager.time:GetLostTimeStr(var_26_3.stopTime, true)
	end, 1, -1)

	arg_26_0.tasktimer_:Start()
end

function var_0_0.taskStopTimer(arg_28_0)
	if arg_28_0.tasktimer_ then
		arg_28_0.tasktimer_:Stop()

		arg_28_0.tasktimer_ = nil
	end
end

function var_0_0.UpdateBar(arg_29_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.BindRedPoint(arg_30_0)
	return
end

function var_0_0.UnBindRedPoint(arg_31_0)
	return
end

function var_0_0.OnTop(arg_32_0)
	arg_32_0.forumBtn_.enabled = true
	arg_32_0.rewardBtn_.enabled = true
	arg_32_0.skinBtn_.enabled = true
	arg_32_0.recordBtn_.enabled = true
	arg_32_0.challengeBtn_.enabled = true
	arg_32_0.challengeLock_.enabled = true
	arg_32_0.illustratedBtn_.enabled = true

	arg_32_0:UpdateTimeTxt()
	arg_32_0:StopUpdateTimer()

	arg_32_0.updateTimer = Timer.New(function()
		arg_32_0:UpdateTimeTxt()
	end, 1, -1)

	arg_32_0.updateTimer:Start()
	arg_32_0:UpdateBar()
end

function var_0_0.OnExit(arg_34_0)
	manager.redPoint:unbindUIandKey(arg_34_0.rewardBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK)
	manager.redPoint:unbindUIandKey(arg_34_0.illustratedBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_RESIDENT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_5_0)
	manager.redPoint:unbindUIandKey(arg_34_0.skinBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_34_0.onRefreshDLCHandler)
	manager.redPoint:unbindUIandKey(arg_34_0.recordBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_ILLUSTRATED)
	manager.windowBar:HideBar()
	TimelineTools.StopAllCallBack()
	arg_34_0:taskStopTimer()
	arg_34_0:StopUpdateTimer()
	arg_34_0:StopTimer()
	arg_34_0:StopBtnTimer()
	arg_34_0:UnBindRedPoint()
	var_0_0.super.OnExit(arg_34_0)
end

function var_0_0.Dispose(arg_35_0)
	arg_35_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_35_0)
end

return var_0_0
