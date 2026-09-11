local ActivityQuizMatchPopView = class("ActivityQuizMatchPopView", ReduxView)

function ActivityQuizMatchPopView:UIName()
	return ActivityQuizTools.GetMatchPopUIName(self.params_.activityId)
end

function ActivityQuizMatchPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityQuizMatchPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityQuizMatchPopView:InitUI()
	self:BindCfgUI()
end

function ActivityQuizMatchPopView:AddUIListeners()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		ActivityQuizAction.CancelMarch()
	end)
end

function ActivityQuizMatchPopView:OnEnter()
	self.activityID_ = self.params_.activityId

	self:RefreshTime()
end

function ActivityQuizMatchPopView:RefreshTime()
	self:StopTimer()

	local var_8_0 = 0

	self.cnt_.text = 0 .. "s"
	self.timer_ = Timer.New(function()
		var_8_0 = var_8_0 + 1
		self.cnt_.text = var_8_0 .. "s"
	end, 1, -1)

	self.timer_:Start()
end

function ActivityQuizMatchPopView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityQuizMatchPopView:OnQuizStartGame()
	self:Back()
end

function ActivityQuizMatchPopView:OnActivityQuizCancelMatch()
	self:Back()
end

function ActivityQuizMatchPopView:OnExit()
	self:StopTimer()
end

function ActivityQuizMatchPopView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityQuizMatchPopView
