local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuis1o"

function var_0_0:__ctor()
	self.m_buffGroupController = self:getController("buffGroup")
	self.m_teamComp = self:getChild("teamComp")
	self.m_tabList = self:getChild("tabList")
	self.m_saveBtn = self:getChild("saveBtn")
	self.m_groupIcon = self:getChild("groupIcon")
	self.m_buffTxt = self:getChild("buffTxt")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.BuffGroupCtrl = {
	page2 = 1,
	page1 = 2,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
