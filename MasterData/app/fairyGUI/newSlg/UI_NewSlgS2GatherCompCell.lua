local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb96945"

function var_0_0:__ctor()
	self.m_gatherTypeController = self:getController("gatherType")
	self.m_hasDeclareController = self:getController("hasDeclare")
	self.m_periodController = self:getController("period")
	self.m_groupTip = self:getChild("groupTip")
	self.m_declareCd = self:getChild("declareCd")
	self.m_groupDeclare = self:getChild("groupDeclare")
	self.m_gatherIcon = self:getChild("gatherIcon")
	self.m_descTxt = self:getChild("descTxt")
	self.m_countDownProg = self:getChild("countDownProg")
	self.m_countDownTxt = self:getChild("countDownTxt")
	self.m_gatherBtn = self:getChild("gatherBtn")
	self.m_Comp_troopNum = self:getChild("Comp_troopNum")
	self.m_iconGatherNum = self:getChild("iconGatherNum")
	self.m_gatherNumTxt = self:getChild("gatherNumTxt")
	self.m_teamNumGroup = self:getChild("teamNumGroup")
	self.m_gotoBtn = self:getChild("gotoBtn")
end

var_0_0.GatherTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.HasDeclareCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.PeriodCtrl = {
	page2 = 3,
	page1 = 1,
	page4 = 5,
	page0 = 0,
	page3 = 4
}

return var_0_0
