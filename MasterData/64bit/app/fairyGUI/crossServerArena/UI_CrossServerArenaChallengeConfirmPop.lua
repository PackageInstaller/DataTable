local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagqtk926"

function var_0_0:__ctor()
	self.m_blankSpace = self:getChild("blankSpace")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_powerComp1 = self:getChild("powerComp1")
	self.m_powerComp2 = self:getChild("powerComp2")
	self.m_powerComp3 = self:getChild("powerComp3")
	self.m_enterBattleBtn = self:getChild("enterBattleBtn")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
