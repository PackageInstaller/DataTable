local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkkxd0mibyj"

function var_0_0:__ctor()
	self.m_isDeadController = self:getController("isDead")
	self.m_baseIcon = self:getChild("baseIcon")
	self.m_hpProgress = self:getChild("hpProgress")
	self.m_levelBg = self:getChild("levelBg")
	self.m_levelText = self:getChild("levelText")
end

return var_0_0
