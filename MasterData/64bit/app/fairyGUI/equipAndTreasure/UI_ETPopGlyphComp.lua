local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7f7jc8q"

function var_0_0:__ctor()
	self.m_iconComp1 = self:getChild("iconComp1")
	self.m_iconComp2 = self:getChild("iconComp2")
	self.m_effectComp = self:getChild("effectComp")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
