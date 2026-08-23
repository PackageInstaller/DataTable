local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7nnz07u"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_attrsNumController = self:getController("attrsNum")
	self.m_fontSizeController = self:getController("fontSize")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_atrrNumText = self:getChild("atrrNumText")
	self.m_atrr1 = self:getChild("atrr1")
	self.m_atrr2 = self:getChild("atrr2")
end

var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.AttrsNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.FontSizeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
