local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7y9b3p5ibk7"

function var_0_0:__ctor()
	self.m_cutComp = self:getChild("cutComp")
	self.m_halfOpacityComp = self:getChild("halfOpacityComp")
	self.m_center = self:getChild("center")
	self.m_touchGraph = self:getChild("touchGraph")
	self.m_knightGroup = self:getChild("knightGroup")
	self.m_searchInfoComp = self:getChild("searchInfoComp")
	self.m_selGroup = self:getChild("selGroup")
	self.m_tipsText = self:getChild("tipsText")
	self.m_cfgPosText = self:getChild("cfgPosText")
	self.m_hideMaskBtn = self:getChild("hideMaskBtn")
	self.m_clickPos = self:getChild("clickPos")
	self.m_inputValue = self:getChild("inputValue")
	self.m_scaleSlider = self:getChild("scaleSlider")
end

return var_0_0
