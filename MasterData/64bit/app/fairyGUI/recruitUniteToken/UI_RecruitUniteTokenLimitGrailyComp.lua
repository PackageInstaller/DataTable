local var_0_0 = {}

var_0_0.URL = "ui://3jnmvl3pi0rblgicet"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_leftLoader = self:getChild("leftLoader")
	self.m_rightLoader = self:getChild("rightLoader")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")
	self.m_uniteTokenBtn1 = self:getChild("uniteTokenBtn1")
	self.m_titleEnTextLoader = self:getChild("titleEnTextLoader")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_limitFragmentLoader = self:getChild("limitFragmentLoader")
	self.m_limitTipLoader = self:getChild("limitTipLoader")
	self.m_mustGetGroup = self:getChild("mustGetGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
