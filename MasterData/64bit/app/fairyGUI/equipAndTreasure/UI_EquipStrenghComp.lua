local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7a3lt23"

function var_0_0:__ctor()
	self.m_strengthStateController = self:getController("strengthState")
	self.m_haveEquipController = self:getController("haveEquip")
	self.m_showTipsController = self:getController("showTips")
	self.m_curLvTxt = self:getChild("curLvTxt")
	self.m_maxLvTxt = self:getChild("maxLvTxt")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_strengDescComp = self:getChild("strengDescComp")
	self.m_oneBtn = self:getChild("oneBtn")
	self.m_fiveBtn = self:getChild("fiveBtn")
	self.m_shortCutBtn = self:getChild("shortCutBtn")
	self.m_costBg = self:getChild("costBg")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costMoneyText = self:getChild("costMoneyText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StrengthStateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HaveEquipCtrl = {
	没装备 = 0,
	有装备 = 1
}
var_0_0.ShowTipsCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
