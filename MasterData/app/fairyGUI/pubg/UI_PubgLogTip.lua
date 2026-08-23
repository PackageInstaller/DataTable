local var_0_0 = {}

var_0_0.URL = "ui://pbd24silvplz71"

function var_0_0:__ctor()
	self.m_logTitle = self:getChild("logTitle")
	self.m_winner = self:getChild("winner")
	self.m_loser = self:getChild("loser")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
