local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3d"

function var_0_0:__ctor()
	self.m_levelTipText = self:getChild("levelTipText")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_clickTransition = self:getTransition("click")
end

return var_0_0
