local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7fc69ai"

function var_0_0:__ctor()
	self.m_onekeyController = self:getController("onekey")
	self.m_uplimitedController = self:getController("uplimited")
	self.m_isCheckController = self:getController("isCheck")
	self.m_titleComp = self:getChild("titleComp")
	self.m_matList = self:getChild("matList")
	self.m_block = self:getChild("block")
	self.m_advBtn0 = self:getChild("advBtn0")
	self.m_advBtn1 = self:getChild("advBtn1")
	self.m_onekeyBtn = self:getChild("onekeyBtn")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.OnekeyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.UplimitedCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsCheckCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
