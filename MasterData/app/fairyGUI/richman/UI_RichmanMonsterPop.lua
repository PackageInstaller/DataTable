local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwi6ei3t"

function var_0_0:__ctor()
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_monsterList = self:getChild("monsterList")
	self.m_rewardDescTxt = self:getChild("rewardDescTxt")
	self.m_monsterNumTxt = self:getChild("monsterNumTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
