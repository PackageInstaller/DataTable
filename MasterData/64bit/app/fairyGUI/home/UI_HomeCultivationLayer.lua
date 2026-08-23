local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgqwum5ibma"

function var_0_0:__ctor()
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_funcList = self:getChild("funcList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
