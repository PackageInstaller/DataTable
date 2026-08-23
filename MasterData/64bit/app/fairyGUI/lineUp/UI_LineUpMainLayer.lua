local var_0_0 = {}

var_0_0.URL = "ui://ij78oondsw2z7o"

function var_0_0:__ctor()
	self.m_lineUpComp = self:getChild("lineUpComp")
	self.m_lineUpList = self:getChild("lineUpList")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_gotoPetLineupBtn = self:getChild("gotoPetLineupBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_recommendBtn = self:getChild("recommendBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
