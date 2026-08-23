local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ofdpgrroq"

function var_0_0:__ctor()
	self.m_canQuickJumpController = self:getController("canQuickJump")
	self.m_timeText = self:getChild("timeText")
	self.m_title = self:getChild("title")
	self.m_valueTxt = self:getChild("valueTxt")
	self.m_touchComp = self:getChild("touchComp")
	self.m_getTimesBtn = self:getChild("getTimesBtn")
	self.m_startBtn = self:getChild("startBtn")
	self.m_selectComp = self:getChild("selectComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.CanQuickJumpCtrl = {
	jump = 1,
	normal = 0
}

return var_0_0
