local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1gcrn2q"

function var_0_0:__ctor()
	self.m_nodeTypeController = self:getController("nodeType")
	self.m_preLine = self:getChild("preLine")
	self.m_nextLine = self:getChild("nextLine")
end

var_0_0.NodeTypeCtrl = {
	page0 = 4,
	page2 = 2,
	page1 = 0,
	page3 = 1
}

return var_0_0
