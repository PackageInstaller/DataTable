local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepkrgi1emigij"

function var_0_0:__ctor()
	self.m_equipTypeController = self:getController("equipType")
	self.m_equipQualityController = self:getController("equipQuality")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_bgLoaderMR = self:getChild("bgLoaderMR")
	self.m_stage1 = self:getChild("stage1")
	self.m_stage4 = self:getChild("stage4")
	self.m_stage5 = self:getChild("stage5")
	self.m_stage3 = self:getChild("stage3")
	self.m_stage2 = self:getChild("stage2")
end

var_0_0.EquipTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EquipQualityCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
