local ValentineGameLoadingView = class("ValentineGameLoadingView", ReduxView)

function ValentineGameLoadingView:UIName()
	return ValentineGameTools.GetLoadingUIName(self.params_.activityId)
end

function ValentineGameLoadingView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameLoadingView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameLoadingView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameLoadingView:InitUI()
	self:BindCfgUI()
end

function ValentineGameLoadingView:AddUIListeners()
	return
end

function ValentineGameLoadingView:OnEnter()
	self:StopTimer()

	self.timer_ = TimeTools.StartAfterSeconds(GameDisplayCfg.activity_valentine_wait_time.value[1], function()
		JumpTools.OpenPageByJump("/valentineGame", {
			mainActivityID = self.params_.mainActivityID,
			activityID = self.params_.activityID
		})
	end, {})
end

function ValentineGameLoadingView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ValentineGameLoadingView:OnTop()
	manager.windowBar:HideBar()
end

function ValentineGameLoadingView:OnExit()
	self:StopTimer()

	self.canvasGroup_.alpha = 0
end

function ValentineGameLoadingView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ValentineGameLoadingView
