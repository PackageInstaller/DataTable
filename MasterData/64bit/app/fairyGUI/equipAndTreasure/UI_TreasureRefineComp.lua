local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjs1q"

function var_0_0:__ctor()
	self.m_ctrlController = self:getController("ctrl")
	self.m_colorController = self:getController("color")
	self.m_specialValueNumController = self:getController("specialValueNum")
	self.m_curLevelText = self:getChild("curLevelText")
	self.m_nextLevelText = self:getChild("nextLevelText")
	self.m_specialAttrComp1 = self:getChild("specialAttrComp1")
	self.m_specialAttrComp2 = self:getChild("specialAttrComp2")
	self.m_refineTipBtn = self:getChild("refineTipBtn")
	self.m_talentName = self:getChild("talentName")
	self.m_descText = self:getChild("descText")
	self.m_refineTouchBtn = self:getChild("refineTouchBtn")
	self.m_talentComp = self:getChild("talentComp")
	self.m_icon = self:getChild("icon")
	self.m_treasureIcon = self:getChild("treasureIcon")
	self.m_resNumComp = self:getChild("resNumComp")
	self.m_refineBtn = self:getChild("refineBtn")
	self.m_fullLevelComp = self:getChild("fullLevelComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.CtrlCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SpecialValueNumCtrl = {
	["0条"] = 0,
	["2条"] = 2,
	["1条"] = 1
}

return var_0_0
