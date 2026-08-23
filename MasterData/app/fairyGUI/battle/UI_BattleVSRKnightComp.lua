local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2ijna3s"

function var_0_0:__ctor()
	self.m_watermarkComp = self:getChild("watermarkComp")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
