local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepf1l915"

function var_0_0:__ctor()
	self.m_alignController = self:getController("align")
	self.m_vAlignController = self:getController("vAlign")
end

var_0_0.AlignCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.VAlignCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
