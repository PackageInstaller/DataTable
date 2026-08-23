local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r76r"

function var_0_0:__ctor()
	self.m_isArmorController = self:getController("isArmor")
	self.m_knightComp = self:getChild("knightComp")
	self.m_callBtn1 = self:getChild("callBtn1")
	self.m_callBtn2 = self:getChild("callBtn2")
	self.m_equipList = self:getChild("equipList")
	self.m_outTransition = self:getTransition("out")
	self.m_upTransition = self:getTransition("up")
end

return var_0_0
