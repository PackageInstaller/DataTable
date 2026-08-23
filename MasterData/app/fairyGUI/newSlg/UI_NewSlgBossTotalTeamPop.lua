local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ouc78h"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_teamBtn = self:getChild("teamBtn")
	self.m_List_team = self:getChild("List_team")
	self.m_Comp_dropDown = self:getChild("Comp_dropDown")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_searchBtn = self:getChild("searchBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
