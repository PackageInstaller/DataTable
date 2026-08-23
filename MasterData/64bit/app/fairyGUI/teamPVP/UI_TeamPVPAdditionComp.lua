local var_0_0 = {}

var_0_0.URL = "ui://akds0szaeh7w1n"

function var_0_0:__ctor()
	self.m_title = self:getChild("title")
	self.m_value = self:getChild("value")
	self.m_tipBtn = self:getChild("tipBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
