local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52weu6r3b"

function var_0_0:__ctor()
	self.m_hasNumController = self:getController("hasNum")
	self.m_isFreeController = self:getController("isFree")
	self.m_isDiscountController = self:getController("isDiscount")
	self.m_isLimitController = self:getController("isLimit")
	self.m_isActivatedController = self:getController("isActivated")
	self.m_showOriginController = self:getController("showOrigin")
	self.m_popPanel = self:getChild("popPanel")
	self.m_itemBg = self:getChild("itemBg")
	self.m_baseItem = self:getChild("baseItem")
	self.m_discountTitle = self:getChild("discountTitle")
	self.m_nameBg = self:getChild("nameBg")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_originPriceComp = self:getChild("originPriceComp")
	self.m_priceComp = self:getChild("priceComp")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_itemList = self:getChild("itemList")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_title = self:getChild("title")
	self.m_englishText = self:getChild("englishText")
	self.m_giftDesc = self:getChild("giftDesc")
	self.m_levelText = self:getChild("levelText")
	self.m_notActivatedTxt = self:getChild("notActivatedTxt")
	self.m_content = self:getChild("content")
end

var_0_0.HasNumCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1
}
var_0_0.IsFreeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsDiscountCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLimitCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsActivatedCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowOriginCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
