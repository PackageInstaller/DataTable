local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2c2if4r"

function var_0_0:__ctor()
	self.m_matchingDiskComp = self:getChild("matchingDiskComp")
	self.m_effDi = self:getChild("effDi")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_battleHeadList = self:getChild("battleHeadList")
	self.m_enterBattleBtn = self:getChild("enterBattleBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
