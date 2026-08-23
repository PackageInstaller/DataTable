local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99u7kxkk2q0"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_isActiveAssctController = self:getController("isActiveAssct")
	self.m_hasActiveController = self:getController("hasActive")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_leaderLoader = self:getChild("leaderLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
	self.m_starComp = self:getChild("starComp")
	self.m_activeNum = self:getChild("activeNum")
	self.m_assctNum = self:getChild("assctNum")
	self.m_assctMaxNum = self:getChild("assctMaxNum")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_stateText = self:getChild("stateText")
end

var_0_0.LineUpStateCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 2
}
var_0_0.IsActiveAssctCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
