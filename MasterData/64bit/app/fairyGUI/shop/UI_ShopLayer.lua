local var_0_0 = {}

var_0_0.URL = "ui://454a48jppfm00"

function var_0_0:__ctor()
	self.m_child = self:getChild("child")
	self.m_childComp = self:getChild("childComp")
	self.m_tabList = self:getChild("tabList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
