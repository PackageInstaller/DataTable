local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9fq3n68fj"

function var_0_0:__ctor()
	self.m_selIndexController = self:getController("selIndex")
	self.m_showBgController = self:getController("showBg")
end

var_0_0.SelIndexCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
