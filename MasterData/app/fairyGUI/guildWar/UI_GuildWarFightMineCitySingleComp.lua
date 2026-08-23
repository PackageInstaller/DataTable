local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mu5fkm6r"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_commandPoint = self:getChild("commandPoint")
	self.m_frontPos1 = self:getChild("frontPos1")
	self.m_frontPos2 = self:getChild("frontPos2")
	self.m_frontPos3 = self:getChild("frontPos3")
	self.m_frontPos4 = self:getChild("frontPos4")
	self.m_frontPos5 = self:getChild("frontPos5")
	self.m_frontPos6 = self:getChild("frontPos6")
	self.m_strategicPoint1 = self:getChild("strategicPoint1")
	self.m_strategicPoint2 = self:getChild("strategicPoint2")
	self.m_strategicPoint3 = self:getChild("strategicPoint3")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
