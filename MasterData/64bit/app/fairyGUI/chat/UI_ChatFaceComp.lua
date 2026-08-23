local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn8781thby2wt"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_tabList = self:getChild("tabList")
	self.m_faceList = self:getChild("faceList")
end

var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
