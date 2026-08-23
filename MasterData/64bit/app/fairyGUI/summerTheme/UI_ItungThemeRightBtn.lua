local var_0_0 = {}

var_0_0.URL = "ui://99hn3059s2znmw2xl3"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_redPosController = self:getController("redPos")
	self.m_openTimeTxt = self:getChild("openTimeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	开启 = 1,
	未开启 = 0,
	结束 = 2
}
var_0_0.RedPosCtrl = {
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
