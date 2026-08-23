local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9v3rk45"

function var_0_0:__ctor()
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_knightComp1 = self:getChild("knightComp1")
	self.m_formationPowerTxt1 = self:getChild("formationPowerTxt1")
	self.m_knightComp2 = self:getChild("knightComp2")
	self.m_knightComp3 = self:getChild("knightComp3")
	self.m_formationPowerTxt2 = self:getChild("formationPowerTxt2")
	self.m_knightComp4 = self:getChild("knightComp4")
	self.m_knightComp5 = self:getChild("knightComp5")
	self.m_knightComp6 = self:getChild("knightComp6")
	self.m_formationPowerTxt3 = self:getChild("formationPowerTxt3")
	self.m_enterBattleBtn = self:getChild("enterBattleBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
