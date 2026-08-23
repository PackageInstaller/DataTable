local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vcjdrgcj"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_showTitleController = self:getController("showTitle")
	self.m_redpintController = self:getController("redpint")
	self.m_iconLock = self:getChild("iconLock")
	self.m_iconMark = self:getChild("iconMark")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
