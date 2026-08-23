local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88o6jgp9rrtw"

function var_0_0:__ctor()
	self.m_hasUserController = self:getController("hasUser")
	self.m_title = self:getChild("title")
	self.m_descList = self:getChild("descList")
	self.m_userComp = self:getChild("userComp")
	self.m_userListBtn = self:getChild("userListBtn")
end

var_0_0.HasUserCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
