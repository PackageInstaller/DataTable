local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagknq94a"

function var_0_0:__ctor()
	self.m_popPanel = self:getChild("popPanel")
	self.m_gloryComp1 = self:getChild("gloryComp1")
	self.m_gloryComp2 = self:getChild("gloryComp2")
	self.m_gloryComp3 = self:getChild("gloryComp3")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
