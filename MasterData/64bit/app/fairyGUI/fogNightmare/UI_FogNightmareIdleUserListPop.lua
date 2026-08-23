local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88o6jgp9rrtz"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_userList = self:getChild("userList")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
