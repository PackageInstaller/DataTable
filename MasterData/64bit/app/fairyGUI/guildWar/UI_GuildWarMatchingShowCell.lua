local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9m75fds"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_serverName = self:getChild("serverName")
end

var_0_0.IsSelfCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
