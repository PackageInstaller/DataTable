local var_0_0 = {}

var_0_0.URL = "ui://foyq921slyd73w"

function var_0_0:__ctor()
	self.m_isUpBuffController = self:getController("isUpBuff")
	self.m_isSelectController = self:getController("isSelect")
	self.m_isNullKnightController = self:getController("isNullKnight")
	self.m_knightIcon = self:getChild("knightIcon")
end

var_0_0.IsUpBuffCtrl = {
	page0 = 1,
	page1 = 0
}
var_0_0.IsSelectCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsNullKnightCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
