local var_0_0 = {}

var_0_0.URL = "ui://pbd24sila2kw6b"

function var_0_0:__ctor()
	self.m_isMaxLevelController = self:getController("isMaxLevel")
	self.m_isCountdownController = self:getController("isCountdown")
	self.m_countdownTransition = self:getTransition("countdown")
end

return var_0_0
