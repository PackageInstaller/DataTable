local var_0_0 = {}

var_0_0.URL = "ui://454a48jpw64bwkk34h"

function var_0_0:__ctor()
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_lockLoader = self:getChild("lockLoader")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsUnlockCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
