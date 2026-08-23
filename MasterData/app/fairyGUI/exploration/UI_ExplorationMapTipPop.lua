local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25wbwb8q"

function var_0_0:__ctor()
	self.m_title = self:getChild("title")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
