local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52whdaqd1"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_popPanel = self:getChild("popPanel")
	self.m_itemBg = self:getChild("itemBg")
	self.m_baseItem = self:getChild("baseItem")
	self.m_discountTitle = self:getChild("discountTitle")
	self.m_nameBg = self:getChild("nameBg")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_giftDesc = self:getChild("giftDesc")
	self.m_priceComp = self:getChild("priceComp")
	self.m_itemList = self:getChild("itemList")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
end

var_0_0.IsFreeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
