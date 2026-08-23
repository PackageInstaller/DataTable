local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mcbahm6l"

function var_0_0:__ctor()
	self.m_isChampionController = self:getController("isChampion")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_scoreText = self:getChild("scoreText")
	self.m_serverNameText = self:getChild("serverNameText")
	self.m_guildNameText = self:getChild("guildNameText")
	self.m_rankText = self:getChild("rankText")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsChampionCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
