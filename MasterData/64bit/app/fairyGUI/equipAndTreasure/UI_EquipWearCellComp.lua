local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7dsi24n"

function var_0_0:__ctor()
	self.m_isWearController = self:getController("isWear")
	self.m_isHaveAssoController = self:getController("isHaveAsso")
	self.m_cellComp = self:getChild("cellComp")
	self.m_euqipNameTxt = self:getChild("euqipNameTxt")
	self.m_icon = self:getChild("icon")
	self.m_assoNumComp = self:getChild("assoNumComp")
end

var_0_0.IsWearCtrl = {
	未穿戴 = 0,
	已穿戴 = 1
}
var_0_0.IsHaveAssoCtrl = {
	有 = 1,
	无 = 0
}

return var_0_0
