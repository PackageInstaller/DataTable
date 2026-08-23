local var_0_0 = {}

var_0_0.URL = "ui://irs65rts10brm3e"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_unLockLvTxt = self:getChild("unLockLvTxt")
	self.m_mobilityCircleBarComp = self:getChild("mobilityCircleBarComp")
end

return var_0_0
