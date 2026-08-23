local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8luss5f4"

function var_0_0:__ctor()
	self.m_lineupController = self:getController("lineup")
	self.m_qualityBgLoader = self:getChild("qualityBgLoader")
	self.m_petIconLoader = self:getChild("petIconLoader")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_stageTxt = self:getChild("stageTxt")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_starComp = self:getChild("starComp")
end

return var_0_0
