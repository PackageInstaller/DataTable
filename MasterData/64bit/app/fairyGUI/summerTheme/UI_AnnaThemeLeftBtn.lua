local var_0_0 = {}

var_0_0.URL = "ui://99hn3059pkuemw2y1a"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_redPosController = self:getController("redPos")
	self.m_openTimeTxt = self:getChild("openTimeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	未开启 = 0,
	结束 = 2,
	开启 = 1
}
var_0_0.RedPosCtrl = {
	page0 = 0,
	page2 = 5,
	page1 = 1
}

return var_0_0
