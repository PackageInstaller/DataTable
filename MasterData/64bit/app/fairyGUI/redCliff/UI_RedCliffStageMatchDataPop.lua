local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sddye3q"

function var_0_0:__ctor()
	self.m_closeBg = self:getChild("closeBg")
	self.m_playerList = self:getChild("playerList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
