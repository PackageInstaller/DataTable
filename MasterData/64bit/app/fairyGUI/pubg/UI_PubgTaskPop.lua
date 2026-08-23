local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcih18"

function var_0_0:__ctor()
	self.m_popPanel = self:getChild("popPanel")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_title = self:getChild("title")
	self.m_taskList = self:getChild("taskList")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
