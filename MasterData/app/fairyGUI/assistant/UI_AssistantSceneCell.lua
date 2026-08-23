local var_0_0 = {}

var_0_0.URL = "ui://npkz19upu6h8w"

function var_0_0:__ctor()
	self.m_isUseController = self:getController("isUse")
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_scenePicLoader = self:getChild("scenePicLoader")
	self.m_unlockText = self:getChild("unlockText")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsUseCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsUnlockCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
