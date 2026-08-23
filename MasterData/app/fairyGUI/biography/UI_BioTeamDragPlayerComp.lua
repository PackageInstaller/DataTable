local var_0_0 = {}

var_0_0.URL = "ui://kgq5r794b1a0ibmj"

function var_0_0:__ctor()
	self.m_onlyShowSpineController = self:getController("onlyShowSpine")
	self.m_isCaptainController = self:getController("isCaptain")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_prepareSateController = self:getController("prepareSate")
	self.m_showTickOutController = self:getController("showTickOut")
	self.m_isBattleController = self:getController("isBattle")
	self.m_maskSpineComp = self:getChild("maskSpineComp")
	self.m_playerDescComp = self:getChild("playerDescComp")
	self.m_playerInfo = self:getChild("playerInfo")
	self.m_touchComp = self:getChild("touchComp")
	self.m_tickOutBtn = self:getChild("tickOutBtn")
end

return var_0_0
