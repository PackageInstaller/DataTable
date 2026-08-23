local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcg2dc59"

function var_0_0:__ctor()
	self.m_expandTip = self:getChild("expandTip")
	self.m_beforeNum = self:getChild("beforeNum")
	self.m_afterNum = self:getChild("afterNum")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
