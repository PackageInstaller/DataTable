local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepqpxggibuq"

function var_0_0:__ctor()
	self.m_showLimitController = self:getController("showLimit")
	self.m_typeController = self:getController("type")
	self.m_useAfterBuyController = self:getController("useAfterBuy")
	self.m_isOnSaleController = self:getController("isOnSale")
	self.m_costController = self:getController("cost")
	self.m_showNumController = self:getController("showNum")
	self.m_popPanel = self:getChild("popPanel")
	self.m_itemBg = self:getChild("itemBg")
	self.m_effectBg = self:getChild("effectBg")
	self.m_baseItem = self:getChild("baseItem")
	self.m_effectIcon = self:getChild("effectIcon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_nameBg = self:getChild("nameBg")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_haveNumTxt = self:getChild("haveNumTxt")
	self.m_cornerTxt = self:getChild("cornerTxt")
	self.m_priceCostComp1 = self:getChild("priceCostComp1")
	self.m_priceCostComp2 = self:getChild("priceCostComp2")
	self.m_subAddNumComp = self:getChild("subAddNumComp")
	self.m_limitTypeTxt = self:getChild("limitTypeTxt")
	self.m_limitCountTxt = self:getChild("limitCountTxt")
	self.m_resNumComp1 = self:getChild("resNumComp1")
	self.m_resNumComp2 = self:getChild("resNumComp2")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_useCheckBtn = self:getChild("useCheckBtn")
	self.m_ownResIcon = self:getChild("ownResIcon")
	self.m_ownResLabel = self:getChild("ownResLabel")
	self.m_ownResNum = self:getChild("ownResNum")
	self.m_ownResGroup = self:getChild("ownResGroup")
	self.m_content = self:getChild("content")
end

var_0_0.ShowLimitCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.UseAfterBuyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOnSaleCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CostCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowNumCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
