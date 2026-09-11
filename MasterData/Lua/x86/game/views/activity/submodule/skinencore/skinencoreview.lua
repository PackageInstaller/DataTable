ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SkinEncoreView = class("SkinEncoreView", ActivityMainBasePanel)

function SkinEncoreView:GetUIName()
	return SkinEncoreTools.GetUIName(self.activityID_)
end

function SkinEncoreView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinEncoreView:InitUI()
	self:BindCfgUI()
end

function SkinEncoreView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 < self.startTime_ then
			ShowTips("SOLO_NOT_OPEN")
		elseif var_5_0 <= self.stopTime_ then
			JumpTools.GoToSystem("/rechargeMain", {
				page = 2
			}, ViewConst.SYSTEM_ID.SHOP)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function SkinEncoreView:OnEnter()
	self:RefreshUI()
end

function SkinEncoreView:RefreshUI()
	self:RefreshActivityData()
	self:RefreshTime()
end

function SkinEncoreView:RefreshActivityData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function SkinEncoreView:RefreshTime()
	local var_9_0
	local var_9_1 = manager.time:GetServerTime()

	self:StopTimer()

	if var_9_1 < self.startTime_ then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_9_0 = self.startTime_ - manager.time:GetServerTime()

			if var_9_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_9_1 < self.stopTime_ then
		self.timeTxt_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
		self.timer_ = Timer.New(function()
			self.timeTxt_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
			var_9_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_9_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function SkinEncoreView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkinEncoreView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:StopTimer()
end

function SkinEncoreView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return SkinEncoreView
