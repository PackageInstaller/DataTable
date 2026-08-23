local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llxv"

function var_0_0:__ctor()
	self.m_isDeadController = self:getController("isDead")
	self.m_hpProgress = self:getChild("hpProgress")
	self.m_monsterIcon = self:getChild("monsterIcon")
	self.m_monsterName = self:getChild("monsterName")
end

return var_0_0
