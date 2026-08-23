local var_0_0 = {}

var_0_0.URL = "ui://6b52cxc1mb2pa6"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isMaxController = self:getController("isMax")
	self.m_title = self:getChild("title")
	self.m_desc1 = self:getChild("desc1")
	self.m_desc1_1 = self:getChild("desc1_1")
	self.m_desc2 = self:getChild("desc2")
	self.m_desc2_1 = self:getChild("desc2_1")
	self.m_moveDesc1 = self:getChild("moveDesc1")
	self.m_moveDesc2 = self:getChild("moveDesc2")
	self.m_startDesc = self:getChild("startDesc")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
