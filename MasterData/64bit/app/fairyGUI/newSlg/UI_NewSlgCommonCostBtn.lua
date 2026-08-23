local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9is2d68jg"

function var_0_0:__ctor()
	self.m_bgController = self:getController("bg")
	self.m_textColorController = self:getController("textColor")
	self.m_bgAlphaController = self:getController("bgAlpha")
	self.m_resEnoughController = self:getController("resEnough")
	self.m_showCostController = self:getController("showCost")
	self.m_bg_2 = self:getChild("bg")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_costTxt = self:getChild("costTxt")
end

var_0_0.BgCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}
var_0_0.TextColorCtrl = {
	page2 = 4,
	page1 = 3,
	page0 = 0
}
var_0_0.BgAlphaCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ResEnoughCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowCostCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
