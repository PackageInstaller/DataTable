local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25ts9h55"

function var_0_0:__ctor()
	self.m_firstPosNode = self:getChild("firstPosNode")
	self.m_roomRootNode = self:getChild("roomRootNode")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
