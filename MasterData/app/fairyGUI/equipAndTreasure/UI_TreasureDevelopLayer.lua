local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjst"

function var_0_0:__ctor()
	self.m_tabSelectController = self:getController("tabSelect")
	self.m_isWearController = self:getController("isWear")
	self.m_isLazyStrengthController = self:getController("isLazyStrength")
	self.m_touchImg = self:getChild("touchImg")
	self.m_treasureList = self:getChild("treasureList")
	self.m_effectIconDownNode = self:getChild("effectIconDownNode")
	self.m_equipIconLoader = self:getChild("equipIconLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_effectIconNode = self:getChild("effectIconNode")
	self.m_devComp = self:getChild("devComp")
	self.m_lineUpComp = self:getChild("lineUpComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_blockClick = self:getChild("blockClick")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TabSelectCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.IsWearCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLazyStrengthCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
