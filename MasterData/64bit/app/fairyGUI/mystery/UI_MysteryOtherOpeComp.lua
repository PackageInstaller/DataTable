local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8ekyg85s"

function var_0_0:__ctor()
	self.m_playerList = self:getChild("playerList")
	self.m_btnComp = self:getChild("btnComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
