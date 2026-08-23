local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2eajl1t"

function var_0_0:__ctor()
	self.m_knightComp = self:getChild("knightComp")
	self.m_previewList = self:getChild("previewList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
