local var_0_0 = {}

var_0_0.URL = "ui://99hn3059rvhc1spemfc"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_redPosController = self:getController("redPos")
	self.m_openTimeTxt = self:getChild("openTimeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	结束 = 2,
	开启 = 1,
	未开启 = 0
}
var_0_0.RedPosCtrl = {
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
