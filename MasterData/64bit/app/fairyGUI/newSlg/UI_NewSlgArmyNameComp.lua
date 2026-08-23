local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1i"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_showIconController = self:getController("showIcon")
end

var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0,
	page4 = 4,
	page3 = 3,
	page2 = 2
}
var_0_0.ShowIconCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
