local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bns36ugibxi"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_basicAttrComp = self:getChild("basicAttrComp")
	self.m_strengthComp = self:getChild("strengthComp")
	self.m_specialAttrComp = self:getChild("specialAttrComp")
	self.m_glyphComp = self:getChild("glyphComp")
	self.m_equipDescTxt = self:getChild("equipDescTxt")
	self.m_descGroup = self:getChild("descGroup")
	self.m_expDescTxt = self:getChild("expDescTxt")
	self.m_expDescGroup = self:getChild("expDescGroup")
end

var_0_0.StyleCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
