local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9kpj468gd"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_forwardController = self:getController("forward")
	self.m_floatTransition = self:getTransition("float")
end

var_0_0.TypeCtrl = {
	all = 2,
	title = 1,
	icon = 0
}
var_0_0.ForwardCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
