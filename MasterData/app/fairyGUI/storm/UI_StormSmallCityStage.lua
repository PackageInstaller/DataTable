local var_0_0 = {}

var_0_0.URL = "ui://arku10fqoyrmt"

function var_0_0:__ctor()
	self.m_worldHold = self:getChild("worldHold")
	self.m_criComp = self:getChild("criComp")
	self.m_touchMap = self:getChild("touchMap")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_topBar = self:getChild("topBar")
	self.m_bagBtn = self:getChild("bagBtn")
	self.m_locationBtn = self:getChild("locationBtn")
	self.m_processTxt = self:getChild("processTxt")
	self.m_directionComp = self:getChild("directionComp")
	self.m_skipBattleBtn = self:getChild("skipBattleBtn")
end

return var_0_0
