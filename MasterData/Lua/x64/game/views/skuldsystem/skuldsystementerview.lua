local SkuldSystemEnterView = class("SkuldSystemEnterView", ReduxView)

function SkuldSystemEnterView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_CutScenesUI"
end

function SkuldSystemEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldSystemEnterView:Init()
	return
end

function SkuldSystemEnterView:OnEnter()
	self.timer_ = Timer.New(function()
		self:StopTimer()
		gameContext:Go("/skuldSystemMainView", {}, true)
	end, 2.15, 1)

	self.timer_:Start()
end

function SkuldSystemEnterView:OnExit()
	self:StopTimer()
end

function SkuldSystemEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkuldSystemEnterView:Cacheable()
	return false
end

function SkuldSystemEnterView:Dispose()
	self:StopTimer()
	SkuldSystemEnterView.super.Dispose(self)
end

return SkuldSystemEnterView
