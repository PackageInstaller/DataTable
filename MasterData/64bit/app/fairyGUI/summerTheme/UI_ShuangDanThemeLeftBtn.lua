local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lg7n9bnoq1"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_redPosController = self:getController("redPos")
	self.m_title1 = self:getChild("title1")
	self.m_smallIcon = self:getChild("smallIcon")
	self.m_openTimeTxt = self:getChild("openTimeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	未开启 = 0,
	结束 = 2,
	开启 = 1
}
var_0_0.RedPosCtrl = {
	page2 = 5,
	page1 = 1,
	page0 = 0
}

return var_0_0
