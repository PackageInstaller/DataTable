local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88o8g1lrrol"

function var_0_0:__ctor()
	self.m_hasSealController = self:getController("hasSeal")
	self.m_hideKnightController = self:getController("hideKnight")
	self.m_keepsakeComp = self:getChild("keepsakeComp")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasSealCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HideKnightCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
