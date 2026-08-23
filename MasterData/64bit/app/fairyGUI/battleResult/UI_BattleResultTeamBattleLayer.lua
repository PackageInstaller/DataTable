local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkkxd0mibye"

function var_0_0:__ctor()
	self.m_pageController = self:getController("page")
	self.m_bgComp = self:getChild("bgComp")
	self.m_knightComp = self:getChild("knightComp")
	self.m_damageComp = self:getChild("damageComp")
	self.m_rewardComp = self:getChild("rewardComp")
	self.m_summaryBtn = self:getChild("summaryBtn")
	self.m_comEnterTransition = self:getTransition("comEnter")
	self.m_backTransition = self:getTransition("back")
	self.m_failEnterTransition = self:getTransition("failEnter")
end

return var_0_0
