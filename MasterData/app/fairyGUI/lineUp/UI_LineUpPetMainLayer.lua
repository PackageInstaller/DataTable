local var_0_0 = {}

var_0_0.URL = "ui://ij78oondsl98h8"

function var_0_0:__ctor()
	self.m_petMainComp = self:getChild("petMainComp")
	self.m_lineUpList = self:getChild("lineUpList")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_gotoKnightLineupBtn = self:getChild("gotoKnightLineupBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
