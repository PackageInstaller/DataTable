local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6h17j1kk41g"

function var_0_0:__ctor()
	self.m_knightImg = self:getChild("knightImg")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_blackWhiteTransition = self:getTransition("blackWhite")
end

return var_0_0
