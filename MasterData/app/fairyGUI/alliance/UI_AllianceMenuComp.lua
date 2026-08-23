local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcqutz1a"

function var_0_0:__ctor()
	self.m_menuList = self:getChild("menuList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
