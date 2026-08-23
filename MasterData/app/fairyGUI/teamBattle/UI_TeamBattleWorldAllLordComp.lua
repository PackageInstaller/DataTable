local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd09w"

function var_0_0:__ctor()
	self.m_knightPicComp3 = self:getChild("knightPicComp3")
	self.m_knightPicComp2 = self:getChild("knightPicComp2")
	self.m_knightPicComp1 = self:getChild("knightPicComp1")
	self.m_playInfoLoader1 = self:getChild("playInfoLoader1")
	self.m_playInfoLoader2 = self:getChild("playInfoLoader2")
	self.m_playInfoLoader3 = self:getChild("playInfoLoader3")
	self.m_playerInfoComp1 = self:getChild("playerInfoComp1")
	self.m_playerInfoComp2 = self:getChild("playerInfoComp2")
	self.m_playerInfoComp3 = self:getChild("playerInfoComp3")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
