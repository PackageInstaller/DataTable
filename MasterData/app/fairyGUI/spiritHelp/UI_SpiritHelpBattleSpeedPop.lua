local var_0_0 = {}

var_0_0.URL = "ui://favjv59oqrc51l"

function var_0_0:__ctor()
	self.m_title = self:getChild("title")
	self.m_speedBtn = self:getChild("speedBtn")
	self.m_battleSpeed = self:getChild("battleSpeed")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
