local var_0_0 = {}

var_0_0.URL = "ui://qa3xcguqng9sg2h"

function var_0_0:__ctor()
	self.m_isCanCleanController = self:getController("isCanClean")
	self.m_showTypeController = self:getController("showType")
end

var_0_0.IsCanCleanCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowTypeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
