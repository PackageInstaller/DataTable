local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b5q9es0"

function var_0_0:__ctor()
	self.m_mapComp = self:getChild("mapComp")
	self.m_giveBtn = self:getChild("giveBtn")
	self.m_boxBtn = self:getChild("boxBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_monsterComp = self:getChild("monsterComp")
	self.m_topComp = self:getChild("topComp")
	self.m_challengeCountComp = self:getChild("challengeCountComp")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
