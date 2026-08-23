local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagqtk938"

function var_0_0:__ctor()
	self.m_isSwitchController = self:getController("isSwitch")
	self.m_tabSelController = self:getController("tabSel")
	self.m_roundComp1 = self:getChild("roundComp1")
	self.m_roundComp2 = self:getChild("roundComp2")
	self.m_roundComp3 = self:getChild("roundComp3")
	self.m_editBtn = self:getChild("editBtn")
	self.m_rivalComp4 = self:getChild("rivalComp4")
	self.m_rivalComp1 = self:getChild("rivalComp1")
	self.m_rivalComp5 = self:getChild("rivalComp5")
	self.m_rivalComp2 = self:getChild("rivalComp2")
	self.m_rivalComp6 = self:getChild("rivalComp6")
	self.m_rivalComp3 = self:getChild("rivalComp3")
	self.m_buffComp = self:getChild("buffComp")
	self.m_buffGroup = self:getChild("buffGroup")
	self.m_switchBtn = self:getChild("switchBtn")
	self.m_blankFG = self:getChild("blankFG")
	self.m_battleTeamBtn1 = self:getChild("battleTeamBtn1")
	self.m_battleTeamBtn2 = self:getChild("battleTeamBtn2")
	self.m_battleTeamBtn3 = self:getChild("battleTeamBtn3")
	self.m_screenTouchBtn1 = self:getChild("screenTouchBtn1")
	self.m_screenTouchBtn2 = self:getChild("screenTouchBtn2")
	self.m_screenTouchBtn3 = self:getChild("screenTouchBtn3")
	self.m_nextBattleBtn = self:getChild("nextBattleBtn")
	self.m_enterBattleBtn = self:getChild("enterBattleBtn")
	self.m_knightComp4 = self:getChild("knightComp4")
	self.m_knightComp1 = self:getChild("knightComp1")
	self.m_knightComp5 = self:getChild("knightComp5")
	self.m_knightComp2 = self:getChild("knightComp2")
	self.m_knightComp6 = self:getChild("knightComp6")
	self.m_knightComp3 = self:getChild("knightComp3")
	self.m_myFightValueTxt = self:getChild("myFightValueTxt")
	self.m_myPowerNumTxt = self:getChild("myPowerNumTxt")
	self.m_rivalFightValueTxt = self:getChild("rivalFightValueTxt")
	self.m_rivalPowerNumTxt = self:getChild("rivalPowerNumTxt")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_contrastBtn = self:getChild("contrastBtn")
	self.m_ruleHolder = self:getChild("ruleHolder")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsSwitchCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TabSelCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
