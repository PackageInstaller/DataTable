local var_0_0 = {}

var_0_0.URL = "ui://3jnmvl3pw34kgic1j"

function var_0_0:__ctor()
	self.m_bgCom = self:getChild("bgCom")
	self.m_skipBtn = self:getChild("skipBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_nsr_1Transition = self:getTransition("nsr_1")
	self.m_nsr_5Transition = self:getTransition("nsr_5")
	self.m_ssr_1Transition = self:getTransition("ssr_1")
	self.m_ssr_5Transition = self:getTransition("ssr_5")
end

return var_0_0
