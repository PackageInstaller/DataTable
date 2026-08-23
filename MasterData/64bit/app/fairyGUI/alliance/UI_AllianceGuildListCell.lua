local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lctba713"

function var_0_0:__ctor()
	self.m_showIndexController = self:getController("showIndex")
	self.m_isFullNumController = self:getController("isFullNum")
	self.m_showTypeController = self:getController("showType")
	self.m_flagComp = self:getChild("flagComp")
	self.m_name = self:getChild("name")
	self.m_level = self:getChild("level")
	self.m_userNum = self:getChild("userNum")
	self.m_fightValue = self:getChild("fightValue")
	self.m_lookBtn = self:getChild("lookBtn")
	self.m_refuseBtn = self:getChild("refuseBtn")
	self.m_agreeBtn = self:getChild("agreeBtn")
	self.m_expireTime = self:getChild("expireTime")
	self.m_revokeBtn = self:getChild("revokeBtn")
end

var_0_0.ShowIndexCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsFullNumCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowTypeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
