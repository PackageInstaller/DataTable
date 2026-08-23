local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074btdpi"

function var_0_0:__ctor()
	self.m_hasBgController = self:getController("hasBg")
	self.m_hasUserController = self:getController("hasUser")
	self.m_isSelfController = self:getController("isSelf")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_userIcon = self:getChild("userIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_serverText = self:getChild("serverText")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_lvText = self:getChild("lvText")
	self.m_nameText = self:getChild("nameText")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_powerText = self:getChild("powerText")
end

var_0_0.HasBgCtrl = {
	has = 1,
	normal = 0
}
var_0_0.HasUserCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSelfCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
