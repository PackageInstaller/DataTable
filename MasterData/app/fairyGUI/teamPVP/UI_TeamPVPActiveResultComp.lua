local var_0_0 = {}

var_0_0.URL = "ui://akds0szaq47q54"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_knightMask = self:getChild("knightMask")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_userName = self:getChild("userName")
	self.m_serverName = self:getChild("serverName")
	self.m_userIcon = self:getChild("userIcon")
end

return var_0_0
