local var_0_0 = {}

var_0_0.URL = "ui://dy04zo9niea8r"

function var_0_0:__ctor()
	self.m_showUpValueController = self:getController("showUpValue")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_otherIcon = self:getChild("otherIcon")
	self.m_iconComp = self:getChild("iconComp")
	self.m_upValueTxt = self:getChild("upValueTxt")
end

return var_0_0
