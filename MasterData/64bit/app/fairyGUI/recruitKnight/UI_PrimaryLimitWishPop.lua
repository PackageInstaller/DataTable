local var_0_0 = {}

var_0_0.URL = "ui://c64rm38y8vsrlgic6k"

function var_0_0:__ctor()
	self.m_mask = self:getChild("mask")
	self.m_memberList = self:getChild("memberList")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
