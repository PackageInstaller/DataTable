local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofhh9b4x"

function var_0_0:__ctor()
	self.m_knightComp = self:getChild("knightComp")
	self.m_artifactLoader = self:getChild("artifactLoader")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_lvComp = self:getChild("lvComp")
	self.m_contentComp = self:getChild("contentComp")
	self.m_detailBtn1 = self:getChild("detailBtn1")
	self.m_detailBtn2 = self:getChild("detailBtn2")
	self.m_seasonComp = self:getChild("seasonComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
