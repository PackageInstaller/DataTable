local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yx6v05ibjd"

function var_0_0:__ctor()
	self.m_modeController = self:getController("mode")
	self.m_bg = self:getChild("bg")
	self.m_searchBgComp = self:getChild("searchBgComp")
	self.m_searchInfoComp = self:getChild("searchInfoComp")
	self.m_searchPicComp = self:getChild("searchPicComp")
	self.m_searchSuccubaComp = self:getChild("searchSuccubaComp")
	self.m_selGroup = self:getChild("selGroup")
	self.m_touchBg = self:getChild("touchBg")
	self.m_knightHolderComp = self:getChild("knightHolderComp")
	self.m_succubaHolderComp = self:getChild("succubaHolderComp")
	self.m_touchHolderComp = self:getChild("touchHolderComp")
	self.m_scaleSlider = self:getChild("scaleSlider")
	self.m_scaleText = self:getChild("scaleText")
	self.m_scaleAddBtn = self:getChild("scaleAddBtn")
	self.m_scaleMinBtn = self:getChild("scaleMinBtn")
	self.m_checkbox = self:getChild("checkbox")
	self.m_spineX = self:getChild("spineX")
	self.m_spineY = self:getChild("spineY")
	self.m_spineScale = self:getChild("spineScale")
	self.m_spineGroup = self:getChild("spineGroup")
	self.m_itemX = self:getChild("itemX")
	self.m_itemY = self:getChild("itemY")
	self.m_radius = self:getChild("radius")
	self.m_addItemBtn = self:getChild("addItemBtn")
	self.m_itemGroup = self:getChild("itemGroup")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_checkReadCfg = self:getChild("checkReadCfg")
end

var_0_0.ModeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
