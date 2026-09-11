local RechargeMonthCardDescView = class("RechargeMonthCardDescView", ReduxView)

function RechargeMonthCardDescView:UIName()
	return "Widget/Common/Pop/MonthlyCardDescriptionUI"
end

function RechargeMonthCardDescView:UIParent()
	return manager.ui.uiPop.transform
end

function RechargeMonthCardDescView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeMonthCardDescView:InitUI()
	self:BindCfgUI()
end

function RechargeMonthCardDescView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function RechargeMonthCardDescView:UpdateBar()
	return
end

function RechargeMonthCardDescView:OnEnter()
	return
end

function RechargeMonthCardDescView:OnExit()
	return
end

function RechargeMonthCardDescView:OnTop()
	self:UpdateBar()
end

function RechargeMonthCardDescView:Dispose()
	RechargeMonthCardDescView.super.Dispose(self)
end

return RechargeMonthCardDescView
