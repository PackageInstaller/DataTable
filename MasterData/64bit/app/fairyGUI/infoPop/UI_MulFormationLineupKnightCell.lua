local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnbh0lgic3e"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_leaderLoader = self:getChild("leaderLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_stateText = self:getChild("stateText")
end

var_0_0.LineUpStateCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
