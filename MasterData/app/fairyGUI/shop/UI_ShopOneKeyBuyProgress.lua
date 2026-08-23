local var_0_0 = {}

var_0_0.URL = "ui://454a48jprlqv1spemjl"

function var_0_0:__ctor()
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_point1 = self:getChild("point1")
	self.m_point2 = self:getChild("point2")
	self.m_point3 = self:getChild("point3")
	self.m_loopTransition = self:getTransition("loop")
end

return var_0_0
