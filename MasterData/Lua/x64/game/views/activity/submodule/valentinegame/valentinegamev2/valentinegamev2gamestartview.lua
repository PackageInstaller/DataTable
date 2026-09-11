local ValentineGameV2GameStartView = class("ValentineGameV2GameStartView", ReduxView)

function ValentineGameV2GameStartView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineStarUI"
end

function ValentineGameV2GameStartView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameV2GameStartView:Init()
	return
end

function ValentineGameV2GameStartView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.timer_ = Timer.New(function()
		self:StopTimer()
		JumpTools.OpenPageByJump("/valentineGameV2HeroAnswerView", {
			activityID = self.activityID_
		})
	end, 3, 1)

	self.timer_:Start()
end

function ValentineGameV2GameStartView:OnExit()
	self:StopTimer()
end

function ValentineGameV2GameStartView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ValentineGameV2GameStartView:Dispose()
	self:StopTimer()
	self.super.Dispose(self)
end

return ValentineGameV2GameStartView
