local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gz2du2z"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_desc = self:getChild("desc")
	self.m_gotoBtn = self:getChild("gotoBtn")
end

return var_0_0
