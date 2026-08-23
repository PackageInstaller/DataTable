local var_0_0 = {}

var_0_0.URL = "ui://foyq921sfp076j"

function var_0_0:__ctor()
	self.m_enterComp1 = self:getChild("enterComp1")
	self.m_enterComp2 = self:getChild("enterComp2")
	self.m_topBar = self:getChild("topBar")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_uiHideTransition = self:getTransition("uiHide")
	self.m_uiShowTransition = self:getTransition("uiShow")
end

return var_0_0
