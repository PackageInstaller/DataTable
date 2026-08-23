local var_0_0 = {}

var_0_0.URL = "ui://671qywx2etaz2m"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_title = self:getChild("title")
	self.m_desc = self:getChild("desc")
end

return var_0_0
