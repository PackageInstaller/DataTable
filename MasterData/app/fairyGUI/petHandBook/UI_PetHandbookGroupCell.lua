local var_0_0 = {}

var_0_0.URL = "ui://05rqz4hsmrvn3y"

function var_0_0:__ctor()
	self.m_canUpgradeController = self:getController("canUpgrade")
	self.m_upgradeTypeController = self:getController("upgradeType")
	self.m_downEff = self:getChild("downEff")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_qualityEnglish = self:getChild("qualityEnglish")
	self.m_gameName = self:getChild("gameName")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_groupName = self:getChild("groupName")
	self.m_picComp = self:getChild("picComp")
	self.m_attrComp = self:getChild("attrComp")
	self.m_upgradeBtn = self:getChild("upgradeBtn")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_upTxt = self:getChild("upTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_upEff = self:getChild("upEff")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
