local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wvcl8d0"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_item = self:getChild("item")
	self.m_discountTitle = self:getChild("discountTitle")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_timeLimitTxt = self:getChild("timeLimitTxt")
	self.m_priceComp = self:getChild("priceComp")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_popBtn = self:getChild("popBtn")
	self.m_awardBtn = self:getChild("awardBtn")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsFreeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
