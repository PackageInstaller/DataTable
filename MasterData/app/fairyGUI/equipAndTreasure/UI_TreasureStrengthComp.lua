local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjs1m"

function var_0_0:__ctor()
	self.m_ctrlController = self:getController("ctrl")
	self.m_isOnekeyUnlockController = self:getController("isOnekeyUnlock")
	self.m_materialPanelController = self:getController("materialPanel")
	self.m_showBtnController = self:getController("showBtn")
	self.m_touchBg = self:getChild("touchBg")
	self.m_progress = self:getChild("progress")
	self.m_subLevel = self:getChild("subLevel")
	self.m_curLevelText = self:getChild("curLevelText")
	self.m_addLevelText = self:getChild("addLevelText")
	self.m_totalLevelText = self:getChild("totalLevelText")
	self.m_expText = self:getChild("expText")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_strengthBtn = self:getChild("strengthBtn")
	self.m_materialListPlaceHolder = self:getChild("materialListPlaceHolder")
	self.m_quickStrengthPlaceHolder = self:getChild("quickStrengthPlaceHolder")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.CtrlCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOnekeyUnlockCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.MaterialPanelCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
