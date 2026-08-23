local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99u7kxkk2pi"

function var_0_0:__ctor()
	self.m_showTabController = self:getController("showTab")
	self.m_isShareController = self:getController("isShare")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_shareComp = self:getChild("shareComp")
	self.m_knightList = self:getChild("knightList")
	self.m_petComp1 = self:getChild("petComp1")
	self.m_petComp2 = self:getChild("petComp2")
	self.m_petComp3 = self:getChild("petComp3")
	self.m_petComp4 = self:getChild("petComp4")
	self.m_petComp5 = self:getChild("petComp5")
	self.m_uniteBtn1 = self:getChild("uniteBtn1")
	self.m_uniteBtn2 = self:getChild("uniteBtn2")
	self.m_uniteBtn3 = self:getChild("uniteBtn3")
	self.m_uniteBtn4 = self:getChild("uniteBtn4")
	self.m_succubaComp1 = self:getChild("succubaComp1")
	self.m_succubaComp2 = self:getChild("succubaComp2")
	self.m_succubaComp3 = self:getChild("succubaComp3")
	self.m_tabBtn1 = self:getChild("tabBtn1")
	self.m_tabBtn2 = self:getChild("tabBtn2")
	self.m_tabBtn3 = self:getChild("tabBtn3")
	self.m_tabBtn4 = self:getChild("tabBtn4")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

var_0_0.ShowTabCtrl = {
	page1 = 1,
	page0 = 0,
	page3 = 6,
	page2 = 2
}
var_0_0.IsShareCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
