local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qjqk68ja"

function var_0_0:__ctor()
	self.m_bgController = self:getController("bg")
	self.m_textColorController = self:getController("textColor")
	self.m_contentController = self:getController("content")
	self.m_bgAlphaController = self:getController("bgAlpha")
	self.m_bgScaleController = self:getController("bgScale")
	self.m_bg_2 = self:getChild("bg")
	self.m_bg2 = self:getChild("bg2")
	self.m_holder = self:getChild("holder")
end

var_0_0.BgCtrl = {
	page2 = 3,
	page1 = 1,
	page0 = 0,
	page4 = 5,
	page3 = 4
}
var_0_0.TextColorCtrl = {
	page2 = 4,
	page1 = 3,
	page0 = 0
}
var_0_0.ContentCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.BgAlphaCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.BgScaleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
