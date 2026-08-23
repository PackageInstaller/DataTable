local var_0_0 = {}

var_0_0.URL = "ui://pbd24silg3s64j"

function var_0_0:__ctor()
	self.m_canAttackController = self:getController("canAttack")
	self.m_showKnight = self:getChild("showKnight")
	self.m_effAttack = self:getChild("effAttack")
	self.m_userName = self:getChild("userName")
	self.m_fightValue = self:getChild("fightValue")
	self.m_eff = self:getChild("eff")
	self.m_refreshTransition = self:getTransition("refresh")
end

return var_0_0
