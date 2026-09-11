local BanAccountView = class("BanAccountView", ReduxView)

function BanAccountView:UIName()
	return "Widget/Common/Pop/LineReportTipsUI"
end

function BanAccountView:UIParent()
	return manager.ui.uiPop.transform
end

function BanAccountView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function BanAccountView:OnEnter()
	local var_4_0 = self.params_.banTimestamp

	self.textContent_.text = GetI18NText(self.params_.banReason)
	self.textTime_.text = GetTips("MUTE_TIME_TEXT") .. manager.time:DescCTime(self.params_.banTimestamp, (GetTips("MUTE_TIME_FORMAT")))
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_4_0 then
			self:Back()

			return
		end
	end, 1, -1)

	self.timer_:Start()
end

function BanAccountView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BanAccountView:Dispose()
	BanAccountView.super.Dispose(self)
end

function BanAccountView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonSure_, nil, function()
		self:Back()
	end)
end

return BanAccountView
