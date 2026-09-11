local OperationRushAniView = class("OperationRushAniView", ReduxView)

function OperationRushAniView:UIName()
	return "Widget/System/BattleResult/Common/BattleResultRushAnimeUI"
end

function OperationRushAniView:UIParent()
	return manager.ui.uiPop.transform
end

function OperationRushAniView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OperationRushAniView:InitUI()
	self:BindCfgUI()
end

function OperationRushAniView:OnEnter()
	self.timer_ = Timer.New(function()
		if self.params_.callBack then
			self.params_.callBack()
		end

		self:StopTimer()
	end, 1.1, 1)

	self.timer_:Start()
end

function OperationRushAniView:OnExit()
	self:StopTimer()
end

function OperationRushAniView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function OperationRushAniView:AddUIListener()
	return
end

function OperationRushAniView:Dispose()
	self.super.Dispose(self)
	self:StopTimer()
end

return OperationRushAniView
