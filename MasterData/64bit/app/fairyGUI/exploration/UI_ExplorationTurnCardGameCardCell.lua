local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25hlac6k"

function var_0_0:__ctor()
	self.m_isSelectedController = self:getController("isSelected")
	self.m_typeController = self:getController("type")
	self.m_boxSizeController = self:getController("boxSize")
	self.m_iconBg = self:getChild("iconBg")
	self.m_icon = self:getChild("icon")
	self.m_eff = self:getChild("eff")
	self.m_eff2 = self:getChild("eff2")
	self.m_fadeTransition = self:getTransition("fade")
end

var_0_0.IsSelectedCtrl = {
	page1 = 3,
	page0 = 2
}
var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.BoxSizeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2,
	page3 = 3
}

return var_0_0
