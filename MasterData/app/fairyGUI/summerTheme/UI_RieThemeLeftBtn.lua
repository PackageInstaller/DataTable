local var_0_0 = {}

var_0_0.URL = "ui://99hn3059w3339bnom5"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_redPosController = self:getController("redPos")
	self.m_zs_color = self:getChild("zs_color")
	self.m_openTimeTxt = self:getChild("openTimeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	结束 = 2,
	未开启 = 0,
	开启 = 1
}
var_0_0.RedPosCtrl = {
	page0 = 0,
	page2 = 6,
	page1 = 1
}

return var_0_0
