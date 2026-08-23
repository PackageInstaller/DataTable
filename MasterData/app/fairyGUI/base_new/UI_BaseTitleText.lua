local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepuhfxibmp"

function var_0_0:__ctor()
	self.m_showRedLineController = self:getController("showRedLine")
	self.m_showBtnController = self:getController("showBtn")
	self.m_showLineController = self:getController("showLine")
	self.m_redLine = self:getChild("redLine")
	self.m_bottomLine = self:getChild("bottomLine")
	self.m_infoBtn = self:getChild("infoBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowRedLineCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowBtnCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowLineCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
