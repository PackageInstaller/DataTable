local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy221"

function var_0_0:__ctor()
	self.m_hasUnlockListController = self:getController("hasUnlockList")
	self.m_lastLevelText = self:getChild("lastLevelText")
	self.m_curLevelText = self:getChild("curLevelText")
	self.m_unlockList = self:getChild("unlockList")
	self.m_awardList = self:getChild("awardList")
end

return var_0_0
