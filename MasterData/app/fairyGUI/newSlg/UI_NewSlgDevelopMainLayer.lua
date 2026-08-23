local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ewxk3l"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_developComp = self:getChild("developComp")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_reportBtn = self:getChild("reportBtn")
	self.m_bagBtn = self:getChild("bagBtn")
	self.m_lastReportBtn = self:getChild("lastReportBtn")
	self.m_taskComp = self:getChild("taskComp")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_timeGroup = self:getChild("timeGroup")
	self.m_chatComp = self:getChild("chatComp")
	self.m_compTeamInfo = self:getChild("compTeamInfo")
	self.m_strategyBtn = self:getChild("strategyBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
