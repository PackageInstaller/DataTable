local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgpwmg5ibnd"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_title = self:getChild("title")
	self.m_desText = self:getChild("desText")
	self.m_wayBtn = self:getChild("wayBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
