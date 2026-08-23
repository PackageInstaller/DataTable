local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25btydf"

function var_0_0:__ctor()
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_hasBgController = self:getController("hasBg")
	self.m_allianceStateController = self:getController("allianceState")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_serverTxt = self:getChild("serverTxt")
	self.m_allianceTxt = self:getChild("allianceTxt")
	self.m_allianceIcon = self:getChild("allianceIcon")
	self.m_clearTime = self:getChild("clearTime")
end

var_0_0.HasPlayerCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasBgCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.AllianceStateCtrl = {
	none = 0,
	alliance = 1
}

return var_0_0
