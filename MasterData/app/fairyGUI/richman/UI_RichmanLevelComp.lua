local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwi6ei2a"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_progress = self:getChild("progress")
	self.m_progressImg = self:getChild("progressImg")
	self.m_eff = self:getChild("eff")
	self.m_curStarLoader = self:getChild("curStarLoader")
	self.m_curLvTxt = self:getChild("curLvTxt")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_levelTipComp = self:getChild("levelTipComp")
	self.m_nextStarLoader = self:getChild("nextStarLoader")
	self.m_nextLvTxt = self:getChild("nextLvTxt")
	self.m_nextLv = self:getChild("nextLv")
end

return var_0_0
