local var_0_0 = {}

var_0_0.URL = "ui://akds0szatrxs3h"

function var_0_0:__ctor()
	self.m_roundNum = self:getChild("roundNum")
	self.m_effBg = self:getChild("effBg")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
