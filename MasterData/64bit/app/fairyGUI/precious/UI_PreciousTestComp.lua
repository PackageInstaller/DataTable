local var_0_0 = {}

var_0_0.URL = "ui://671qywx2cmu420"

function var_0_0:__ctor()
	self.m_preciousComp1 = self:getChild("preciousComp1")
	self.m_preciousComp2 = self:getChild("preciousComp2")
	self.m_preciousComp3 = self:getChild("preciousComp3")
	self.m_rotationRTransition = self:getTransition("rotationR")
	self.m_rotationLTransition = self:getTransition("rotationL")
end

return var_0_0
