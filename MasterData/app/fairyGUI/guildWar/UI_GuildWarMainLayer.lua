local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mtk7x0"

function var_0_0:__ctor()
	self.m_bgNode = self:getChild("bgNode")
	self.m_mainCompDad = self:getChild("mainCompDad")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
