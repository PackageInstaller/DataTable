local var_0_0 = {}

var_0_0.URL = "ui://454a48jpcd4u14bnngx"

function var_0_0:__ctor()
	self.m_isLimitController = self:getController("isLimit")
	self.m_isUnBuyController = self:getController("isUnBuy")
	self.m_isFreeController = self:getController("isFree")
	self.m_isDiscountController = self:getController("isDiscount")
	self.m_IsTimeLimitController = self:getController("IsTimeLimit")
	self.m_showRechargeTypeController = self:getController("showRechargeType")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_unbuyLoader = self:getChild("unbuyLoader")
	self.m_canbuyLoader = self:getChild("canbuyLoader")
	self.m_item = self:getChild("item")
	self.m_discountTitle = self:getChild("discountTitle")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_timeDiGraph = self:getChild("timeDiGraph")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_priceComp = self:getChild("priceComp")
	self.m_priceCompMoney = self:getChild("priceCompMoney")
	self.m_timeLimitTxt = self:getChild("timeLimitTxt")
	self.m_popBtn = self:getChild("popBtn")
	self.m_awardBtn = self:getChild("awardBtn")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsLimitCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsUnBuyCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsFreeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsDiscountCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsTimeLimitCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowRechargeTypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
