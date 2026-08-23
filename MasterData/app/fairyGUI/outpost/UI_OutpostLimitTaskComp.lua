local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5rcut27"

function var_0_0:__ctor()
	self.m_isTriggerController = self:getController("isTrigger")
	self.m_iconComp = self:getChild("iconComp")
	self.m_effNode = self:getChild("effNode")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
