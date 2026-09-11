ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SimBusinessEnterView = class("SimBusinessEnterView", ActivityMainBasePanel)

function SimBusinessEnterView:GetUIName()
	return SimBusinessTools.GetMainUIName(SimBusinessData.activityID)
end

function SimBusinessEnterView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function SimBusinessEnterView:OnEnter()
	SimBusinessEnterView.super.OnEnter(self)
	self:BindRedPoint()
end

function SimBusinessEnterView:OnExit()
	SimBusinessEnterView.super.OnExit(self)
	self:UnbindRedPoint()
end

function SimBusinessEnterView:AddUIListener()
	self:AddBtnListenerScale(self.enterBtn_, nil, function()
		local var_6_0 = SimBusinessTools.GetDefaultEnterDailyLevel()
		local var_6_1, var_6_2 = SimBusinessTools.CheckLevelUnlock(var_6_0)

		if var_6_1 then
			SimBusinessBridge.EnterLevel(var_6_0)
		else
			ShowTips(var_6_2)
		end
	end)
	self:AddBtnListenerScale(self.infoBtn_, nil, SimBusinessTools.OpenGameTips)
end

function SimBusinessEnterView:UpdateBar()
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

	if var_8_0 < var_8_1.startTime then
		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_1.startTime, true))
	elseif var_8_1.stopTime < var_8_0 then
		return GetTips("TIME_OVER")
	else
		return manager.time:GetLostTimeStrWith2Unit(var_8_1.stopTime)
	end
end

function SimBusinessEnterView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = var_0_1(SimBusinessData.activityID)
	end
end

local function var_0_2()
	return ActivityTools.GetRedPointKey(SimBusinessData.activityID) .. SimBusinessData.activityID
end

function SimBusinessEnterView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.enterBtn_.transform, var_0_2())
end

function SimBusinessEnterView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.enterBtn_.transform, var_0_2())
end

return SimBusinessEnterView
