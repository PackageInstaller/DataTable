local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnp0x6gibxg"

function var_0_0:__ctor()
	self.m_hasResonanceController = self:getController("hasResonance")
	self.m_hasMagicalController = self:getController("hasMagical")
	self.m_basicAttrComp = self:getChild("basicAttrComp")
	self.m_strengthComp = self:getChild("strengthComp")
	self.m_refineComp = self:getChild("refineComp")
	self.m_glyphComp = self:getChild("glyphComp")
	self.m_magicalComp = self:getChild("magicalComp")
	self.m_resonanceComp = self:getChild("resonanceComp")
	self.m_equipDescTxt = self:getChild("equipDescTxt")
	self.m_descGroup = self:getChild("descGroup")
end

var_0_0.HasResonanceCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasMagicalCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
