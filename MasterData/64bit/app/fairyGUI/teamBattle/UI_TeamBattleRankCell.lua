local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd0dp"

function var_0_0:__ctor()
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_hasBgController = self:getController("hasBg")
	self.m_isTop3Controller = self:getController("isTop3")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_teamNameTxt = self:getChild("teamNameTxt")
	self.m_userComp1 = self:getChild("userComp1")
	self.m_userComp2 = self:getChild("userComp2")
	self.m_userComp3 = self:getChild("userComp3")
	self.m_scoreTxt = self:getChild("scoreTxt")
end

var_0_0.HasPlayerCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HasBgCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsTop3Ctrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
