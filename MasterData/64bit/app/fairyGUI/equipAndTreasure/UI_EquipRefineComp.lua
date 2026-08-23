local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7qjvo28"

function var_0_0:__ctor()
	self.m_refineStateController = self:getController("refineState")
	self.m_haveEquipController = self:getController("haveEquip")
	self.m_showTipsController = self:getController("showTips")
	self.m_refineLimitTxt = self:getChild("refineLimitTxt")
	self.m_refineDescComp1 = self:getChild("refineDescComp1")
	self.m_refineDescComp2 = self:getChild("refineDescComp2")
	self.m_refineMatList = self:getChild("refineMatList")
	self.m_shortCutBtn = self:getChild("shortCutBtn")
	self.m_fiveKeyBtn = self:getChild("fiveKeyBtn")
	self.m_onekeyBtn = self:getChild("onekeyBtn")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_curLvTxt = self:getChild("curLvTxt")
	self.m_nextLvTxt = self:getChild("nextLvTxt")
	self.m_limitLv = self:getChild("limitLv")
	self.m_totalLv = self:getChild("totalLv")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.RefineStateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HaveEquipCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowTipsCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
