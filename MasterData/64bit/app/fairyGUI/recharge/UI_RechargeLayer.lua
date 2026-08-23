local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wq8o22j"

function var_0_0:__ctor()
	self.m_isHasSubTabController = self:getController("isHasSubTab")
	self.m_child = self:getChild("child")
	self.m_childComp = self:getChild("childComp")
	self.m_tabList = self:getChild("tabList")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.IsHasSubTabCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
