local var_0_0 = {}

var_0_0.URL = "ui://puryq37ki9x72k"

function var_0_0:__ctor()
	self.m_groupMemberComp = self:getChild("groupMemberComp")
	self.m_endCDTxt = self:getChild("endCDTxt")
	self.m_timeBg = self:getChild("timeBg")
	self.m_timeText = self:getChild("timeText")
	self.m_guessBtn = self:getChild("guessBtn")
	self.m_lineUpTimeBtn = self:getChild("lineUpTimeBtn")
	self.m_effTimeNode = self:getChild("effTimeNode")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_recordBtn = self:getChild("recordBtn")
	self.m_finalStartCDTxt = self:getChild("finalStartCDTxt")
	self.m_cheerNum = self:getChild("cheerNum")
	self.m_cheerGroup = self:getChild("cheerGroup")
	self.m_cheerTip = self:getChild("cheerTip")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
