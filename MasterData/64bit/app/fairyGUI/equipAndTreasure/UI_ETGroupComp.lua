local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjs1f"

function var_0_0:__ctor()
	self.m_hideTreasureController = self:getController("hideTreasure")
	self.m_equipComp1 = self:getChild("equipComp1")
	self.m_equipComp2 = self:getChild("equipComp2")
	self.m_equipComp3 = self:getChild("equipComp3")
	self.m_equipComp4 = self:getChild("equipComp4")
	self.m_equipSuitBtn = self:getChild("equipSuitBtn")
	self.m_treasureComp1 = self:getChild("treasureComp1")
	self.m_treasureComp2 = self:getChild("treasureComp2")
	self.m_treasureRed1 = self:getChild("treasureRed1")
	self.m_treasureRed2 = self:getChild("treasureRed2")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HideTreasureCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
