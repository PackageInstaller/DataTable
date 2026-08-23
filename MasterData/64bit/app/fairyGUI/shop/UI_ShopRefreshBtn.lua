local var_0_0 = {}

var_0_0.URL = "ui://454a48jpot5r11"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_isMaxController = self:getController("isMax")
	self.m_freeNumTxt = self:getChild("freeNumTxt")
	self.m_consumeComp = self:getChild("consumeComp")
	self.m_refreshBtn = self:getChild("refreshBtn")
end

var_0_0.IsFreeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsMaxCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
