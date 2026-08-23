local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfqr6v36"

function var_0_0:__ctor()
	self.m_topThreeController = self:getController("topThree")
	self.m_isOurTeamController = self:getController("isOurTeam")
	self.m_hasGuildController = self:getController("hasGuild")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_useTimeTxt = self:getChild("useTimeTxt")
	self.m_guildIconLoader = self:getChild("guildIconLoader")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
end

return var_0_0
