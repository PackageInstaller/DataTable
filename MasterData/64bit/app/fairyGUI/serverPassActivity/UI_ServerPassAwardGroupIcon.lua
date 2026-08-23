local var_0_0 = {}

var_0_0.URL = "ui://dy04zo9niea8x"

function var_0_0:__ctor()
	self.m_showUpValueController = self:getController("showUpValue")
	self.m_statueController = self:getController("statue")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_otherIcon = self:getChild("otherIcon")
	self.m_iconComp = self:getChild("iconComp")
	self.m_iconEffectComp = self:getChild("iconEffectComp")
	self.m_upValueTxt = self:getChild("upValueTxt")
	self.m_awardEffectComp = self:getChild("awardEffectComp")
	self.m_unlockEffectComp = self:getChild("unlockEffectComp")
end

return var_0_0
