local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepe2o91emigdh"

function var_0_0:__ctor()
	self.m_showLevelController = self:getController("showLevel")
	self.m_isWeddingController = self:getController("isWedding")
	self.m_weddingLoader = self:getChild("weddingLoader")
	self.m_effectNode = self:getChild("effectNode")
	self.m_weddingLevelText = self:getChild("weddingLevelText")
end

var_0_0.ShowLevelCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsWeddingCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
