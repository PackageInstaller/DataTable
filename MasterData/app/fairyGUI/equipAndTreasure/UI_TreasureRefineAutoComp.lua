local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7lbh7bp"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_upScoreController = self:getController("upScore")
	self.m_showLockCostController = self:getController("showLockCost")
	self.m_isUseNewItemController = self:getController("isUseNewItem")
	self.m_totalScoreTxt = self:getChild("totalScoreTxt")
	self.m_curScoreTxt = self:getChild("curScoreTxt")
	self.m_tmpScoreTxt = self:getChild("tmpScoreTxt")
	self.m_upScoreFlag = self:getChild("upScoreFlag")
	self.m_purifyAttr1 = self:getChild("purifyAttr1")
	self.m_purifyAttr2 = self:getChild("purifyAttr2")
	self.m_purifyAttr3 = self:getChild("purifyAttr3")
	self.m_purifyAttr4 = self:getChild("purifyAttr4")
	self.m_purifyAttr5 = self:getChild("purifyAttr5")
	self.m_purifyAttr6 = self:getChild("purifyAttr6")
	self.m_lockCost = self:getChild("lockCost")
	self.m_normalCost = self:getChild("normalCost")
	self.m_resNumComp = self:getChild("resNumComp")
	self.m_purifyBtn = self:getChild("purifyBtn")
	self.m_tenPurifyBtn = self:getChild("tenPurifyBtn")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_saveBtn = self:getChild("saveBtn")
	self.m_effholder = self:getChild("effholder")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.UpScoreCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ShowLockCostCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsUseNewItemCtrl = {
	new = 1,
	normal = 0
}

return var_0_0
