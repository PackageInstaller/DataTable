local ValentineGameMainView = class("ValentineGameMainView", ReduxView)

function ValentineGameMainView:UIName()
	return ValentineGameTools.GetMainUIName(self.params_.activityID)
end

function ValentineGameMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameMainView:InitUI()
	self:BindCfgUI()
end

function ValentineGameMainView:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			JumpTools.OpenPageByJump("valentineGameReward", {
				activityID = self.params_.activityID
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	self:AddBtnListener(self.testBtn_, nil, function()
		if ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityID = self.params_.activityID
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function ValentineGameMainView:OnEnter()
	self:BindUIRedPoint()
	self:RefreshData()
	self:RefreshUI()
end

function ValentineGameMainView:RefreshData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ValentineGameMainView:RefreshUI()
	self:RefreshTime()
end

function ValentineGameMainView:RefreshTime()
	local var_11_0
	local var_11_1 = manager.time:GetServerTime()

	self:StopTimer()

	if var_11_1 < self.startTime_ then
		self.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_11_0 = self.startTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_11_1 < self.stopTime_ then
		self.timeTxt_.text = manager.time:GetLostTimeStr(self.stopTime_)
		self.timer_ = Timer.New(function()
			var_11_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeTxt_.text = manager.time:GetLostTimeStr(self.stopTime_)
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function ValentineGameMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ValentineGameMainView:BindUIRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.VALENTINE_GAME_REWARD .. "_" .. self.params_.activityID)
	manager.redPoint:bindUIandKey(self.testBtn_.transform, RedPointConst.VALENTINE_GAME_OPEN .. "_" .. self.params_.activityID)
end

function ValentineGameMainView:UnBindUIRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.VALENTINE_GAME_REWARD .. "_" .. self.params_.activityID)
	manager.redPoint:unbindUIandKey(self.testBtn_.transform, RedPointConst.VALENTINE_GAME_OPEN .. "_" .. self.params_.activityID)
end

function ValentineGameMainView:OnTop()
	local var_17_0 = ValentineGameTools.GetGameHelpKey(self.params_.activityID)

	if var_17_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_17_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function ValentineGameMainView:OnExit()
	self:StopTimer()
	self:UnBindUIRedPoint()
	manager.windowBar:HideBar()
end

function ValentineGameMainView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ValentineGameMainView
