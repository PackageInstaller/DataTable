local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lo3z8eb"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_roomList = self:getChild("roomList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
