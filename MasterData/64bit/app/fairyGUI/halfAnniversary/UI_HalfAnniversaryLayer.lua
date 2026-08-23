local var_0_0 = {}

var_0_0.URL = "ui://l1121lywokea0"

function var_0_0:__ctor()
	self.m_mapComp = self:getChild("mapComp")
	self.m_timePlaceHolder = self:getChild("timePlaceHolder")
	self.m_scoreComp = self:getChild("scoreComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_scoreBtn = self:getChild("scoreBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
