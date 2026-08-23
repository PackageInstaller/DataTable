local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34ou53x21"

function var_0_0:__ctor()
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_indexRank = self:getChild("indexRank")
	self.m_iconComp = self:getChild("iconComp")
	self.m_userNameText = self:getChild("userNameText")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_scoreText = self:getChild("scoreText")
	self.m_scoreIcon = self:getChild("scoreIcon")
	self.m_awardList = self:getChild("awardList")
end

return var_0_0
