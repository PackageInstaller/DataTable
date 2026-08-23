local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qqa7"

function var_0_0:__ctor()
	self.m_openController = self:getController("open")
	self.m_iconController = self:getController("icon")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_lock = self:getChild("lock")
end

return var_0_0
