local var_0_0 = {}

var_0_0.URL = "ui://irs65rtsgvcpm9z"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_showList = self:getChild("showList")
end

return var_0_0
