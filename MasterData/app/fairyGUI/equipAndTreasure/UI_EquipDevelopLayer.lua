local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7a3lt21"

function var_0_0:__ctor()
	self.m_tabSelectController = self:getController("tabSelect")
	self.m_isWearController = self:getController("isWear")
	self.m_isExpandController = self:getController("isExpand")
	self.m_touchImg = self:getChild("touchImg")
	self.m_devComp = self:getChild("devComp")
	self.m_equipIconComp = self:getChild("equipIconComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_suitInfoComp = self:getChild("suitInfoComp")
	self.m_equipSuitList = self:getChild("equipSuitList")
	self.m_expandBtn = self:getChild("expandBtn")
	self.m_lineupComp = self:getChild("lineupComp")
	self.m_oneKeyEquipStrengthenBtn = self:getChild("oneKeyEquipStrengthenBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

var_0_0.TabSelectCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.IsWearCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsExpandCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
