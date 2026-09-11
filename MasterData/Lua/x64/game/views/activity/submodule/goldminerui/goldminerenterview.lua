local GoldMinerEnterView = class("GoldMinerEnterView", ReduxView)

function GoldMinerEnterView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEater_GoldenMiner_CountdownUI"
end

function GoldMinerEnterView:UIParent()
	return manager.ui.uiPop.transform
end

function GoldMinerEnterView:Init()
	return
end

function GoldMinerEnterView:OnEnter()
	self.timer_ = Timer.New(function()
		self:StopTimer()
		JumpTools.Back()
	end, 3, 1)

	self.timer_:Start()
end

function GoldMinerEnterView:OnExit()
	self:StopTimer()
end

function GoldMinerEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GoldMinerEnterView:Dispose()
	self:StopTimer()
	GoldMinerEnterView.super.Dispose(self)
end

return GoldMinerEnterView
