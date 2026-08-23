local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrclc05q"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_qualityLoader = self:getChild("qualityLoader")
end

var_0_0.QualityCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
