local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9v1018gc3"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_correctController = self:getController("correct")
	self.m_selectedController = self:getController("selected")
	self.m_correct_2 = self:getChild("correct")
	self.m_state_2 = self:getChild("state")
	self.m_lock = self:getChild("lock")
	self.m_mark = self:getChild("mark")
end

return var_0_0
