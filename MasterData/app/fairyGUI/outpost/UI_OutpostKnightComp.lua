local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5rcuts"

function var_0_0:__ctor()
	self.m_hideViewController = self:getController("hideView")
	self.m_moveBuildController = self:getController("moveBuild")
	self.m_roleTypeController = self:getController("roleType")
	self.m_knightHolder = self:getChild("knightHolder")
	self.m_activeSkillHolder = self:getChild("activeSkillHolder")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_energyHolder = self:getChild("energyHolder")
	self.m_clickKnight = self:getChild("clickKnight")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_hpComp = self:getChild("hpComp")
	self.m_expHolder = self:getChild("expHolder")
	self.m_refreshTransition = self:getTransition("refresh")
end

return var_0_0
