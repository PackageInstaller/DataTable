local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrhxyl24"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isOnWearController = self:getController("isOnWear")
	self.m_rebornBtn = self:getChild("rebornBtn")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_equipBtn = self:getChild("equipBtn")
	self.m_fragBtn = self:getChild("fragBtn")
	self.m_hideInWearBtn = self:getChild("hideInWearBtn")
	self.m_bagNumComp = self:getChild("bagNumComp")
	self.m_fitTitle = self:getChild("fitTitle")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_unGetGroup = self:getChild("unGetGroup")
	self.m_equipList = self:getChild("equipList")
	self.m_equipGroup = self:getChild("equipGroup")
	self.m_fragList = self:getChild("fragList")
	self.m_fragGroup = self:getChild("fragGroup")
	self.m_equipInfoComp = self:getChild("equipInfoComp")
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
