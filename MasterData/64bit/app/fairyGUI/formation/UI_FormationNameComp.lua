local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99o3ikkk2p9"

function var_0_0:__ctor()
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_isMainController = self:getController("isMain")
	self.m_nameText = self:getChild("nameText")
	self.m_lockBg = self:getChild("lockBg")
end

var_0_0.IsUnlockCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsMainCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
