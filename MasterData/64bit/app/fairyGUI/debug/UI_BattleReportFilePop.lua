local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ynth05ibhz"

function var_0_0:__ctor()
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_nameInput = self:getChild("nameInput")
	self.m_btnCancel = self:getChild("btnCancel")
	self.m_btnConfirm = self:getChild("btnConfirm")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
