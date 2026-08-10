ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("RogueCardGameMainView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_MainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.skinCon_ = arg_3_0.skinDLCController_:GetController("state")
	arg_3_0.onRefreshDLCHandler = handler(arg_3_0, arg_3_0.OnRefreshDLC)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		local var_5_0 = ActivityToggleCfg.get_id_list_by_activity_id[arg_4_0.activityID_][1]

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetI18NText(ActivityToggleCfg[var_5_0].desc)
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_ROGUECARD_TASK
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.dlcBtn_, nil, function()
		JumpTools.OpenPageByJump("rogueCardGameSkinDLCPopView")
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		local var_8_0 = RogueCardGameData:GetChallengeBattleId()

		if var_8_0 and tonumber(var_8_0) > 0 then
			RogueCardGameAction.GetStageSaveDataJumpChallenge(var_8_0, 2)
		end

		local var_8_1 = PlayerData:GetStoryList()
		local var_8_2 = GameSetting.rogue_card_start_story.value[1]

		if var_8_1[var_8_2] then
			JumpTools.OpenPageByJump("/rogueCardGameHomeView", {
				isHome = true
			})
		else
			manager.story:StartStoryById(var_8_2, function(arg_9_0)
				JumpTools.OpenPageByJump("/rogueCardGameHomeView", {
					isHome = true
				})
			end, false)
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	var_0_0.super.OnEnter(arg_10_0)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_10_0.onRefreshDLCHandler)
	manager.redPoint:bindUIandKey(arg_10_0.rewardBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK)
	manager.redPoint:bindUIandKey(arg_10_0.goBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_5_0 .. ActivityConst.ACTIVITY_ROGUECARD_5_0)
	manager.redPoint:bindUIandKey(arg_10_0.dlcBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	arg_10_0:BindRedPoint()
	arg_10_0:RefreshView()
end

function var_0_0.RefreshTimeText(arg_11_0)
	if arg_11_0.timeText_ then
		arg_11_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_11_0.stopTime_, true)
	end
end

function var_0_0.RefreshView(arg_12_0)
	arg_12_0:AddTimer()
	arg_12_0:RefreshDLCState()
end

function var_0_0.RefreshDLCState(arg_13_0)
	local var_13_0 = ActivityConst.ACTIVITY_ROGUECARD_SKIN
	local var_13_1 = AssignmentCfg.get_id_list_by_activity_id[var_13_0] or {}
	local var_13_2 = 0
	local var_13_3 = false

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_4 = TaskData2:GetTaskProgress(iter_13_1)
		local var_13_5 = TaskData2:GetTaskComplete(iter_13_1)
		local var_13_6 = var_13_4 >= AssignmentCfg[iter_13_1].need

		if var_13_5 then
			var_13_2 = var_13_2 + 1
		elseif var_13_6 then
			var_13_3 = true
		end
	end

	if var_13_2 == 2 then
		arg_13_0.skinCon_:SetSelectedIndex(2)
	elseif var_13_3 then
		arg_13_0.skinCon_:SetSelectedIndex(1)
	else
		arg_13_0.skinCon_:SetSelectedIndex(0)
	end
end

function var_0_0.OnRefreshDLC(arg_14_0)
	arg_14_0:RefreshDLCState()
end

function var_0_0.AddTimer(arg_15_0)
	arg_15_0:taskStopTimer()

	local var_15_0 = ActivityConst.ACTIVITY_ROGUECARD_TASK
	local var_15_1 = ActivityData:GetActivityData(var_15_0)
	local var_15_2 = ActivityConst.ACTIVITY_ROGUECARD_SKIN
	local var_15_3 = ActivityData:GetActivityData(var_15_2)

	arg_15_0.taskTimeText_.text = manager.time:GetLostTimeStr(var_15_1.stopTime, true)
	arg_15_0.skinTimeText_.text = manager.time:GetLostTimeStr(var_15_3.stopTime, true)
	arg_15_0.tasktimer_ = Timer.New(function()
		arg_15_0.taskTimeText_.text = manager.time:GetLostTimeStr(var_15_1.stopTime, true)
		arg_15_0.skinTimeText_.text = manager.time:GetLostTimeStr(var_15_3.stopTime, true)
	end, 1, -1)

	arg_15_0.tasktimer_:Start()
end

function var_0_0.taskStopTimer(arg_17_0)
	if arg_17_0.tasktimer_ then
		arg_17_0.tasktimer_:Stop()

		arg_17_0.tasktimer_ = nil
	end
end

function var_0_0.UpdateBar(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Show(arg_19_0, arg_19_1)
	SetActive(arg_19_0.gameObject_, arg_19_1)

	if arg_19_1 then
		arg_19_0:UpdatePreview()
		arg_19_0:RefreshView()
	end
end

function var_0_0.BindRedPoint(arg_20_0)
	return
end

function var_0_0.UnBindRedPoint(arg_21_0)
	return
end

function var_0_0.OnTop(arg_22_0)
	arg_22_0:UpdateBar()
end

function var_0_0.OnExit(arg_23_0)
	manager.redPoint:unbindUIandKey(arg_23_0.rewardBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK)
	manager.redPoint:unbindUIandKey(arg_23_0.goBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_5_0 .. ActivityConst.ACTIVITY_ROGUECARD_5_0)
	manager.redPoint:unbindUIandKey(arg_23_0.dlcBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_23_0.onRefreshDLCHandler)
	arg_23_0:taskStopTimer()
	arg_23_0:UnBindRedPoint()
	var_0_0.super.OnExit(arg_23_0)
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
