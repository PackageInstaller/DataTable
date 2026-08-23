local var_0_0 = {}

var_0_0.URL = "ui://irs65rts10brm3k"

function var_0_0:__ctor()
	self.m_openOneKeyController = self:getController("openOneKey")
	self.m_popPanel = self:getChild("popPanel")
	self.m_stayList = self:getChild("stayList")
	self.m_oneKeyRelease = self:getChild("oneKeyRelease")
	self.m_oneKeyStayIn = self:getChild("oneKeyStayIn")
	self.m_content = self:getChild("content")
end

return var_0_0
