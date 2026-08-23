local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepmys91emigdf"

function var_0_0:__ctor()
	self.m_isWeddingController = self:getController("isWedding")
	self.m_effectNode = self:getChild("effectNode")
	self.m_weddingKnight = self:getChild("weddingKnight")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsWeddingCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
