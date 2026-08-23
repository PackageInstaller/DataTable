local var_0_0 = {}

var_0_0.URL = "ui://p5u2oelkbdr82u"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_statusController = self:getController("status")
	self.m_newStatusController = self:getController("newStatus")
	self.m_scrollTxtComp = self:getChild("scrollTxtComp")
	self.m_timeText = self:getChild("timeText")
end

var_0_0.ButtonCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StatusCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1,
	page3 = 4
}
var_0_0.NewStatusCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
