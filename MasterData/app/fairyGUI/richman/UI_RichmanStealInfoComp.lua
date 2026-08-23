local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwuhr46f"

function var_0_0:__ctor()
	self.m_onlineController = self:getController("online")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_onlineStateTxt = self:getChild("onlineStateTxt")
	self.m_knightIcon = self:getChild("knightIcon")
end

return var_0_0
