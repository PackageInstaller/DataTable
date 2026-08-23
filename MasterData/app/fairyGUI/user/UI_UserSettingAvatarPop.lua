local var_0_0 = {}

var_0_0.URL = "ui://2r646mayqufe1e"

function var_0_0:__ctor()
	self.m_isUserIconController = self:getController("isUserIcon")
	self.m_btnStateController = self:getController("btnState")
	self.m_isLimitTimeController = self:getController("isLimitTime")
	self.m_popPanel = self:getChild("popPanel")
	self.m_tabList = self:getChild("tabList")
	self.m_avatarList = self:getChild("avatarList")
	self.m_userIcon = self:getChild("userIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_tipText = self:getChild("tipText")
	self.m_btnChange = self:getChild("btnChange")
	self.m_expireTimeTxt = self:getChild("expireTimeTxt")
	self.m_remainTimeTxt = self:getChild("remainTimeTxt")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsUserIconCtrl = {
	user = 1,
	normal = 0
}
var_0_0.BtnStateCtrl = {
	btn = 1,
	text = 0,
	lock = 2
}
var_0_0.IsLimitTimeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
