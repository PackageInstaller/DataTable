local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yblcq5ibj2"

function var_0_0:__ctor()
	self.m_areaSquare = self:getChild("areaSquare")
	self.m_knightHolderComp = self:getChild("knightHolderComp")
	self.m_headSquare = self:getChild("headSquare")
	self.m_center = self:getChild("center")
	self.m_knightGroup = self:getChild("knightGroup")
	self.m_searchInfoComp = self:getChild("searchInfoComp")
	self.m_selGroup = self:getChild("selGroup")
	self.m_touchPos = self:getChild("touchPos")
	self.m_posText = self:getChild("posText")
	self.m_scaleSlider = self:getChild("scaleSlider")
	self.m_scaleText = self:getChild("scaleText")
	self.m_scaleAddBtn = self:getChild("scaleAddBtn")
	self.m_scaleMinBtn = self:getChild("scaleMinBtn")
	self.m_xMinBtn = self:getChild("xMinBtn")
	self.m_xAddBtn = self:getChild("xAddBtn")
	self.m_yAddBtn = self:getChild("yAddBtn")
	self.m_yMinBtn = self:getChild("yMinBtn")
	self.m_posGroup = self:getChild("posGroup")
	self.m_tipsText = self:getChild("tipsText")
	self.m_cfgPosText = self:getChild("cfgPosText")
end

return var_0_0
