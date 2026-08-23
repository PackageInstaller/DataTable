local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2ivp3st161z"

function var_0_0:__ctor()
	self.m_effDi = self:getChild("effDi")
	self.m_Comp_against = self:getChild("Comp_against")
	self.m_Comp_top_bar = self:getChild("Comp_top_bar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
