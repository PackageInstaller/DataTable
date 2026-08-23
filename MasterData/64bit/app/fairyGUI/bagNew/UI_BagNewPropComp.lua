local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qromon1e"

function var_0_0:__ctor()
	self.m_rightTopSelectTabController = self:getController("rightTopSelectTab")
	self.m_bagList = self:getChild("bagList")
	self.m_topGroup = self:getChild("topGroup")
	self.m_unGetGroup = self:getChild("unGetGroup")
	self.m_showInfoComp = self:getChild("showInfoComp")
end

var_0_0.RightTopSelectTabCtrl = {
	page1 = 1,
	page0 = 0,
	page4 = 4,
	page3 = 3,
	page2 = 2
}

return var_0_0
