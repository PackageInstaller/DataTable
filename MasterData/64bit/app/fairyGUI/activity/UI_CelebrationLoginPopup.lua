local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wh5qwid"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_celebrationLoginComp = self:getChild("celebrationLoginComp")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
