local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt912oj68b8"

function var_0_0:__ctor()
	self.m_hasAllianceController = self:getController("hasAlliance")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_S2TxtIcon = self:getChild("S2TxtIcon")
	self.m_lookBtn = self:getChild("lookBtn")
	self.m_goBtn = self:getChild("goBtn")
	self.m_btnNameTxt = self:getChild("btnNameTxt")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_previewBtn = self:getChild("previewBtn")
	self.m_introduceBtn = self:getChild("introduceBtn")
	self.m_awardBtn = self:getChild("awardBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasAllianceCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
