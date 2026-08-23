local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2smw2h9c"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_blueClock = self:getChild("blueClock")
	self.m_redClock = self:getChild("redClock")
end

return var_0_0
