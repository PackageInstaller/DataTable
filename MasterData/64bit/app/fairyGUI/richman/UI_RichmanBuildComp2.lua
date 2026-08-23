local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwuhr44x"

function var_0_0:__ctor()
	self.m_isEnemyController = self:getController("isEnemy")
	self.m_buildLoader = self:getChild("buildLoader")
	self.m_eff = self:getChild("eff")
	self.m_rewardProgress = self:getChild("rewardProgress")
	self.m_buildNameTxt = self:getChild("buildNameTxt")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_titleGroup = self:getChild("titleGroup")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
end

return var_0_0
