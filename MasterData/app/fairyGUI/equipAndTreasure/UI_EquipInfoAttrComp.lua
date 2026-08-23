local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7dsi27f"

function var_0_0:__ctor()
	self.m_showGlyphController = self:getController("showGlyph")
	self.m_showResonanceController = self:getController("showResonance")
	self.m_showMagicalController = self:getController("showMagical")
	self.m_suitTitleComp = self:getChild("suitTitleComp")
	self.m_suitMagicalTalentComp = self:getChild("suitMagicalTalentComp")
	self.m_suitSkillComp = self:getChild("suitSkillComp")
	self.m_strengthComp = self:getChild("strengthComp")
	self.m_magicalSingleComp = self:getChild("magicalSingleComp")
	self.m_refineComp = self:getChild("refineComp")
	self.m_resonanceComp = self:getChild("resonanceComp")
	self.m_glyphComp = self:getChild("glyphComp")
	self.m_arrangeGroup = self:getChild("arrangeGroup")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowGlyphCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowResonanceCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowMagicalCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
