local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2mg6n1g"

function var_0_0:__ctor()
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
	self.m_cutTransition = self:getTransition("cut")
end

return var_0_0
