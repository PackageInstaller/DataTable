local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivhob8boq"

function var_0_0:__ctor()
	self.m_isFullController = self:getController("isFull")
	self.m_needBreakController = self:getController("needBreak")
	self.m_progBar = self:getChild("progBar")
	self.m_passiveIcon = self:getChild("passiveIcon")
	self.m_selfAttrComp = self:getChild("selfAttrComp")
	self.m_allAttrComp = self:getChild("allAttrComp")
	self.m_activeBtn = self:getChild("activeBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsFullCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.NeedBreakCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
