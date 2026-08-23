local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjkvbj0"

function var_0_0:__ctor()
	self.m_relationNetComp = self:getChild("relationNetComp")
	self.m_curNumTxt = self:getChild("curNumTxt")
	self.m_allCountTxt = self:getChild("allCountTxt")
	self.m_worldViewArea = self:getChild("worldViewArea")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_relationSlider = self:getChild("relationSlider")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
