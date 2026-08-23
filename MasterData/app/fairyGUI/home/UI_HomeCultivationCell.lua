local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgqwum5ibmh"

function var_0_0:__ctor()
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_isDevelopController = self:getController("isDevelop")
	self.m_funcBg = self:getChild("funcBg")
	self.m_developBg = self:getChild("developBg")
	self.m_unlockTxt = self:getChild("unlockTxt")
	self.m_funcName = self:getChild("funcName")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsUnlockCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.IsDevelopCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
