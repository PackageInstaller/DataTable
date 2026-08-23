local var_0_0 = {}

var_0_0.URL = "ui://2r646maydco110"

function var_0_0:__ctor()
	self.m_copyServerIdBtn = self:getChild("copyServerIdBtn")
	self.m_serverText = self:getChild("serverText")
	self.m_serverIdText = self:getChild("serverIdText")
	self.m_versionText = self:getChild("versionText")
	self.m_userIdTxt = self:getChild("userIdTxt")
	self.m_copyRoleIdBtn = self:getChild("copyRoleIdBtn")
	self.m_roleIdText = self:getChild("roleIdText")
	self.m_copyCodeBtn = self:getChild("copyCodeBtn")
	self.m_codeText = self:getChild("codeText")
	self.m_menuList = self:getChild("menuList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
