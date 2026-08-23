local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lqcekfs"

function var_0_0:__ctor()
	self.m_isDeadController = self:getController("isDead")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_hpBar = self:getChild("hpBar")
	self.m_elementLoader = self:getChild("elementLoader")
end

var_0_0.IsDeadCtrl = {
	dead = 1,
	alive = 0
}

return var_0_0
