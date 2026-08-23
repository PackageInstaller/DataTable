local var_0_0 = {}

var_0_0.URL = "ui://hidrio60ml7xd"

function var_0_0:__ctor()
	self.m_hasRouteController = self:getController("hasRoute")
	self.m_showNumController = self:getController("showNum")
	self.m_showTimeController = self:getController("showTime")
	self.m_timeIconTypeController = self:getController("timeIconType")
	self.m_hasBoxRouteController = self:getController("hasBoxRoute")
	self.m_popPanel = self:getChild("popPanel")
	self.m_limitedTimeTxt = self:getChild("limitedTimeTxt")
	self.m_baseItem = self:getChild("baseItem")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_descComp = self:getChild("descComp")
	self.m_numTxt = self:getChild("numTxt")
	self.m_routesList = self:getChild("routesList")
	self.m_boxList = self:getChild("boxList")
	self.m_openBtn = self:getChild("openBtn")
	self.m_content = self:getChild("content")
end

var_0_0.HasRouteCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowTimeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TimeIconTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasBoxRouteCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
