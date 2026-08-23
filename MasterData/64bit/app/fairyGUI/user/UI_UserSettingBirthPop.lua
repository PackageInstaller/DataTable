local var_0_0 = {}

var_0_0.URL = "ui://2r646maycfmu3a"

function var_0_0:__ctor()
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_monthInput = self:getChild("monthInput")
	self.m_dayInput = self:getChild("dayInput")
	self.m_btnConfirm = self:getChild("btnConfirm")
	self.m_content = self:getChild("content")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
