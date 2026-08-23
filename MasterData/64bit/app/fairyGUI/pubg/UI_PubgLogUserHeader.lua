local var_0_0 = {}

var_0_0.URL = "ui://pbd24silvplz72"

function var_0_0:__ctor()
	self.m_isWinnerController = self:getController("isWinner")
	self.m_userHeader = self:getChild("userHeader")
	self.m_userName = self:getChild("userName")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
