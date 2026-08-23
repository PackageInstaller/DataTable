local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagknq93u"

function var_0_0:__ctor()
	self.m_isTopThreeController = self:getController("isTopThree")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_hasRankController = self:getController("hasRank")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_rankText = self:getChild("rankText")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_efficiencyTxt = self:getChild("efficiencyTxt")
end

var_0_0.IsTopThreeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowBgCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasRankCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
