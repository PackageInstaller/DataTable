local var_0_0 = {}

var_0_0.URL = "ui://2r646mayibhq19"

function var_0_0:__ctor()
	self.m_showLineController = self:getController("showLine")
	self.m_showTipController = self:getController("showTip")
end

var_0_0.ShowLineCtrl = {
	否 = 1,
	是 = 0
}
var_0_0.ShowTipCtrl = {
	否 = 0,
	是 = 1
}

return var_0_0
