local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lz1jkk30w"

function var_0_0:__ctor()
	self.m_worldHold = self:getChild("worldHold")
	self.m_criComp = self:getChild("criComp")
	self.m_touchMap = self:getChild("touchMap")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_locationBtn = self:getChild("locationBtn")
	self.m_boxComp1 = self:getChild("boxComp1")
	self.m_boxComp2 = self:getChild("boxComp2")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_timePowerBtn = self:getChild("timePowerBtn")
	self.m_bagEffHolder = self:getChild("bagEffHolder")
	self.m_lineUpBtn = self:getChild("lineUpBtn")
	self.m_touchPanel = self:getChild("touchPanel")
	self.m_enterTransition = self:getTransition("enter")
	self.m_hideTransition = self:getTransition("hide")
end

return var_0_0
