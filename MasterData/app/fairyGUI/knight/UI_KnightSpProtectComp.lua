local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivudlwfrf2"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_canBreakController = self:getController("canBreak")
	self.m_level = self:getChild("level")
	self.m_nextLevel = self:getChild("nextLevel")
	self.m_descTitle = self:getChild("descTitle")
	self.m_knightList = self:getChild("knightList")
	self.m_valueDescText = self:getChild("valueDescText")
	self.m_descTitle1 = self:getChild("descTitle1")
	self.m_skillCurComp = self:getChild("skillCurComp")
	self.m_skillNextComp = self:getChild("skillNextComp")
	self.m_breakUpBtn = self:getChild("breakUpBtn")
	self.m_breakTipsTxt = self:getChild("breakTipsTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsMaxCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanBreakCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
