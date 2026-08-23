local var_0_0 = {}

var_0_0.URL = "ui://2r646mayqufe1k"

function var_0_0:__ctor()
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_codeInput = self:getChild("codeInput")
	self.m_btnExchange = self:getChild("btnExchange")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
