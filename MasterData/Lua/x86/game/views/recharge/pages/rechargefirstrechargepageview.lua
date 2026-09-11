local RechargeFirstRechargeWelfarePageView = class("RechargeFirstRechargeWelfarePageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeFirstRechargeWelfarePageView:InitUI(arg_1_1)
	self.index_ = arg_1_1[1]

	self:BindCfgUI()

	self.contentViewList_ = {}
	self.contentClasss_ = {
		ActivityNoobFirstRechargeView_1,
		ActivityNoobFirstRechargeView_2
	}
end

function RechargeFirstRechargeWelfarePageView:Dispose()
	for iter_2_0, iter_2_1 in pairs(self.contentViewList_) do
		iter_2_1:Dispose()
	end

	RechargeFirstRechargeWelfarePageView.super.Dispose(self)
end

function RechargeFirstRechargeWelfarePageView:SwitchPage(arg_3_1)
	if self.curView_ then
		self.curView_:SetActive(false)
	end

	self.contentViewList_[ShopConst.SIX_EIGHT[arg_3_1]] = self.contentViewList_[ShopConst.SIX_EIGHT[arg_3_1]] or self.contentClasss_[ShopConst.SIX_EIGHT[arg_3_1]].New(self.contentTrans_, self.index_)
	self.curView_ = self.contentViewList_[ShopConst.SIX_EIGHT[arg_3_1]]

	self.curView_:SetData(ShopConst.SIX_EIGHT[arg_3_1])
	self.curView_:SetActive(true)
end

return RechargeFirstRechargeWelfarePageView
