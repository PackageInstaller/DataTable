local var_0_0 = {}

var_0_0.URL = "ui://akds0szaq2854u"

function var_0_0:__ctor()
	self.m_mapLoader = self:getChild("mapLoader")
	self.m_mapName = self:getChild("mapName")
	self.m_mapDesc = self:getChild("mapDesc")
	self.m_timeAddition = self:getChild("timeAddition")
	self.m_teamAddition = self:getChild("teamAddition")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
