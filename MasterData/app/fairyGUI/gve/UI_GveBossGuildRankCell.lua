local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbh4hzmicad"

function var_0_0:__ctor()
	self.m_bgController = self:getController("bg")
	self.m_hasGuildController = self:getController("hasGuild")
	self.m_indexComp = self:getChild("indexComp")
	self.m_passTimeTxt = self:getChild("passTimeTxt")
	self.m_teamIconLoader = self:getChild("teamIconLoader")
	self.m_teamNameTxt = self:getChild("teamNameTxt")
	self.m_leaderIcon = self:getChild("leaderIcon")
	self.m_leaderNameTxt = self:getChild("leaderNameTxt")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_serverNameTxt1 = self:getChild("serverNameTxt1")
end

return var_0_0
