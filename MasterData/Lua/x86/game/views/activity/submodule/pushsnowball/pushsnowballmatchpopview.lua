local PushSnowBallMatchPopView = class("PushSnowBallMatchPopView", ReduxView)

function PushSnowBallMatchPopView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballMatchmakingUI"
end

function PushSnowBallMatchPopView:UIParent()
	return manager.ui.uiPop.transform
end

function PushSnowBallMatchPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PushSnowBallMatchPopView:InitUI()
	self:BindCfgUI()

	self.cancelHandler_ = handler(self, function()
		self:Back()
	end)
end

function PushSnowBallMatchPopView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		PushSnowBallAction:SendCancelMatching()
		self.cancelHandler_()
	end)
end

function PushSnowBallMatchPopView:OnEnter()
	self.matchingTimer = 0
	self.timeText_.text = self.matchingTimer .. "s"

	self:AddTimer()
	manager.notify:RegistListener(PUSH_SNOWBALL_CANCLE_MATCHING, self.cancelHandler_)
	manager.notify:RegistListener(PUSH_SNOWBALL_SUCCESS_MATCHING, self.cancelHandler_)
end

function PushSnowBallMatchPopView:AddTimer()
	self.timer_ = Timer.New(function()
		self.matchingTimer = self.matchingTimer + 1
		self.timeText_.text = self.matchingTimer .. "s"
	end, 1, -1, true)

	self.timer_:Start()
end

function PushSnowBallMatchPopView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.notify:RemoveListener(PUSH_SNOWBALL_CANCLE_MATCHING, self.cancelHandler_)
	manager.notify:RemoveListener(PUSH_SNOWBALL_SUCCESS_MATCHING, self.cancelHandler_)
end

function PushSnowBallMatchPopView:Dispose()
	PushSnowBallMatchPopView.super.Dispose(self)
end

return PushSnowBallMatchPopView
