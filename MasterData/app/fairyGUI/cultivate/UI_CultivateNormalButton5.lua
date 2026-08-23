local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83ubj3p"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_titleBg = self:getChild("titleBg")
	self.m_iconColor = self:getChild("iconColor")
	self.m_finishIcon = self:getChild("finishIcon")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
