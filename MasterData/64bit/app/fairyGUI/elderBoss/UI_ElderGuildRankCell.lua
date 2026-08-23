local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074btdpp"

function var_0_0:__ctor()
	self.m_hasBgController = self:getController("hasBg")
	self.m_isSelfGuildController = self:getController("isSelfGuild")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_guildLoader = self:getChild("guildLoader")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_serverNameTxt1 = self:getChild("serverNameTxt1")
end

var_0_0.HasBgCtrl = {
	normal = 0,
	has = 1
}
var_0_0.IsSelfGuildCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
