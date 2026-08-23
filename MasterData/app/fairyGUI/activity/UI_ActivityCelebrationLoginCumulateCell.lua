local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wf3yyh3"

function var_0_0:__ctor()
	self.m_isSpecialController = self:getController("isSpecial")
	self.m_isSatisfyController = self:getController("isSatisfy")
	self.m_isRecvController = self:getController("isRecv")
	self.m_progBar = self:getChild("progBar")
	self.m_rewardIcon = self:getChild("rewardIcon")
	self.m_cardBg = self:getChild("cardBg")
	self.m_otherSquare = self:getChild("otherSquare")
	self.m_lastSquare = self:getChild("lastSquare")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_eff = self:getChild("eff")
	self.m_tagPic = self:getChild("tagPic")
	self.m_descTxt = self:getChild("descTxt")
	self.m_recvBtn = self:getChild("recvBtn")
	self.m_effectCanRecv = self:getChild("effectCanRecv")
end

var_0_0.IsSpecialCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSatisfyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsRecvCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
