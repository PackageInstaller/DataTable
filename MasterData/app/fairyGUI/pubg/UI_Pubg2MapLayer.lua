local var_0_0 = {}

var_0_0.URL = "ui://pbd24silca8h74"

function var_0_0:__ctor()
	self.m_hasLevelChangeController = self:getController("hasLevelChange")
	self.m_isMaxLevelController = self:getController("isMaxLevel")
	self.m_mapComp = self:getChild("mapComp")
	self.m_playerIcon = self:getChild("playerIcon")
	self.m_quitBtn = self:getChild("quitBtn")
	self.m_scaleSlide = self:getChild("scaleSlide")
	self.m_asyncBtn = self:getChild("asyncBtn")
	self.m_obstacleBtn = self:getChild("obstacleBtn")
	self.m_logTest = self:getChild("logTest")
end

return var_0_0
