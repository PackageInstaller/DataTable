local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6h17j1kk40v"

function var_0_0:__ctor()
	self.m_mask = self:getChild("mask")
	self.m_changeSizeTransition = self:getTransition("changeSize")
	self.m_changeSizeAllTransition = self:getTransition("changeSizeAll")
	self.m_hideAllTransition = self:getTransition("hideAll")
end

return var_0_0
