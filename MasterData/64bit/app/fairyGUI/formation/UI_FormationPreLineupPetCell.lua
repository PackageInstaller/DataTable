local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99u7kxkk2q6"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_qualityBgLoader = self:getChild("qualityBgLoader")
	self.m_petIconLoader = self:getChild("petIconLoader")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
	self.m_levelTxt = self:getChild("levelTxt")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
