local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88onsbkrrn4"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_hasGuildController = self:getController("hasGuild")
	self.m_knightComp = self:getChild("knightComp")
	self.m_stageComp = self:getChild("stageComp")
	self.m_guildNameText = self:getChild("guildNameText")
	self.m_serverNameText = self:getChild("serverNameText")
	self.m_userNameText = self:getChild("userNameText")
end

var_0_0.RankCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.HasGuildCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
