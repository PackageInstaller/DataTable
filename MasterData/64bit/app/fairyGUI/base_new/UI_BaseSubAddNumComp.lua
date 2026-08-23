local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepf83tibmf"

function var_0_0:__ctor()
	self.m_hideSubMinController = self:getController("hideSubMin")
	self.m_hideAddMaxController = self:getController("hideAddMax")
	self.m_canAddController = self:getController("canAdd")
	self.m_canReduceController = self:getController("canReduce")
	self.m_hideAddTenController = self:getController("hideAddTen")
	self.m_subMinBtn = self:getChild("subMinBtn")
	self.m_subOneBtn = self:getChild("subOneBtn")
	self.m_addOneBtn = self:getChild("addOneBtn")
	self.m_addMaxBtn = self:getChild("addMaxBtn")
	self.m_curNumText = self:getChild("curNumText")
	self.m_inputText = self:getChild("inputText")
	self.m_subTenBtn = self:getChild("subTenBtn")
	self.m_addTenBtn = self:getChild("addTenBtn")
end

var_0_0.HideSubMinCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HideAddMaxCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanAddCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanReduceCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HideAddTenCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
