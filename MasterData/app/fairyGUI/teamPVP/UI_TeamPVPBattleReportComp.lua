local var_0_0 = {}

var_0_0.URL = "ui://akds0szatrxs3o"

function var_0_0:__ctor()
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
