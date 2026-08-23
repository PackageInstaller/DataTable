local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkxnvhmibzd"

function var_0_0:__ctor()
	self.m_pageController = self:getController("page")
	self.m_bgComp = self:getChild("bgComp")
	self.m_knightComp = self:getChild("knightComp")
	self.m_winComp = self:getChild("winComp")
	self.m_talkComp = self:getChild("talkComp")
	self.m_awardComp = self:getChild("awardComp")
	self.m_summaryBtn = self:getChild("summaryBtn")
	self.m_comEnterTransition = self:getTransition("comEnter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
