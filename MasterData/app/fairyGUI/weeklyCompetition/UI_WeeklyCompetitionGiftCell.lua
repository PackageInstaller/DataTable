local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34okit92m"

function var_0_0:__ctor()
	self.m_isUnBuyController = self:getController("isUnBuy")
	self.m_isDiscountController = self:getController("isDiscount")
	self.m_isLimitController = self:getController("isLimit")
	self.m_isFreeController = self:getController("isFree")
	self.m_showRefreshTimeController = self:getController("showRefreshTime")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_offText = self:getChild("offText")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_priceComp = self:getChild("priceComp")
	self.m_popBtn = self:getChild("popBtn")
	self.m_awardBtn = self:getChild("awardBtn")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_refreshTimeTxt = self:getChild("refreshTimeTxt")
end

return var_0_0
