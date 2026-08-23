local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25kosg9t"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isShowPointController = self:getController("isShowPoint")
end

var_0_0.StateCtrl = {
	pass = 1,
	cur = 2,
	lock = 3,
	none = 0
}
var_0_0.IsShowPointCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
