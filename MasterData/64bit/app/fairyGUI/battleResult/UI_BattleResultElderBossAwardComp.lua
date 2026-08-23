local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkxnvhmibzb"

function var_0_0:__ctor()
	self.m_newImg = self:getChild("newImg")
	self.m_damageTxt = self:getChild("damageTxt")
	self.m_maxRankTxt = self:getChild("maxRankTxt")
	self.m_curRankUpImg = self:getChild("curRankUpImg")
	self.m_getScoreTxt = self:getChild("getScoreTxt")
	self.m_historyRankDamageTxt = self:getChild("historyRankDamageTxt")
	self.m_historyRankUpImg = self:getChild("historyRankUpImg")
	self.m_awardList = self:getChild("awardList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
