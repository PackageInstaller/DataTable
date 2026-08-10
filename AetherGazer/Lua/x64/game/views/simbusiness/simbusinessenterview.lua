ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SimBusinessEnterView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return SimBusinessTools.GetMainUIName(SimBusinessData.activityID)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0:BindRedPoint()
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
	arg_4_0:UnbindRedPoint()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.enterBtn_, nil, function()
		local var_6_0 = SimBusinessTools.GetDefaultEnterDailyLevel()
		local var_6_1, var_6_2 = SimBusinessTools.CheckLevelUnlock(var_6_0)

		if var_6_1 then
			SimBusinessBridge.EnterLevel(var_6_0)
		else
			ShowTips(var_6_2)
		end
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.infoBtn_, nil, SimBusinessTools.OpenGameTips)
end

function var_0_0.UpdateBar(arg_7_0)
	local var_7_0 = SimBusinessData:GetSimBusinessFundItemID()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_7_0
	})
	manager.windowBar:SetBarCanClick(var_7_0, true)
end

local function var_0_1(arg_8_0)
	local var_8_0 = manager.time:GetServerTime()
	local var_8_1 = ActivityData:GetActivityData(arg_8_0)
	local var_8_2 = var_8_1.startTime
	local var_8_3 = var_8_1.stopTime

	if var_8_0 < var_8_2 then
		local var_8_4 = GetTips("OPEN_TIME")

		return string.format(var_8_4, manager.time:GetLostTimeStrWith2Unit(var_8_2, true))
	elseif var_8_3 < var_8_0 then
		return GetTips("TIME_OVER")
	else
		return manager.time:GetLostTimeStrWith2Unit(var_8_3)
	end
end

function var_0_0.RefreshTimeText(arg_9_0)
	if arg_9_0.timeText_ then
		arg_9_0.timeText_.text = var_0_1(SimBusinessData.activityID)
	end
end

local function var_0_2()
	local var_10_0 = SimBusinessData.activityID

	return ActivityTools.GetRedPointKey(var_10_0) .. var_10_0
end

function var_0_0.BindRedPoint(arg_11_0)
	manager.redPoint:bindUIandKey(arg_11_0.enterBtn_.transform, var_0_2())
end

function var_0_0.UnbindRedPoint(arg_12_0)
	manager.redPoint:unbindUIandKey(arg_12_0.enterBtn_.transform, var_0_2())
end

return var_0_0
