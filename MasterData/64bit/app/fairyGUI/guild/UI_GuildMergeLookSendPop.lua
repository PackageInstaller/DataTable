local var_0_0 = {}

var_0_0.URL = "ui://h35b870bbpqe67"

function var_0_0:__ctor()
	self.m_isConfirmController = self:getController("isConfirm")
	self.m_popPanel = self:getChild("popPanel")
	self.m_userList = self:getChild("userList")
	self.m_userNum = self:getChild("userNum")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_timeDesc = self:getChild("timeDesc")
	self.m_content = self:getChild("content")
end

return var_0_0
