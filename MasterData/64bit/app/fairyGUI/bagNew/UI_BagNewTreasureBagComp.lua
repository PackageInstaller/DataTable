local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrswvx4k"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isOnWearController = self:getController("isOnWear")
	self.m_rightComp = self:getChild("rightComp")
	self.m_equipBtn = self:getChild("equipBtn")
	self.m_fragBtn = self:getChild("fragBtn")
	self.m_hideInWearBtn = self:getChild("hideInWearBtn")
	self.m_bagNumComp = self:getChild("bagNumComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_fitTitle = self:getChild("fitTitle")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_sortBtn = self:getChild("sortBtn")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_rebornBtn = self:getChild("rebornBtn")
	self.m_unGetGroup = self:getChild("unGetGroup")
	self.m_itemList = self:getChild("itemList")
	self.m_toolComp = self:getChild("toolComp")
end

var_0_0.TabCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsOnWearCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
