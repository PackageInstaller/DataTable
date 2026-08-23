local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3v"

function var_0_0:__ctor()
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_title = self:getChild("title")
	self.m_listComp = self:getChild("listComp")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
