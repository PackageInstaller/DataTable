local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r76s"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_icon = self:getChild("icon")
	self.m_starComp = self:getChild("starComp")
end

return var_0_0
