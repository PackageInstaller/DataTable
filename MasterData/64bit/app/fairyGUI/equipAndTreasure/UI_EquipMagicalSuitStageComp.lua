local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7nyyld8"

function var_0_0:__ctor()
	self.m_suitTypeController = self:getController("suitType")
	self.m_showInfoController = self:getController("showInfo")
	self.m_isGrayController = self:getController("isGray")
	self.m_suitQualityController = self:getController("suitQuality")
	self.m_title = self:getChild("title")
	self.m_icon = self:getChild("icon")
	self.m_iconMR = self:getChild("iconMR")
	self.m_progTxt = self:getChild("progTxt")
end

var_0_0.SuitTypeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowInfoCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsGrayCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.SuitQualityCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
