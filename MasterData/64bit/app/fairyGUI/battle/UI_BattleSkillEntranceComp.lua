local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2k91v5x"

function var_0_0:__ctor()
	self.m_linesController = self:getController("lines")
	self.m_effSkill = self:getChild("effSkill")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_firstPartText = self:getChild("firstPartText")
	self.m_secondPartText = self:getChild("secondPartText")
end

var_0_0.LinesCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
