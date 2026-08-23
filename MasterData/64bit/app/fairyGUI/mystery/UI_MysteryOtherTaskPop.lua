local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8e6vvb22"

function var_0_0:__ctor()
	self.m_touchArea = self:getChild("touchArea")
	self.m_knightComp = self:getChild("knightComp")
	self.m_taskList = self:getChild("taskList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
