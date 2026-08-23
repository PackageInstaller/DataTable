local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkpbi8j"

function var_0_0:__ctor()
	self.m_isFormationController = self:getController("isFormation")
	self.m_mulTeamFormationComp = self:getChild("mulTeamFormationComp")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsFormationCtrl = {
	formation = 1,
	battle = 0
}

return var_0_0
