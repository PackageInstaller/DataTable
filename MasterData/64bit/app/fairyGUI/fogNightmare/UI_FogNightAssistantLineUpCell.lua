local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88od4e5rrma"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_stateText = self:getChild("stateText")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_leaderLoader = self:getChild("leaderLoader")
end

var_0_0.LineUpStateCtrl = {
	page0 = 0,
	page1 = 2
}

return var_0_0
