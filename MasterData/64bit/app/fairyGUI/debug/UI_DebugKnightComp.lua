local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ypcau3s"

function var_0_0:__ctor()
	self.m_bgShowController = self:getController("bgShow")
	self.m_readCfgController = self:getController("readCfg")
	self.m_areaSquare = self:getChild("areaSquare")
	self.m_knightHolderComp = self:getChild("knightHolderComp")
	self.m_succubaHolderComp = self:getChild("succubaHolderComp")
	self.m_headSquare = self:getChild("headSquare")
	self.m_center = self:getChild("center")
	self.m_knightGroup = self:getChild("knightGroup")
	self.m_searchInfoComp = self:getChild("searchInfoComp")
	self.m_searchPicComp = self:getChild("searchPicComp")
	self.m_searchSuccubaComp = self:getChild("searchSuccubaComp")
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
	self.m_alphaXSlider = self:getChild("alphaXSlider")
	self.m_alphaYSlider = self:getChild("alphaYSlider")
	self.m_alphaWSlider = self:getChild("alphaWSlider")
	self.m_alphaHSlider = self:getChild("alphaHSlider")
	self.m_alphaRectTxt = self:getChild("alphaRectTxt")
	self.m_alphaDisSlider = self:getChild("alphaDisSlider")
	self.m_alphaDistanceTxt = self:getChild("alphaDistanceTxt")
	self.m_reverseCheckBtn = self:getChild("reverseCheckBtn")
	self.m_shaderGroup = self:getChild("shaderGroup")
	self.m_bgCheckBtn = self:getChild("bgCheckBtn")
	self.m_cfgCheckBtn = self:getChild("cfgCheckBtn")
	self.m_tipsText = self:getChild("tipsText")
	self.m_cfgPosText = self:getChild("cfgPosText")
end

var_0_0.BgShowCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ReadCfgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
