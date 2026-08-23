local var_0_0 = {}

var_0_0.URL = "ui://2r646maya9me32"

function var_0_0:__ctor()
	self.m_wearStateController = self:getController("wearState")
	self.m_qualityController = self:getController("quality")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_effHolder = self:getChild("effHolder")
end

var_0_0.WearStateCtrl = {
	未穿戴 = 0,
	穿戴中 = 1
}
var_0_0.QualityCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page4 = 4
}

return var_0_0
