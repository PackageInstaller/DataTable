local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrvz2y5w"

function var_0_0:__ctor()
	self.m_treasureSpecialAttrController = self:getController("treasureSpecialAttr")
	self.m_isTreasureController = self:getController("isTreasure")
	self.m_baseAttr1 = self:getChild("baseAttr1")
	self.m_baseAttr2 = self:getChild("baseAttr2")
	self.m_base = self:getChild("base")
	self.m_strengthDesc = self:getChild("strengthDesc")
	self.m_strengthAttr1 = self:getChild("strengthAttr1")
	self.m_strengthAttr2 = self:getChild("strengthAttr2")
	self.m_strength = self:getChild("strength")
	self.m_refineDesc = self:getChild("refineDesc")
	self.m_refineAttr1 = self:getChild("refineAttr1")
	self.m_refineAttr2 = self:getChild("refineAttr2")
	self.m_refine = self:getChild("refine")
	self.m_lvDesc = self:getChild("lvDesc")
	self.m_specialAttr1 = self:getChild("specialAttr1")
	self.m_specialAttr2 = self:getChild("specialAttr2")
	self.m_special = self:getChild("special")
	self.m_resonanceDesc = self:getChild("resonanceDesc")
	self.m_resonanceAttrList = self:getChild("resonanceAttrList")
	self.m_resonance = self:getChild("resonance")
	self.m_magicalDesc = self:getChild("magicalDesc")
	self.m_magicalAttrList = self:getChild("magicalAttrList")
	self.m_magical = self:getChild("magical")
	self.m_glyphAttr1 = self:getChild("glyphAttr1")
	self.m_glyphAttr2 = self:getChild("glyphAttr2")
	self.m_gly = self:getChild("gly")
end

var_0_0.TreasureSpecialAttrCtrl = {
	有 = 1,
	没有 = 0
}
var_0_0.IsTreasureCtrl = {
	否 = 0,
	是 = 1
}

return var_0_0
