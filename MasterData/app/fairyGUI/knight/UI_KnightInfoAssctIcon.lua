local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivw87bbnm"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_isLastController = self:getController("isLast")
	self.m_iconComp = self:getChild("iconComp")
end

var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLastCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
