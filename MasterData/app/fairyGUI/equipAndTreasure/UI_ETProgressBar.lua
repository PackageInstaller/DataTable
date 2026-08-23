local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7orxd3n"

function var_0_0:__ctor()
	self.m_previewBarController = self:getController("previewBar")
	self.m_previewBarImg = self:getChild("previewBarImg")
	self.m_effectComp = self:getChild("effectComp")
end

var_0_0.PreviewBarCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
