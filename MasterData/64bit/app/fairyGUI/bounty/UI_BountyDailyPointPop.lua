local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfblkv23"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_oneBtnStateController = self:getController("oneBtnState")
	self.m_popPanel = self:getChild("popPanel")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_playerList = self:getChild("playerList")
	self.m_content = self:getChild("content")
end

return var_0_0
