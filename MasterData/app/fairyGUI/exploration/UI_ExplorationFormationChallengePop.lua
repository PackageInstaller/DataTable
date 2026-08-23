local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25rjdy4k"

function var_0_0:__ctor()
	self.m_isMulTeamController = self:getController("isMulTeam")
	self.m_isEnoughController = self:getController("isEnough")
	self.m_isDebuffController = self:getController("isDebuff")
	self.m_enterEff1 = self:getChild("enterEff1")
	self.m_enterEff2 = self:getChild("enterEff2")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_challengeComp = self:getChild("challengeComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsMulTeamCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEnoughCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsDebuffCtrl = {
	debuff = 1,
	normal = 0
}

return var_0_0
