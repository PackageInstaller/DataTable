local var_0_0 = {}

var_0_0.URL = "ui://kvb3znep869zibni"

function var_0_0:__ctor()
	self.m_showHaveController = self:getController("showHave")
	self.m_changeColorController = self:getController("changeColor")
	self.m_isLackController = self:getController("isLack")
	self.m_isOnSaleController = self:getController("isOnSale")
	self.m_useWhiteColorController = self:getController("useWhiteColor")
	self.m_iconScaleController = self:getController("iconScale")
	self.m_discountPriceTitle = self:getChild("discountPriceTitle")
	self.m_haveNum = self:getChild("haveNum")
end

var_0_0.ShowHaveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ChangeColorCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLackCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsOnSaleCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.UseWhiteColorCtrl = {
	whiteColor = 1,
	normal = 0
}
var_0_0.IconScaleCtrl = {
	["0.8"] = 1,
	["1"] = 0
}

return var_0_0
