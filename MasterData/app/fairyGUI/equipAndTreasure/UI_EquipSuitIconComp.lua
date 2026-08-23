local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7frwp38"

function var_0_0:__ctor()
	self.m_partCtrlController = self:getController("partCtrl")
	self.m_onWearController = self:getController("onWear")
	self.m_showIconController = self:getController("showIcon")
	self.m_iconComp = self:getChild("iconComp")
	self.m_partIcon = self:getChild("partIcon")
	self.m_glyIcon = self:getChild("glyIcon")
end

var_0_0.PartCtrlCtrl = {
	武器 = 0,
	鞋子 = 1,
	盔甲 = 2,
	帽子 = 3
}
var_0_0.OnWearCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowIconCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
