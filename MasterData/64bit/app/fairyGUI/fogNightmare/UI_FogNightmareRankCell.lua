local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ohksqfw"

function var_0_0:__ctor()
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_indexRank = self:getChild("indexRank")
	self.m_iconComp = self:getChild("iconComp")
	self.m_userNameText = self:getChild("userNameText")
	self.m_serverNameText = self:getChild("serverNameText")
	self.m_guildNameText = self:getChild("guildNameText")
	self.m_stageText = self:getChild("stageText")
	self.m_levelText = self:getChild("levelText")
	self.m_searchBtn = self:getChild("searchBtn")
end

var_0_0.IsShowBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
