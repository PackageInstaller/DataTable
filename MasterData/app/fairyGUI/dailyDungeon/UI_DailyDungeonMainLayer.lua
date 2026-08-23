local var_0_0 = {}

var_0_0.URL = "ui://7nx6gocgbmx92l"

function var_0_0:__ctor()
	self.m_topBar = self:getChild("topBar")
	self.m_effBgEnter = self:getChild("effBgEnter")
	self.m_enterItem1 = self:getChild("enterItem1")
	self.m_enterItem2 = self:getChild("enterItem2")
	self.m_enterItem3 = self:getChild("enterItem3")
	self.m_enterItem4 = self:getChild("enterItem4")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
