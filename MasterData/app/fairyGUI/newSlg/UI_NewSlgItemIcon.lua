local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a14"

function var_0_0:__ctor()
	self.m_show_item_bgController = self:getController("show_item_bg")
	self.m_showAddController = self:getController("showAdd")
	self.m_showStarController = self:getController("showStar")
	self.m_headLoader = self:getChild("headLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_Comp_star = self:getChild("Comp_star")
	self.m_elementLoader = self:getChild("elementLoader")
end

var_0_0.Show_item_bgCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1,
	page3 = 2
}
var_0_0.ShowAddCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowStarCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
