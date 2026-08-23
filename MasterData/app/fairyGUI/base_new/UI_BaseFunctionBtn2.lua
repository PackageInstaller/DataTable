local var_0_0 = {}

var_0_0.URL = "ui://kvb3znephxleibpi"

function var_0_0:__ctor()
	self.m_textColorController = self:getController("textColor")
	self.m_scaleController = self:getController("scale")
	self.m_iconScaleController = self:getController("iconScale")
	self.m_icon2 = self:getChild("icon2")
end

var_0_0.TextColorCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ScaleCtrl = {
	["80%"] = 1,
	["60%"] = 2,
	["65%"] = 3,
	["70%"] = 4,
	["100%"] = 0
}
var_0_0.IconScaleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
