local var_0_0 = {}

var_0_0.URL = "ui://foyq921sfp076i"

function var_0_0:__ctor()
	self.m_stageTypeController = self:getController("stageType")
	self.m_hasAddCapacityController = self:getController("hasAddCapacity")
	self.m_btnTypeController = self:getController("btnType")
	self.m_showTipController = self:getController("showTip")
	self.m_tabController = self:getController("tab")
	self.m_teamFormationComp = self:getChild("teamFormationComp")
	self.m_monsterDescTxt = self:getChild("monsterDescTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_recommendValue = self:getChild("recommendValue")
	self.m_tabList = self:getChild("tabList")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StageTypeCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.HasAddCapacityCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.BtnTypeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowTipCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.TabCtrl = {
	page0 = 0
}

return var_0_0
