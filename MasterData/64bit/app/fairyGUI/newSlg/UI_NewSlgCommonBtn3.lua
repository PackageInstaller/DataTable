local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9is2d68jh"

function var_0_0:__ctor()
	self.m_scaleController = self:getController("scale")
	self.m_showTitleController = self:getController("showTitle")
end

var_0_0.ScaleCtrl = {
	page4 = 3,
	page3 = 2,
	page2 = 1,
	page1 = 0,
	page0 = 4,
	page5 = 5
}
var_0_0.ShowTitleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
