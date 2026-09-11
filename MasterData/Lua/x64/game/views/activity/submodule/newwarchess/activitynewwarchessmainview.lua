ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityNewWarChessMainView = class("ActivityNewWarChessMainView", ActivityMainBasePanel)

function ActivityNewWarChessMainView:GetUIName()
	if self.activityID_ == ActivityConst.ACTIVITY_NEWWARCHESS_2_6 then
		return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionNewWarChessUI"
	elseif self.activityID_ == ActivityConst.ACTIVITY_2_10_NEWWARCHESS then
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10NewWarChessUI"
	end
end

function ActivityNewWarChessMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityNewWarChessMainView:InitUI()
	self:BindCfgUI()

	self.taskListModule = CommonActivityTaskListModule.New(self.taskPanelTrans_.gameObject)
end

function ActivityNewWarChessMainView:AddUIListeners()
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = NewChessTools.GetNewWarChessGameSetting("new_warchess_describe", NewWarChessData:GetCurrentMainActivity())
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("activityNewWarChessRewardView", {
			mainActivityID = self.activityID_,
			activityIDList = ActivityCfg[self.activityID_].sub_activity_list
		})
	end)
	self:AddBtnListener(self.levelBtn_, nil, function()
		manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. self.activityID_, 0)
		JumpTools.OpenPageByJump("/newWarChessLevelView", {
			ActivityID = self.activityID_
		})
	end)
end

function ActivityNewWarChessMainView:OnEnter()
	self.taskListModule:OnEnter()
	self:RefreshUI()
	self:BindRedPoint()
end

function ActivityNewWarChessMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.levelBtn_.transform, RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. self.activityID_)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. self.activityID_)
end

function ActivityNewWarChessMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.levelBtn_.transform, RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. self.activityID_)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. self.activityID_)
end

function ActivityNewWarChessMainView:RefreshUI()
	self:RefreshTime()
	self:RefreshTask()
end

function ActivityNewWarChessMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityNewWarChessMainView:RefreshTime()
	self.activityID_ = self.activityID_
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	if manager.time:GetServerTime() < self.stopTime_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
	else
		self:StopTimer()

		self.timeText_.text = GetTips("TIME_OVER")
	end

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() < self.stopTime_ then
			self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
		else
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")
		end
	end, 1, -1)

	self.timer_:Start()
end

function ActivityNewWarChessMainView:RefreshTask()
	self.taskListModule:RenderView(self.activityID_)
end

function ActivityNewWarChessMainView:Show(arg_16_1)
	ActivityNewWarChessMainView.super.Show(self, arg_16_1)

	if arg_16_1 then
		self:RefreshTask()
	end
end

function ActivityNewWarChessMainView:UpdateBar()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE]) do
		if ItemCfg[iter_17_1].time[2][1] == self.activityID_ then
			table.insert(var_17_0, iter_17_1)
		end
	end

	local var_17_1 = {
		BACK_BAR,
		HOME_BAR
	}

	for iter_17_2, iter_17_3 in pairs(var_17_0) do
		table.insert(var_17_1, iter_17_3)
	end

	manager.windowBar:SwitchBar(var_17_1)

	for iter_17_4, iter_17_5 in pairs(var_17_0) do
		manager.windowBar:SetBarCanAdd(iter_17_5, true)
	end
end

function ActivityNewWarChessMainView:OnExit()
	self.taskListModule:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:UnBindRedPoint()
end

function ActivityNewWarChessMainView:Dispose()
	self.taskListModule:Dispose()
	self:StopTimer()
	self:RemoveAllListeners()

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.super.Dispose(self)
end

return ActivityNewWarChessMainView
