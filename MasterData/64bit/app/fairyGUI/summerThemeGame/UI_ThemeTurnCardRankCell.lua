local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6sh26kk38k"

function var_0_0:__ctor()
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_lvText = self:getChild("lvText")
	self.m_nameText = self:getChild("nameText")
	self.m_guildText = self:getChild("guildText")
	self.m_scoreText = self:getChild("scoreText")
end

var_0_0.IsShowBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
