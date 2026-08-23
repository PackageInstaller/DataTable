local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7hps06j"

function var_0_0:__ctor()
	self.m_showLevelController = self:getController("showLevel")
	self.m_isShowRefineController = self:getController("isShowRefine")
	self.m_isGlyphController = self:getController("isGlyph")
	self.m_isShowNumController = self:getController("isShowNum")
	self.m_isWearController = self:getController("isWear")
	self.m_showResonanceController = self:getController("showResonance")
	self.m_effectBg = self:getChild("effectBg")
	self.m_effectIconDown = self:getChild("effectIconDown")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_magicalHolder = self:getChild("magicalHolder")
	self.m_effectIcon = self:getChild("effectIcon")
	self.m_levelText = self:getChild("levelText")
	self.m_levelBg = self:getChild("levelBg")
	self.m_refineText = self:getChild("refineText")
	self.m_refineBg = self:getChild("refineBg")
	self.m_numText = self:getChild("numText")
	self.m_glyphQualityComp = self:getChild("glyphQualityComp")
	self.m_resonanceLevelComp = self:getChild("resonanceLevelComp")
	self.m_qualitySelectBgLeft = self:getChild("qualitySelectBgLeft")
	self.m_qualitySelectBgRight = self:getChild("qualitySelectBgRight")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.ShowLevelCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowRefineCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsGlyphCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsWearCtrl = {
	未穿戴 = 0,
	已穿戴 = 1
}
var_0_0.ShowResonanceCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
