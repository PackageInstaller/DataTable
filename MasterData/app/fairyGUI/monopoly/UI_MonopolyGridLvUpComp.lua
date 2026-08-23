local var_0_0 = {}

var_0_0.URL = "ui://6b52cxc1iksvbj"

function var_0_0:__ctor()
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_beforeNum = self:getChild("beforeNum")
	self.m_afterNum = self:getChild("afterNum")
	self.m_showTransition = self:getTransition("show")
end

return var_0_0
