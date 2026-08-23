local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gt62ox"

function var_0_0:__ctor()
	self.m_moduleController = self:getController("module")
	self.m_eff = self:getChild("eff")
	self.m_enter0Transition = self:getTransition("enter0")
	self.m_enter1Transition = self:getTransition("enter1")
	self.m_enter2Transition = self:getTransition("enter2")
	self.m_enter3Transition = self:getTransition("enter3")
end

return var_0_0
