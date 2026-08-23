local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn87xip4by2xb"

function var_0_0:__ctor()
	self.m_popPanel = self:getChild("popPanel")
	self.m_checkList = self:getChild("checkList")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
