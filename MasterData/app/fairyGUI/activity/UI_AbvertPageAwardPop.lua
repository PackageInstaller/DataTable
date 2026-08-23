local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wqzu0jh"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_placeComp = self:getChild("placeComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
