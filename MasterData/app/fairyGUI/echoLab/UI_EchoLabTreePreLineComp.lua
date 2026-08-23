local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1d50t1p"

function var_0_0:__ctor()
	self.m_lineController = self:getController("line")
	self.m_nodeTypeController = self:getController("nodeType")
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_line1 = self:getChild("line1")
	self.m_line2 = self:getChild("line2")
	self.m_line3 = self:getChild("line3")
	self.m_line4 = self:getChild("line4")
	self.m_line5 = self:getChild("line5")
	self.m_line6 = self:getChild("line6")
end

var_0_0.LineCtrl = {
	page2 = 1,
	page5 = 11,
	page1 = 0,
	page4 = 9,
	page0 = 3,
	page6 = 12,
	page3 = 10
}
var_0_0.NodeTypeCtrl = {
	page0 = 3,
	page2 = 0,
	page1 = 2,
	page3 = 1
}
var_0_0.IsUnlockCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
