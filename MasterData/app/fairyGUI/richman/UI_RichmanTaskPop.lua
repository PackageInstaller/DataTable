local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwuhr46j"

function var_0_0:__ctor()
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_taskList = self:getChild("taskList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
