local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcihk"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_knightMaskComp = self:getChild("knightMaskComp")
	self.m_userNameText = self:getChild("userNameText")
	self.m_serverNameText = self:getChild("serverNameText")
	self.m_userIcon = self:getChild("userIcon")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
