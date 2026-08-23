local var_0_0 = {}

var_0_0.URL = "ui://14huq3sfhob8r"

function var_0_0:__ctor()
	self.m_isFinishController = self:getController("isFinish")
	self.m_knightMask = self:getChild("knightMask")
	self.m_mainEnterEff = self:getChild("mainEnterEff")
	self.m_shiciEnterEff = self:getChild("shiciEnterEff")
	self.m_idleEff = self:getChild("idleEff")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
