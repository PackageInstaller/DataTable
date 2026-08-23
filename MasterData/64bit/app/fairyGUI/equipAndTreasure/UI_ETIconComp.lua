local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjs16"

function var_0_0:__ctor()
	self.m_positionTypeController = self:getController("positionType")
	self.m_equipStateController = self:getController("equipState")
	self.m_selectController = self:getController("select")
	self.m_equipSelectController = self:getController("equipSelect")
	self.m_equipIconComp = self:getChild("equipIconComp")
	self.m_plusImg = self:getChild("plusImg")
	self.m_addEffect = self:getChild("addEffect")
	self.m_treasureLockLoader = self:getChild("treasureLockLoader")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.PositionTypeCtrl = {
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.EquipStateCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.SelectCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.EquipSelectCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
