local var_0_0 = {}

var_0_0.URL = "ui://qrucqci669obkk3aj"

function var_0_0:__ctor()
	self.m_isUnlimitedController = self:getController("isUnlimited")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_numText = self:getChild("numText")
	self.m_onceEffectHolderComp = self:getChild("onceEffectHolderComp")
end

var_0_0.IsUnlimitedCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
