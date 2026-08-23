local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7wmdze8"

function var_0_0:__ctor()
	self.m_hideTreasureController = self:getController("hideTreasure")
	self.m_equipComp1 = self:getChild("equipComp1")
	self.m_equipComp2 = self:getChild("equipComp2")
	self.m_equipComp3 = self:getChild("equipComp3")
	self.m_equipComp4 = self:getChild("equipComp4")
	self.m_equipSuitBtn = self:getChild("equipSuitBtn")
	self.m_treasureComp1 = self:getChild("treasureComp1")
	self.m_treasureComp2 = self:getChild("treasureComp2")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HideTreasureCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
