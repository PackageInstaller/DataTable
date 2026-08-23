local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrclc05p"

function var_0_0:__ctor()
	self.m_titleStateController = self:getController("titleState")
	self.m_priceNumController = self:getController("priceNum")
	self.m_popPanel = self:getChild("popPanel")
	self.m_sellList = self:getChild("sellList")
	self.m_filterList = self:getChild("filterList")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_sellRewardComp1 = self:getChild("sellRewardComp1")
	self.m_sellRewardComp2 = self:getChild("sellRewardComp2")
	self.m_content = self:getChild("content")
end

var_0_0.TitleStateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.PriceNumCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
