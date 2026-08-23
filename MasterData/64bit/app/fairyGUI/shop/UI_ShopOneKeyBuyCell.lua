local var_0_0 = {}

var_0_0.URL = "ui://454a48jprlqv1spemjj"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_goodList = self:getChild("goodList")
	self.m_shopIcon = self:getChild("shopIcon")
	self.m_shopNameTxt = self:getChild("shopNameTxt")
	self.m_resultTxt = self:getChild("resultTxt")
end

var_0_0.TypeCtrl = {
	汇总行 = 1,
	购买行 = 0
}

return var_0_0
