local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrne"

function var_0_0:__ctor()
	self.m_canPowerSkipController = self:getController("canPowerSkip")
	self.m_bgEffectNode = self:getChild("bgEffectNode")
	self.m_btnConfirm = self:getChild("btnConfirm")
	self.m_btnEffectNode = self:getChild("btnEffectNode")
	self.m_autoNode = self:getChild("autoNode")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.CanPowerSkipCtrl = {
	powerSkip = 1,
	normal = 0
}

return var_0_0
