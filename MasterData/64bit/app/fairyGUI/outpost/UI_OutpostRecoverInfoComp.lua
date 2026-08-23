local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5c3h27bt"

function var_0_0:__ctor()
	self.m_isMaxLevelController = self:getController("isMaxLevel")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_curBonusInfoList = self:getChild("curBonusInfoList")
	self.m_nextBonusInfoList = self:getChild("nextBonusInfoList")
	self.m_progComp = self:getChild("progComp")
	self.m_costComp = self:getChild("costComp")
	self.m_levelUpBtn = self:getChild("levelUpBtn")
	self.m_effectNode = self:getChild("effectNode")
end

return var_0_0
