local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofhh9b4y"

function var_0_0:__ctor()
	self.m_closePnl = self:getChild("closePnl")
	self.m_knightComp = self:getChild("knightComp")
	self.m_artifactLoader = self:getChild("artifactLoader")
	self.m_normalList = self:getChild("normalList")
	self.m_payList = self:getChild("payList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
