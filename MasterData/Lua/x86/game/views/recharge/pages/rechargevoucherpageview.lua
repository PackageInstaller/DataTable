local RechargeVoucherPageView = class("RechargeVoucherPageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeVoucherPageView:InitUI(arg_1_1, arg_1_2)
	self.shopID = arg_1_2

	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, RechargeVoucherItem)
end

function RechargeVoucherPageView:indexItem(arg_2_1, arg_2_2)
	arg_2_2:SetData(self.shopDataList_[arg_2_1])
end

function RechargeVoucherPageView:AddUIListener()
	return
end

function RechargeVoucherPageView:OnTop()
	return
end

function RechargeVoucherPageView:OnEnter()
	self.shopDataList_ = self:InitDataList()

	self.list_:StartScroll(#self.shopDataList_)
end

function RechargeVoucherPageView:OnExit()
	return
end

function RechargeVoucherPageView:Hide()
	RechargeVoucherPageView.super.Hide(self)
end

function RechargeVoucherPageView:InitDataList()
	local var_8_0 = ShopTools.FilterShopDataList(self.shopID)

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		return getShopCfg(arg_9_0.id).goods_id < getShopCfg(arg_9_1.id).goods_id
	end)

	return var_8_0
end

function RechargeVoucherPageView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RechargeVoucherPageView.super.Dispose(self)
end

return RechargeVoucherPageView
