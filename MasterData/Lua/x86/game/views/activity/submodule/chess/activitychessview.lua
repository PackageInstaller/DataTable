local ActivityChessView = class("ActivityChessView", ReduxView)

function ActivityChessView:UIName()
	return ActivityTools.GetUIName(self.params_.activityID)
end

function ActivityChessView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityChessView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function ActivityChessView:AddUIListener()
	self:AddBtnListener(self.buttonBtn_, nil, function()
		for iter_5_0, iter_5_1 in ipairs(ActivityCfg.get_id_list_by_activity_theme[ActivityCfg[self.activityID_].activity_theme]) do
			if ActivityCfg[iter_5_1].activity_template == ActivityConst.SUBMODULE_TYPE.TALENT_TREE then
				ActivityTools.JumpToSubmodulePage(iter_5_1)

				return
			end
		end

		error("不存在对应的天赋界面")
	end)
end

function ActivityChessView:InitBtns()
	if not self.chessView_ then
		self.chessView_ = {}

		for iter_6_0, iter_6_1 in ipairs(WarchessLevelCfg.get_id_list_by_type[self.activityID_]) do
			self.chessView_[iter_6_1] = self:GetChessItemView().New(self[string.format("goStage%s_", iter_6_0)], iter_6_1)
		end
	end
end

function ActivityChessView:GetChessItemView()
	return ActivityChessItem
end

function ActivityChessView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = self.params_.activityID

	self:InitBtns()

	for iter_8_0, iter_8_1 in pairs(self.chessView_) do
		iter_8_1:OnEnter()
	end

	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()
end

function ActivityChessView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()

	for iter_9_0, iter_9_1 in pairs(self.chessView_) do
		iter_9_1:OnExit()
	end
end

function ActivityChessView:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.chessView_) do
		iter_10_1:Dispose()
	end

	self.chessView_ = nil

	ActivityChessView.super.Dispose(self)
end

function ActivityChessView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityChessView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityChessView
