local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9iqj733"

function var_0_0:__ctor()
	self.m_hideLvController = self:getController("hideLv")
	self.m_hideAdvanceController = self:getController("hideAdvance")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_advanceText = self:getChild("advanceText")
	self.m_elementLoader = self:getChild("elementLoader")
end

return var_0_0
