local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25ts9h54"

function var_0_0:__ctor()
	self.m_roomMapComp = self:getChild("roomMapComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_mapEnterEffect = self:getChild("mapEnterEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
