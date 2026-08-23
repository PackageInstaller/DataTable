local var_0_0 = {}

var_0_0.URL = "ui://f3nqxjsnx1c77"

function var_0_0:__ctor()
	self.m_numsController = self:getController("nums")
	self.m_touchGraph = self:getChild("touchGraph")
	self.m_chooseBtn1 = self:getChild("chooseBtn1")
	self.m_chooseBtn2 = self:getChild("chooseBtn2")
	self.m_chooseBtn3 = self:getChild("chooseBtn3")
	self.m_enter0Transition = self:getTransition("enter0")
	self.m_enter1Transition = self:getTransition("enter1")
end

return var_0_0
