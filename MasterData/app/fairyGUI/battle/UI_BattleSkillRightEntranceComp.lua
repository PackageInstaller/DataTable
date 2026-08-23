local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2la3j64"

function var_0_0:__ctor()
	self.m_linesController = self:getController("lines")
	self.m_effSkill = self:getChild("effSkill")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_firstPartText = self:getChild("firstPartText")
	self.m_secondPartText = self:getChild("secondPartText")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.LinesCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
