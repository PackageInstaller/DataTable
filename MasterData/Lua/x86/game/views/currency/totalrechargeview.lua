local TotalRechargeView = class("TotalRechargeView", ReduxView)

function TotalRechargeView:UIName()
	return "UI/PopUp/TotalRecharge"
end

function TotalRechargeView:UIParent()
	return manager.ui.uiPop.transform
end

function TotalRechargeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function TotalRechargeView:OnEnter()
	self:RefreshUI()
end

function TotalRechargeView:InitUI()
	self:BindCfgUI()
end

function TotalRechargeView:AddUIListener()
	self:AddBtnListener(self.rechargeBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 2,
			page = 3
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
end

function TotalRechargeView:RefreshUI()
	self.freeText_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE)
	self.paidText_.text = ItemTools.getItemNum(CurrencyConst.GetPlatformDiamondId())
	self.totalText_.text = CurrencyData:GetRechargeDiamond()
end

return TotalRechargeView
