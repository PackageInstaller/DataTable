local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrswvx4l"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_normalController = self:getController("normal")
	self.m_showFragDetailController = self:getController("showFragDetail")
	self.m_isLockController = self:getController("isLock")
	self.m_isHasSpecialAttrController = self:getController("isHasSpecialAttr")
	self.m_refineScoreController = self:getController("refineScore")
	self.m_infoBaseComp = self:getChild("infoBaseComp")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_lockBtn = self:getChild("lockBtn")
	self.m_developBtn = self:getChild("developBtn")
	self.m_attrComp = self:getChild("attrComp")
	self.m_scrollTxtComp = self:getChild("scrollTxtComp")
	self.m_touchLayer = self:getChild("touchLayer")
	self.m_fragDetailComp = self:getChild("fragDetailComp")
	self.m_progNumText = self:getChild("progNumText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.NormalCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowFragDetailCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLockCtrl = {
	未锁 = 1,
	已锁 = 2,
	无锁 = 0
}
var_0_0.IsHasSpecialAttrCtrl = {
	有（SSR） = 1,
	没有 = 0
}
var_0_0.RefineScoreCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
