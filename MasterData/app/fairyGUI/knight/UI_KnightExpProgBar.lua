local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivdps8ju"

function var_0_0:__ctor()
	self.m_hideTxtController = self:getController("hideTxt")
	self.m_isFragController = self:getController("isFrag")
	self.m_hideSetController = self:getController("hideSet")
	self.m_previewBarController = self:getController("previewBar")
	self.m_previewBarImg = self:getChild("previewBarImg")
	self.m_effectComp = self:getChild("effectComp")
end

var_0_0.HideTxtCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsFragCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HideSetCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.PreviewBarCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
