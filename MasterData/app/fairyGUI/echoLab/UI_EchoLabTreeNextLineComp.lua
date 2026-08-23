local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1d50t1q"

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
	self.m_line7 = self:getChild("line7")
	self.m_line8 = self:getChild("line8")
end

var_0_0.LineCtrl = {
	page2 = 1,
	page8 = 8,
	page1 = 0,
	page0 = 3,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 2
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
