local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneppnxg1emigik"

function var_0_0:__ctor()
	self.m_equipTypeController = self:getController("equipType")
	self.m_isActiveController = self:getController("isActive")
	self.m_equipQualityController = self:getController("equipQuality")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_bgLoaderMR = self:getChild("bgLoaderMR")
	self.m_iconLoaderMR = self:getChild("iconLoaderMR")
	self.m_effCircle = self:getChild("effCircle")
	self.m_effDiamond = self:getChild("effDiamond")
	self.m_effActivity = self:getChild("effActivity")
end

var_0_0.EquipTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EquipQualityCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
