local var_0_0 = {}

var_0_0.URL = "ui://3g2xiq47nwyx1t"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_hasKnight1Controller = self:getController("hasKnight1")
	self.m_hasKnight2Controller = self:getController("hasKnight2")
	self.m_isCaptain1Controller = self:getController("isCaptain1")
	self.m_isCaptain2Controller = self:getController("isCaptain2")
	self.m_hasArtifactController = self:getController("hasArtifact")
	self.m_knightCard1 = self:getChild("knightCard1")
	self.m_index = self:getChild("index")
	self.m_professionBg1 = self:getChild("professionBg1")
	self.m_professionIcon1 = self:getChild("professionIcon1")
	self.m_elementIcon1 = self:getChild("elementIcon1")
	self.m_artifactIcon1 = self:getChild("artifactIcon1")
	self.m_knightName1 = self:getChild("knightName1")
	self.m_knightCard2 = self:getChild("knightCard2")
	self.m_professionBg2 = self:getChild("professionBg2")
	self.m_professionIcon2 = self:getChild("professionIcon2")
	self.m_elementIcon2 = self:getChild("elementIcon2")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasKnight1Ctrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasKnight2Ctrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsCaptain1Ctrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsCaptain2Ctrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasArtifactCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
