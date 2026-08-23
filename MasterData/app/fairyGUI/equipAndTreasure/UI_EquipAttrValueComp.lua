local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7dsi27j"

function var_0_0:__ctor()
	self.m_widthController = self:getController("width")
	self.m_attrBg = self:getChild("attrBg")
	self.m_attrValueComp = self:getChild("attrValueComp")
end

var_0_0.WidthCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
