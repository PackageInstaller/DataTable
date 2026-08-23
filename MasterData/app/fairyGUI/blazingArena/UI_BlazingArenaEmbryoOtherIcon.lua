local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9dmmi62"

function var_0_0:__ctor()
	self.m_hideLvController = self:getController("hideLv")
	self.m_hideAdvanceController = self:getController("hideAdvance")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_advanceBg = self:getChild("advanceBg")
	self.m_advanceText = self:getChild("advanceText")
end

return var_0_0
