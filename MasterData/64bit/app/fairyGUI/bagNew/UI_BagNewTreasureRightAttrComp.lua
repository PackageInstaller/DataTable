local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrlbh7kk316"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_normalController = self:getController("normal")
	self.m_showFragDetailController = self:getController("showFragDetail")
	self.m_isLockController = self:getController("isLock")
	self.m_isHasSpecialAttrController = self:getController("isHasSpecialAttr")
	self.m_refineScoreController = self:getController("refineScore")
	self.m_adLv = self:getChild("adLv")
	self.m_adAttr1 = self:getChild("adAttr1")
	self.m_adAttr2 = self:getChild("adAttr2")
	self.m_adAttrGroup = self:getChild("adAttrGroup")
	self.m_lvDesc = self:getChild("lvDesc")
	self.m_scoreBg = self:getChild("scoreBg")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_specialAttr1 = self:getChild("specialAttr1")
	self.m_specialAttr2 = self:getChild("specialAttr2")
	self.m_specialAttrGroup = self:getChild("specialAttrGroup")
	self.m_fraglvDesc = self:getChild("fraglvDesc")
	self.m_fragSpecialAttrTouch = self:getChild("fragSpecialAttrTouch")
	self.m_fragSpecialAttrGroup = self:getChild("fragSpecialAttrGroup")
	self.m_glyNotUpgrade = self:getChild("glyNotUpgrade")
	self.m_glyLevel = self:getChild("glyLevel")
	self.m_glyTipsTxt = self:getChild("glyTipsTxt")
	self.m_glyAttr1 = self:getChild("glyAttr1")
	self.m_glyAttr2 = self:getChild("glyAttr2")
	self.m_glyAttrGroup = self:getChild("glyAttrGroup")
	self.m_purifyTitleComp = self:getChild("purifyTitleComp")
	self.m_scoreBg2 = self:getChild("scoreBg2")
	self.m_scoreTxt2 = self:getChild("scoreTxt2")
	self.m_scoreGroup2 = self:getChild("scoreGroup2")
	self.m_purifyComp = self:getChild("purifyComp")
	self.m_purifyGroup = self:getChild("purifyGroup")
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
	无锁 = 0,
	已锁 = 2
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
