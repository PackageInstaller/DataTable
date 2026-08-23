local var_0_0 = {}

var_0_0.URL = "ui://6b52cxc1jlh692"

function var_0_0:__ctor()
	self.m_numberController = self:getController("number")
	self.m_num1 = self:getChild("num1")
	self.m_num2 = self:getChild("num2")
	self.m_num3 = self:getChild("num3")
	self.m_num4 = self:getChild("num4")
	self.m_num5 = self:getChild("num5")
	self.m_num6 = self:getChild("num6")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
