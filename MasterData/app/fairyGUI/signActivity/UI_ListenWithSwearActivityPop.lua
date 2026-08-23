local var_0_0 = {}

var_0_0.URL = "ui://9j4hqll0si1sa7k"

function var_0_0:__ctor()
	self.m_touchArea = self:getChild("touchArea")
	self.m_effSnowBgComp = self:getChild("effSnowBgComp")
	self.m_effBg = self:getChild("effBg")
	self.m_effSnowFrontComp = self:getChild("effSnowFrontComp")
	self.m_effLightsComp = self:getChild("effLightsComp")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_effUpGlowComp = self:getChild("effUpGlowComp")
	self.m_dayIcon1 = self:getChild("dayIcon1")
	self.m_dayIcon2 = self:getChild("dayIcon2")
	self.m_dayIcon3 = self:getChild("dayIcon3")
	self.m_dayIcon4 = self:getChild("dayIcon4")
	self.m_dayIcon5 = self:getChild("dayIcon5")
	self.m_dayIcon6 = self:getChild("dayIcon6")
	self.m_dayIcon7 = self:getChild("dayIcon7")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
