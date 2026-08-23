local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oh98h1emigay"

function var_0_0:__ctor()
	self.m_lineupController = self:getController("lineup")
	self.m_succubaIcon = self:getChild("succubaIcon")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_toBtn = self:getChild("toBtn")
end

return var_0_0
