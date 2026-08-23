local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbx5qvv0"

function var_0_0:__ctor()
	self.m_showDomainController = self:getController("showDomain")
	self.m_itemList = self:getChild("itemList")
	self.m_showComp = self:getChild("showComp")
	self.m_rightTabPanel = self:getChild("rightTabPanel")
	self.m_domainBtn = self:getChild("domainBtn")
	self.m_blankBg = self:getChild("blankBg")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_lineUpBtn = self:getChild("lineUpBtn")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowDomainCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
