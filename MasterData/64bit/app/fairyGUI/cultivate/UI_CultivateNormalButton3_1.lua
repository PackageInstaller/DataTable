local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83e6av2b"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_iconColor = self:getChild("iconColor")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_finishIcon = self:getChild("finishIcon")
end

return var_0_0
