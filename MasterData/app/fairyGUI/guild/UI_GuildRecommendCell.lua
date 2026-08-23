local var_0_0 = {}

var_0_0.URL = "ui://h35b870bwjvm1h"

function var_0_0:__ctor()
	self.m_isFullController = self:getController("isFull")
	self.m_hasAllianceController = self:getController("hasAlliance")
	self.m_levelText = self:getChild("levelText")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_title = self:getChild("title")
	self.m_personNumText = self:getChild("personNumText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_applyLevel = self:getChild("applyLevel")
	self.m_allianceName = self:getChild("allianceName")
end

return var_0_0
