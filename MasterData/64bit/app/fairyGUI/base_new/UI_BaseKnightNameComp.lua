local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepfi8xmp"

function var_0_0:__ctor()
	self.m_featureNumController = self:getController("featureNum")
	self.m_isElementLeaderController = self:getController("isElementLeader")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_starComp = self:getChild("starComp")
	self.m_nameText = self:getChild("nameText")
	self.m_stageText = self:getChild("stageText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_professionTxt = self:getChild("professionTxt")
	self.m_professionIcon = self:getChild("professionIcon")
	self.m_professionGroup = self:getChild("professionGroup")
	self.m_featureText1 = self:getChild("featureText1")
	self.m_featureText2 = self:getChild("featureText2")
	self.m_elementLoader = self:getChild("elementLoader")
end

var_0_0.FeatureNumCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsElementLeaderCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
