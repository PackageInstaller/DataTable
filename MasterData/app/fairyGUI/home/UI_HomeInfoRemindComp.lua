local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgft555ibiz"

function var_0_0:__ctor()
	self.m_showOneKeyController = self:getController("showOneKey")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_chooseBarComp = self:getChild("chooseBarComp")
	self.m_tabComp = self:getChild("tabComp")
	self.m_infoList = self:getChild("infoList")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_setBtn = self:getChild("setBtn")
	self.m_runBanner = self:getChild("runBanner")
end

var_0_0.ShowOneKeyCtrl = {
	不显示 = 0,
	显示 = 1
}
var_0_0.IsEmptyCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
