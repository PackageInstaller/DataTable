local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkx7dsmibz8"

function var_0_0:__ctor()
	self.m_passStateController = self:getController("passState")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_title = self:getChild("title")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
