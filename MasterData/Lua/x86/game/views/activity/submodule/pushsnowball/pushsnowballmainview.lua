local PushSnowBallMainView = class("PushSnowBallMainView", ReduxView)

function PushSnowBallMainView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballMainUI"
end

function PushSnowBallMainView:UIParent()
	return manager.ui.uiMain.transform
end

function PushSnowBallMainView:GetActivityID()
	return PushSnowBallData:GetActivityID()
end

function PushSnowBallMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PushSnowBallMainView:InitUI()
	self:BindCfgUI()
end

function PushSnowBallMainView:AddUIListener()
	self:AddBtnListener(self.signalBtn_, nil, function()
		if self:IsActivityTime() then
			PushSnowBallData:SetGoViewStr("/pushSnowBallSingle")
			DormMinigame.Launch("HZ07_tuanxue1")
		end
	end)
	self:AddBtnListener(self.teamBtn_, nil, function()
		if self:IsActivityTime() then
			PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
			DormMinigame.Launch("HZ07_tuanxue1")
		end
	end)
	self:AddBtnListener(self.tutorialBtn_, nil, function()
		if self:IsActivityTime() then
			JumpTools.OpenPageByJump("pushSnowBallTutorial")
		end
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SNOWBALL_PUSH_DESC_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SNOWBALL_PUSH_DESC_1")
		})
	end)
end

function PushSnowBallMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PushSnowBallMainView:OnEnter()
	manager.redPoint:bindUIandKey(self.signalBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetSingleActivityID()), PushSnowBallData:GetSingleActivityID()))
	manager.redPoint:bindUIandKey(self.teamBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetTeamActivityID()), PushSnowBallData:GetTeamActivityID()))
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = PushSnowBallData:GetActivityID()

	local var_12_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_12_0.startTime
	self.stopTime_ = var_12_0.stopTime

	if not getData("PushSnowBall", "pop" .. PlayerData:GetPlayerInfo().userID) and self:IsActivityTime() then
		JumpTools.OpenPageByJump("pushSnowBallTutorial")
		saveData("PushSnowBall", "pop" .. PlayerData:GetPlayerInfo().userID, true)
	end

	self:AddTimer()
end

function PushSnowBallMainView:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function PushSnowBallMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PushSnowBallMainView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	end
end

function PushSnowBallMainView:IsActivityTime()
	if manager.time:GetServerTime() < self.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(self.startTime_, nil, true)))

		return false
	end

	if manager.time:GetServerTime() >= self.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function PushSnowBallMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.signalBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetSingleActivityID()), PushSnowBallData:GetSingleActivityID()))
	manager.redPoint:unbindUIandKey(self.teamBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetTeamActivityID()), PushSnowBallData:GetTeamActivityID()))
	self:StopTimer()
	manager.windowBar:HideBar()
end

return PushSnowBallMainView
