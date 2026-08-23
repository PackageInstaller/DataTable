local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1d50t1o"

function var_0_0:__ctor()
	self.m_showTypeController = self:getController("showType")
	self.m_nodeTypeController = self:getController("nodeType")
	self.m_isActiveController = self:getController("isActive")
	self.m_preLine = self:getChild("preLine")
	self.m_nextLine = self:getChild("nextLine")
	self.m_effSelect = self:getChild("effSelect")
	self.m_bg = self:getChild("bg")
	self.m_icon = self:getChild("icon")
	self.m_effState = self:getChild("effState")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.ShowTypeCtrl = {
	down = 3,
	up = 2
}
var_0_0.NodeTypeCtrl = {
	page2 = 2,
	page1 = 0,
	page0 = 4,
	page3 = 1
}
var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
