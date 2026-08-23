local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfn1mf19"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_serverTxt = self:getChild("serverTxt")
	self.m_guildTxt = self:getChild("guildTxt")
	self.m_scoreText = self:getChild("scoreText")
end

return var_0_0
