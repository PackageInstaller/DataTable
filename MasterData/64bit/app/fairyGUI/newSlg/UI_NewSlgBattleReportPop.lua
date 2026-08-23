local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9lh7n8c4"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_showViewController = self:getController("showView")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_tab0 = self:getChild("tab0")
	self.m_tab1 = self:getChild("tab1")
	self.m_reportList = self:getChild("reportList")
	self.m_arrowBtn = self:getChild("arrowBtn")
	self.m_chooseCompHideTouch = self:getChild("chooseCompHideTouch")
	self.m_chooseComp = self:getChild("chooseComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.EmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowViewCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
