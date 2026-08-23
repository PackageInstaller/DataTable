local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7orxd3n"

function var_0_0:__ctor()
	self.m_previewBarController = self:getController("previewBar")
	self.m_previewBarImg = self:getChild("previewBarImg")
	self.m_effectComp = self:getChild("effectComp")
end

var_0_0.PreviewBarCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
