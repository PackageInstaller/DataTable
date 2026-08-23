local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88od4e5rrm5"

function var_0_0:__ctor()
	self.m_knightNumText = self:getChild("knightNumText")
	self.m_maxNumText = self:getChild("maxNumText")
	self.m_knightList = self:getChild("knightList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
