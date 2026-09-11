local RechargeWelfarePageView = class("RechargeWelfarePageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeWelfarePageView:InitUI()
	self:BindCfgUI()

	self.rechargeItemList_ = {}

	for iter_1_0, iter_1_1 in pairs(ActivityNewbieData:GetRechargeTemplate()) do
		self.rechargeItemList_[iter_1_0] = ActivityNewbieRechargeItem.New(self[string.format("button%s_", iter_1_0)], iter_1_0)
	end

	self:Show()
end

function RechargeWelfarePageView:Dispose()
	for iter_2_0, iter_2_1 in pairs(self.rechargeItemList_) do
		iter_2_1:Dispose()
	end

	self.rechargeItemList_ = nil

	RechargeWelfarePageView.super.Dispose(self)
end

function RechargeWelfarePageView:Show()
	SetActive(self.gameObject_, true)

	for iter_3_0, iter_3_1 in pairs(self.rechargeItemList_) do
		iter_3_1:RefreshUI()
	end
end

return RechargeWelfarePageView
