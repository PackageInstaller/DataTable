local var_0_0 = {}

var_0_0.URL = "ui://pbd24silg3s62f"

function var_0_0:__ctor()
	self.m_showExpController = self:getController("showExp")
	self.m_isInvincibleController = self:getController("isInvincible")
	self.m_canAttackController = self:getController("canAttack")
	self.m_bottom = self:getChild("bottom")
	self.m_showKnight = self:getChild("showKnight")
	self.m_userName = self:getChild("userName")
	self.m_level = self:getChild("level")
	self.m_fightValue = self:getChild("fightValue")
	self.m_effAttack = self:getChild("effAttack")
	self.m_effLevel = self:getChild("effLevel")
	self.m_expHolder = self:getChild("expHolder")
	self.m_effBuff = self:getChild("effBuff")
	self.m_effRelive = self:getChild("effRelive")
	self.m_addExpTransition = self:getTransition("addExp")
	self.m_reliveTransition = self:getTransition("relive")
	self.m_level_2Transition = self:getTransition("level")
end

return var_0_0
