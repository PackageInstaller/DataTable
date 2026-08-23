local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oey4zrrma"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_playerIcon = self:getChild("playerIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_serverName = self:getChild("serverName")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
