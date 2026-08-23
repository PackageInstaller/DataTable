local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1nc3mi"

function var_0_0:__ctor()
	self.m_hideTxtController = self:getController("hideTxt")
	self.m_isFragController = self:getController("isFrag")
	self.m_hideSetController = self:getController("hideSet")
	self.m_previewBarController = self:getController("previewBar")
	self.m_previewBarImg = self:getChild("previewBarImg")
	self.m_effectComp = self:getChild("effectComp")
end

return var_0_0
