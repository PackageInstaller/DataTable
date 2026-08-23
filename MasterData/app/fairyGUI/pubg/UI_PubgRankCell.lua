local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcih1c"

function var_0_0:__ctor()
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankComp = self:getChild("rankComp")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_levelText = self:getChild("levelText")
	self.m_nameText = self:getChild("nameText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_scoreText = self:getChild("scoreText")
	self.m_serverText = self:getChild("serverText")
end

return var_0_0
