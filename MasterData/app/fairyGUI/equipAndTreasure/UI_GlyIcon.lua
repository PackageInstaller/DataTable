local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7qdh73t"

function var_0_0:__ctor()
	self.m_maskController = self:getController("mask")
	self.m_imageIcon = self:getChild("imageIcon")
end

var_0_0.MaskCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
