local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7wmdze9"

function var_0_0:__ctor()
	self.m_positionTypeController = self:getController("positionType")
	self.m_selectController = self:getController("select")
	self.m_equipSelectController = self:getController("equipSelect")
	self.m_equipIconComp = self:getChild("equipIconComp")
end

var_0_0.PositionTypeCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.SelectCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EquipSelectCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
