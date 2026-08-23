local var_0_0 = {}

var_0_0.URL = "ui://npkz19upms0t3"

function var_0_0:__ctor()
	self.m_isUseController = self:getController("isUse")
	self.m_isNominateController = self:getController("isNominate")
	self.m_knightIconLoader = self:getChild("knightIconLoader")
	self.m_selNumText = self:getChild("selNumText")
	self.m_selectGroup = self:getChild("selectGroup")
end

var_0_0.IsUseCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsNominateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
