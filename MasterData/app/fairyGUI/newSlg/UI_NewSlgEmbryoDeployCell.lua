local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9b6x468r9"

function var_0_0:__ctor()
	self.m_embryoTypeController = self:getController("embryoType")
	self.m_statusController = self:getController("status")
	self.m_embryoQualityBg = self:getChild("embryoQualityBg")
	self.m_embryoIcon = self:getChild("embryoIcon")
	self.m_embryoName = self:getChild("embryoName")
	self.m_authorityNum = self:getChild("authorityNum")
	self.m_starQualityBg = self:getChild("starQualityBg")
	self.m_starComp = self:getChild("starComp")
	self.m_addBtn = self:getChild("addBtn")
	self.m_mainCityName = self:getChild("mainCityName")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_tipTxt1 = self:getChild("tipTxt1")
	self.m_eff = self:getChild("eff")
end

var_0_0.EmbryoTypeCtrl = {
	page2 = 3,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 2
}
var_0_0.StatusCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
