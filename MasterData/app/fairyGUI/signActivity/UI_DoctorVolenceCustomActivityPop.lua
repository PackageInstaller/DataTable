local var_0_0 = {}

var_0_0.URL = "ui://9j4hqll0h9klafd"

function var_0_0:__ctor()
	self.m_roleLoader = self:getChild("roleLoader")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_dayIcon1 = self:getChild("dayIcon1")
	self.m_dayIcon2 = self:getChild("dayIcon2")
	self.m_dayIcon3 = self:getChild("dayIcon3")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
