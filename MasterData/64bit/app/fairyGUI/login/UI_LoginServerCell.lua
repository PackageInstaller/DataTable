local var_0_0 = {}

var_0_0.URL = "ui://xigti88c8prx3h"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_serverIdTxt = self:getChild("serverIdTxt")
end

var_0_0.TypeCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
