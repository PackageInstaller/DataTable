local var_0_0 = {}

var_0_0.URL = "ui://qa3xcguqng9sg2h"

function var_0_0:__ctor()
	self.m_isCanCleanController = self:getController("isCanClean")
	self.m_showTypeController = self:getController("showType")
end

var_0_0.IsCanCleanCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
