local var_0_0 = {}

var_0_0.URL = "ui://99hn3059xfygmw2xda"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_redPosController = self:getController("redPos")
	self.m_isPassCardController = self:getController("isPassCard")
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
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1
}
var_0_0.IsPassCardCtrl = {
	passCard = 1,
	normal = 0
}

return var_0_0
