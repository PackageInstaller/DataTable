local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7t7xabi"

function var_0_0:__ctor()
	self.m_activeController = self:getController("active")
	self.m_iconScaleController = self:getController("iconScale")
	self.m_skillIconComp = self:getChild("skillIconComp")
	self.m_skillNumTxt = self:getChild("skillNumTxt")
	self.m_skillNameTxt = self:getChild("skillNameTxt")
	self.m_descTxt = self:getChild("descTxt")
end

var_0_0.ActiveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IconScaleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
