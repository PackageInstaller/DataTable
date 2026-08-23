local var_0_0 = {}

var_0_0.URL = "ui://irs65rtsjm3hm72"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_mobilityCircleBarComp = self:getChild("mobilityCircleBarComp")
	self.m_unLockLvTxt = self:getChild("unLockLvTxt")
end

return var_0_0
