local ActivityMainBaseView = class("ActivityMainBaseView", ReduxView)

function ActivityMainBaseView:UIName()
	return
end

function ActivityMainBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMainBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:InitSubmoduleButton()
end

function ActivityMainBaseView:InitSubmoduleButton()
	return
end

function ActivityMainBaseView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()

	for iter_5_0, iter_5_1 in pairs(self.submoduleBtnList_) do
		iter_5_1:OnEnter()
	end
end

function ActivityMainBaseView:OnExit()
	manager.windowBar:HideBar()

	for iter_6_0, iter_6_1 in pairs(self.submoduleBtnList_) do
		iter_6_1:OnExit()
	end
end

function ActivityMainBaseView:Dispose()
	ActivityMainBaseView.super.Dispose(self)

	for iter_7_0, iter_7_1 in pairs(self.submoduleBtnList_) do
		iter_7_1:Dispose()
	end

	self.submoduleBtnList_ = nil
end

function ActivityMainBaseView:AddListeners()
	return
end

function ActivityMainBaseView:RefreshUI()
	local var_9_0 = ActivityData:GetActivityData(self:GetActivityID())

	self.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_9_0.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_9_0.stopTime, "!%Y.%m.%d %H:%M"))
end

function ActivityMainBaseView:GetActivityID()
	return
end

function ActivityMainBaseView:AddTimer()
	self.stopTime_ = ActivityData:GetActivityData((self:GetActivityID())).stopTime

	self:StopTimer()

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

function ActivityMainBaseView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityMainBaseView
