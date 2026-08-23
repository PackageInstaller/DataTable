local var_0_0 = {}

var_0_0.URL = "ui://hidrio60v7z05"

function var_0_0:__ctor()
	self.m_hasRouteController = self:getController("hasRoute")
	self.m_showNumController = self:getController("showNum")
	self.m_showTimeController = self:getController("showTime")
	self.m_timeIconTypeController = self:getController("timeIconType")
	self.m_touchBg = self:getChild("touchBg")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_limitedTimeTxt = self:getChild("limitedTimeTxt")
	self.m_baseItem = self:getChild("baseItem")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_descComp = self:getChild("descComp")
	self.m_numTxt = self:getChild("numTxt")
	self.m_routesList = self:getChild("routesList")
	self.m_content = self:getChild("content")
	self.m_AllGroup = self:getChild("AllGroup")
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

return var_0_0
