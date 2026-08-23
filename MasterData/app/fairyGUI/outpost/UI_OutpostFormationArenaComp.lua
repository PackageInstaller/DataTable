local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5lrhf76z"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_unlockController = self:getController("unlock")
	self.m_bgController = self:getController("bg")
	self.m_knightList = self:getChild("knightList")
	self.m_selArenaBtn = self:getChild("selArenaBtn")
	self.m_unlockStr = self:getChild("unlockStr")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
end

return var_0_0
