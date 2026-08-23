local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nk8llxmibyl"

function var_0_0:__ctor()
	self.m_pageController = self:getController("page")
	self.m_bgComp = self:getChild("bgComp")
	self.m_knightComp = self:getChild("knightComp")
	self.m_talkComp = self:getChild("talkComp")
	self.m_summaryBtn = self:getChild("summaryBtn")
	self.m_rewardComp = self:getChild("rewardComp")
	self.m_comEnterTransition = self:getTransition("comEnter")
	self.m_failEnterTransition = self:getTransition("failEnter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
