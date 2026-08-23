local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88odkdqrriz"

function var_0_0:__ctor()
	self.m_showListController = self:getController("showList")
	self.m_isWinController = self:getController("isWin")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_closeComp = self:getChild("closeComp")
	self.m_effbg = self:getChild("effbg")
	self.m_effDownTitle = self:getChild("effDownTitle")
	self.m_effUpTitle = self:getChild("effUpTitle")
	self.m_stageText = self:getChild("stageText")
	self.m_addStageText = self:getChild("addStageText")
	self.m_historyMaxStageText = self:getChild("historyMaxStageText")
	self.m_knightBtn = self:getChild("knightBtn")
	self.m_talentBtn = self:getChild("talentBtn")
	self.m_knightList = self:getChild("knightList")
	self.m_talentList = self:getChild("talentList")
	self.m_winEnterTransition = self:getTransition("winEnter")
	self.m_failEnterTransition = self:getTransition("failEnter")
end

var_0_0.ShowListCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsWinCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
