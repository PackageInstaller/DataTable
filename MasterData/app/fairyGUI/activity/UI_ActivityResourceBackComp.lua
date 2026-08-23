local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wfr76f8"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_descTxt = self:getChild("descTxt")
	self.m_coinTab = self:getChild("coinTab")
	self.m_goldTab = self:getChild("goldTab")
	self.m_taskList = self:getChild("taskList")
	self.m_getAllBtn = self:getChild("getAllBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
