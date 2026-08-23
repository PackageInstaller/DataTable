local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuis1i"

function var_0_0:__ctor()
	self.m_winController = self:getController("win")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_nameText = self:getChild("nameText")
	self.m_powerText = self:getChild("powerText")
	self.m_powerPreText = self:getChild("powerPreText")
	self.m_serverName = self:getChild("serverName")
end

var_0_0.WinCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
