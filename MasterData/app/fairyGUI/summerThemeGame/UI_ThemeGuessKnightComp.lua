local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6cfmu1kk40n"

function var_0_0:__ctor()
	self.m_knightHolderComp = self:getChild("knightHolderComp")
	self.m_mask = self:getChild("mask")
	self.m_errorImg = self:getChild("errorImg")
	self.m_errorAnimTransition = self:getTransition("errorAnim")
end

return var_0_0
