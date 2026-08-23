local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9m75fds"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_serverName = self:getChild("serverName")
end

var_0_0.IsSelfCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
