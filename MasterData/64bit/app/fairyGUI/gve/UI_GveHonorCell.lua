local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbqhr4mic7l"

function var_0_0:__ctor()
	self.m_bgController = self:getController("bg")
	self.m_isDeadController = self:getController("isDead")
	self.m_bossNameTxt = self:getChild("bossNameTxt")
	self.m_bossIconLoader = self:getChild("bossIconLoader")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_awardBtn = self:getChild("awardBtn")
	self.m_leaderIcon = self:getChild("leaderIcon")
	self.m_leaderNameTxt = self:getChild("leaderNameTxt")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_playerGroup = self:getChild("playerGroup")
	self.m_teamIconLoader = self:getChild("teamIconLoader")
	self.m_teamNameTxt = self:getChild("teamNameTxt")
	self.m_serverNameTxt1 = self:getChild("serverNameTxt1")
	self.m_guildGroup = self:getChild("guildGroup")
	self.m_bossTipTxt = self:getChild("bossTipTxt")
end

return var_0_0
