local var_0_0 = {}

var_0_0.URL = "ui://pbd24sil7en81f"

function var_0_0:__ctor()
	self.m_hasLevelChangeController = self:getController("hasLevelChange")
	self.m_isMaxLevelController = self:getController("isMaxLevel")
	self.m_mapComp = self:getChild("mapComp")
	self.m_rankComp = self:getChild("rankComp")
	self.m_playInfoComp = self:getChild("playInfoComp")
	self.m_recordComp = self:getChild("recordComp")
	self.m_miniMapComp = self:getChild("miniMapComp")
	self.m_timeComp = self:getChild("timeComp")
	self.m_fertileTip = self:getChild("fertileTip")
	self.m_playerIcon = self:getChild("playerIcon")
	self.m_quitBtn = self:getChild("quitBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
