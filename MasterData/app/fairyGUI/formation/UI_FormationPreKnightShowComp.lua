local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99k856kk2r5"

function var_0_0:__ctor()
	self.m_isArtifactEmptyController = self:getController("isArtifactEmpty")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_knightLevelTxt = self:getChild("knightLevelTxt")
	self.m_advLevelTxt = self:getChild("advLevelTxt")
	self.m_associationIcon = self:getChild("associationIcon")
	self.m_artifactLevelTxt = self:getChild("artifactLevelTxt")
	self.m_artifactIcon = self:getChild("artifactIcon")
end

var_0_0.IsArtifactEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
