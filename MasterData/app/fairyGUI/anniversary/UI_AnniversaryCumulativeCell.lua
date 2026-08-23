local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiq9hnm2a"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isFinallyController = self:getController("isFinally")
	self.m_progress = self:getChild("progress")
	self.m_bg = self:getChild("bg")
	self.m_icon = self:getChild("icon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_endProgress = self:getChild("endProgress")
	self.m_effLoop = self:getChild("effLoop")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
