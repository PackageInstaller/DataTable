local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwvksz1"

function var_0_0:__ctor()
	self.m_worldComp = self:getChild("worldComp")
	self.m_diceHolder = self:getChild("diceHolder")
	self.m_debugTxt = self:getChild("debugTxt")
	self.m_debugBtn = self:getChild("debugBtn")
end

return var_0_0
