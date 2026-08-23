local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivnmalg6"

function var_0_0:__ctor()
	self.m_qualityFontSizeController = self:getController("qualityFontSize")
	self.m_qulityBg = self:getChild("qulityBg")
	self.m_qulityImage = self:getChild("qulityImage")
	self.m_qualityTxt = self:getChild("qualityTxt")
end

var_0_0.QualityFontSizeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
