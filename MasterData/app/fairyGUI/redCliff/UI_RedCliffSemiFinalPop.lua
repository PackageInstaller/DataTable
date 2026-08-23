local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sddye3s"

function var_0_0:__ctor()
	self.m_roomIdController = self:getController("roomId")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_playerList = self:getChild("playerList")
	self.m_content = self:getChild("content")
end

return var_0_0
