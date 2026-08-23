local var_0_0 = {}

var_0_0.URL = "ui://2r646mayibhq19"

function var_0_0:__ctor()
	self.m_showLineController = self:getController("showLine")
	self.m_showTipController = self:getController("showTip")
end

var_0_0.ShowLineCtrl = {
	是 = 0,
	否 = 1
}
var_0_0.ShowTipCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
