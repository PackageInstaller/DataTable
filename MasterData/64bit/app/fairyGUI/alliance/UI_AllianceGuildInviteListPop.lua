local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lctba7t"

function var_0_0:__ctor()
	self.m_sortTypeController = self:getController("sortType")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_sortTouch = self:getChild("sortTouch")
	self.m_showList = self:getChild("showList")
	self.m_content = self:getChild("content")
end

var_0_0.SortTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
