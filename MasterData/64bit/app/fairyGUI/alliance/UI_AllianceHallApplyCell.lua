local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0qd"

function var_0_0:__ctor()
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_guildPic = self:getChild("guildPic")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_applyName = self:getChild("applyName")
	self.m_serverName = self:getChild("serverName")
	self.m_memberNum = self:getChild("memberNum")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_refuseBtn = self:getChild("refuseBtn")
	self.m_approveBtn = self:getChild("approveBtn")
end

var_0_0.IsShowBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
