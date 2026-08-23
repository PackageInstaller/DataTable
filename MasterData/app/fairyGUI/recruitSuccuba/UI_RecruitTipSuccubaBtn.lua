local var_0_0 = {}

var_0_0.URL = "ui://0vs2yqm8ira5s"

function var_0_0:__ctor()
	self.m_recruitModeController = self:getController("recruitMode")
	self.m_hideKnightController = self:getController("hideKnight")
	self.m_btnGroupModeController = self:getController("btnGroupMode")
	self.m_showFeatureController = self:getController("showFeature")
	self.m_knightComp = self:getChild("knightComp")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityTextLoader = self:getChild("qualityTextLoader")
	self.m_nameText1 = self:getChild("nameText1")
	self.m_qualityTextLoader1 = self:getChild("qualityTextLoader1")
	self.m_knightBtnGroup = self:getChild("knightBtnGroup")
	self.m_featureText1 = self:getChild("featureText1")
end

return var_0_0
