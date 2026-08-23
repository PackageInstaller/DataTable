local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8ds3t0lgicka"

function var_0_0:__ctor()
	self.m_hideKnightController = self:getController("hideKnight")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_qualityTextLoader = self:getChild("qualityTextLoader")
	self.m_knightBtnGroup = self:getChild("knightBtnGroup")
end

var_0_0.HideKnightCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
