local var_0_0 = class("PushSnowBallMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.GetActivityID(arg_3_0)
	return PushSnowBallData:GetActivityID()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.signalBtn_, nil, function()
		if arg_6_0:IsActivityTime() then
			PushSnowBallData:SetGoViewStr("/pushSnowBallSingle")
			DormMinigame.Launch("HZ07_tuanxue1")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.teamBtn_, nil, function()
		if arg_6_0:IsActivityTime() then
			PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
			DormMinigame.Launch("HZ07_tuanxue1")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.tutorialBtn_, nil, function()
		if arg_6_0:IsActivityTime() then
			JumpTools.OpenPageByJump("pushSnowBallTutorial")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.descBtn_, nil, function()
		local var_10_0 = GetTips("ACTIVITY_SNOWBALL_PUSH_DESC_1")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SNOWBALL_PUSH_DESC_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_10_0
		})
	end)
end

function var_0_0.UpdateBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_12_0)
	manager.redPoint:bindUIandKey(arg_12_0.signalBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetSingleActivityID()), PushSnowBallData:GetSingleActivityID()))
	manager.redPoint:bindUIandKey(arg_12_0.teamBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetTeamActivityID()), PushSnowBallData:GetTeamActivityID()))
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_12_0.activityID_ = PushSnowBallData:GetActivityID()

	local var_12_0 = ActivityData:GetActivityData(arg_12_0.activityID_)

	arg_12_0.startTime_ = var_12_0.startTime
	arg_12_0.stopTime_ = var_12_0.stopTime

	if not getData("PushSnowBall", "pop" .. PlayerData:GetPlayerInfo().userID) and arg_12_0:IsActivityTime() then
		JumpTools.OpenPageByJump("pushSnowBallTutorial")
		saveData("PushSnowBall", "pop" .. PlayerData:GetPlayerInfo().userID, true)
	end

	arg_12_0:AddTimer()
end

function var_0_0.AddTimer(arg_13_0)
	arg_13_0:StopTimer()
	arg_13_0:RefreshTimeText()

	arg_13_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_13_0.stopTime_ then
			return
		end

		arg_13_0:RefreshTimeText()
	end, 1, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeText(arg_16_0)
	if arg_16_0.timeText_ then
		arg_16_0.timeText_.text = manager.time:GetLostTimeStr2(arg_16_0.stopTime_, nil, true)
	end
end

function var_0_0.IsActivityTime(arg_17_0)
	if manager.time:GetServerTime() < arg_17_0.startTime_ then
		local var_17_0 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_17_0, manager.time:GetLostTimeStr2(arg_17_0.startTime_, nil, true)))

		return false
	end

	if manager.time:GetServerTime() >= arg_17_0.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function var_0_0.OnExit(arg_18_0)
	manager.redPoint:unbindUIandKey(arg_18_0.signalBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetSingleActivityID()), PushSnowBallData:GetSingleActivityID()))
	manager.redPoint:unbindUIandKey(arg_18_0.teamBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetTeamActivityID()), PushSnowBallData:GetTeamActivityID()))
	arg_18_0:StopTimer()
	manager.windowBar:HideBar()
end

return var_0_0
