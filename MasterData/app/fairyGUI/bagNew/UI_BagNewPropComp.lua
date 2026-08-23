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
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
