local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2oe6dd8"

function var_0_0:__ctor()
	self.m_title = self:getChild("title")
	self.m_knightList = self:getChild("knightList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
