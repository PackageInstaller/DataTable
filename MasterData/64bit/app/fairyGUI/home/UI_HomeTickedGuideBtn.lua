local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgeo555ibke"

function var_0_0:__ctor()
	self.m_touchBg = self:getChild("touchBg")
	self.m_effComp = self:getChild("effComp")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_descTxt = self:getChild("descTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
