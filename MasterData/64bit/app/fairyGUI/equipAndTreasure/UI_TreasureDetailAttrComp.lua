local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjs1h"

function var_0_0:__ctor()
	self.m_refineEmptyController = self:getController("refineEmpty")
	self.m_glyphEmptyController = self:getController("glyphEmpty")
	self.m_showRefineController = self:getController("showRefine")
	self.m_showGlyphController = self:getController("showGlyph")
	self.m_refineScoreController = self:getController("refineScore")
	self.m_strengthTitleComp = self:getChild("strengthTitleComp")
	self.m_strengthComp = self:getChild("strengthComp")
	self.m_scoreBg = self:getChild("scoreBg")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_scoreGroup = self:getChild("scoreGroup")
	self.m_refineTitleComp = self:getChild("refineTitleComp")
	self.m_refineComp = self:getChild("refineComp")
	self.m_refineEmptyComp = self:getChild("refineEmptyComp")
	self.m_refineTouch = self:getChild("refineTouch")
	self.m_refineGroup = self:getChild("refineGroup")
	self.m_glyphTitleComp = self:getChild("glyphTitleComp")
	self.m_glyphComp = self:getChild("glyphComp")
	self.m_glyphEmptyComp = self:getChild("glyphEmptyComp")
	self.m_glyphTouch = self:getChild("glyphTouch")
	self.m_glyphGroup = self:getChild("glyphGroup")
	self.m_purifyTitleComp = self:getChild("purifyTitleComp")
	self.m_scoreBg2 = self:getChild("scoreBg2")
	self.m_scoreTxt2 = self:getChild("scoreTxt2")
	self.m_scoreGroup2 = self:getChild("scoreGroup2")
	self.m_purifyComp = self:getChild("purifyComp")
	self.m_purifyGroup = self:getChild("purifyGroup")
end

var_0_0.RefineEmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.GlyphEmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowRefineCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowGlyphCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.RefineScoreCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
