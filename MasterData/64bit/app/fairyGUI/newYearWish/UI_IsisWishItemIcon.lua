local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94xcdq7f"

function var_0_0:__ctor()
	self.m_qulityController = self:getController("qulity")
	self.m_isGetAwardController = self:getController("isGetAward")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_numberText = self:getChild("numberText")
end

var_0_0.QulityCtrl = {
	page0 = 0,
	page3 = 3,
	page2 = 2,
	page1 = 1
}
var_0_0.IsGetAwardCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
