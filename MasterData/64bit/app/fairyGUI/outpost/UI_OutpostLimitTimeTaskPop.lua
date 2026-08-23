local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5sp297d8"

function var_0_0:__ctor()
	self.m_canGetAwardController = self:getController("canGetAward")
	self.m_timeTickEndController = self:getController("timeTickEnd")
	self.m_popPanel = self:getChild("popPanel")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_taskList = self:getChild("taskList")
	self.m_awardGetBtn = self:getChild("awardGetBtn")
	self.m_content = self:getChild("content")
end

return var_0_0
