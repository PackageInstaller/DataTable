local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivi977frf0"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_upgradeCostController = self:getController("upgradeCost")
	self.m_level = self:getChild("level")
	self.m_nextLevel = self:getChild("nextLevel")
	self.m_descTitle = self:getChild("descTitle")
	self.m_attrChangeList = self:getChild("attrChangeList")
	self.m_knightFragComp = self:getChild("knightFragComp")
	self.m_icon = self:getChild("icon")
	self.m_desc1Title = self:getChild("desc1Title")
	self.m_costItem = self:getChild("costItem")
	self.m_upBtn = self:getChild("upBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsMaxCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.UpgradeCostCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
