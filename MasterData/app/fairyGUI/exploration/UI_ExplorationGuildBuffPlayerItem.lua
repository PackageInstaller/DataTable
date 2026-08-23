local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25egt15d"

function var_0_0:__ctor()
	self.m_rankBgController = self:getController("rankBg")
	self.m_rankNumController = self:getController("rankNum")
	self.m_rankImg = self:getChild("rankImg")
	self.m_rankText = self:getChild("rankText")
	self.m_userIcon = self:getChild("userIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_powerText = self:getChild("powerText")
	self.m_playerGroup = self:getChild("playerGroup")
	self.m_noPlayerGroup = self:getChild("noPlayerGroup")
end

var_0_0.RankBgCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.RankNumCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
