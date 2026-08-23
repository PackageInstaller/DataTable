local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25dtno7j"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_tabList = self:getChild("tabList")
	self.m_curNumText = self:getChild("curNumText")
	self.m_maxText = self:getChild("maxText")
	self.m_showList = self:getChild("showList")
	self.m_maxTipText = self:getChild("maxTipText")
	self.m_recoveryBtn = self:getChild("recoveryBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsMaxCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
