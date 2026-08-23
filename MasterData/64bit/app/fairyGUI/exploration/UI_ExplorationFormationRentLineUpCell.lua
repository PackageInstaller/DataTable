local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25nbgf87"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_stateText = self:getChild("stateText")
	self.m_elementLoader = self:getChild("elementLoader")
end

var_0_0.LineUpStateCtrl = {
	page1 = 2,
	page0 = 0
}

return var_0_0
