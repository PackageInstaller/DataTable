local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcih14"

function var_0_0:__ctor()
	self.m_hasBgController = self:getController("hasBg")
	self.m_isSelfController = self:getController("isSelf")
	self.m_rankComp = self:getChild("rankComp")
	self.m_userIcon = self:getChild("userIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_serverText = self:getChild("serverText")
	self.m_scoreText = self:getChild("scoreText")
end

return var_0_0
