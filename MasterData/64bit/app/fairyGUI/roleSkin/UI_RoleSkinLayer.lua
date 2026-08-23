local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0c0"

function var_0_0:__ctor()
	self.m_partController = self:getController("part")
	self.m_hasSelController = self:getController("hasSel")
	self.m_partItemList = self:getChild("partItemList")
	self.m_spineDad = self:getChild("spineDad")
	self.m_effRefresh = self:getChild("effRefresh")
	self.m_effEquip = self:getChild("effEquip")
	self.m_wearBtn = self:getChild("wearBtn")
	self.m_rightPanel = self:getChild("rightPanel")
	self.m_tabList = self:getChild("tabList")
	self.m_runnerComp = self:getChild("runnerComp")
	self.m_partName = self:getChild("partName")
	self.m_ownNum = self:getChild("ownNum")
	self.m_totalNum = self:getChild("totalNum")
	self.m_nameComp = self:getChild("nameComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_equipTransition = self:getTransition("equip")
end

var_0_0.PartCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 4
}
var_0_0.HasSelCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
