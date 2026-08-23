local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm2d"

function var_0_0:__ctor()
	self.m_buffCountController = self:getController("buffCount")
	self.m_buffType1Controller = self:getController("buffType1")
	self.m_buffType2Controller = self:getController("buffType2")
	self.m_lineUpBtn = self:getChild("lineUpBtn")
	self.m_lineUpList = self:getChild("lineUpList")
	self.m_buffIcon1 = self:getChild("buffIcon1")
	self.m_buffIcon2 = self:getChild("buffIcon2")
end

var_0_0.BuffCountCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.BuffType1Ctrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page5 = 5,
	page4 = 4,
	page3 = 3
}
var_0_0.BuffType2Ctrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page5 = 5,
	page4 = 4,
	page3 = 3
}

return var_0_0
