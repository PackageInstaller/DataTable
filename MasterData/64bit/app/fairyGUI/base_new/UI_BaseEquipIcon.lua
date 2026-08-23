local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepkb6qibn7"

function var_0_0:__ctor()
	self.m_showLevelController = self:getController("showLevel")
	self.m_isShowRefineController = self:getController("isShowRefine")
	self.m_isGlyphController = self:getController("isGlyph")
	self.m_isShowNumController = self:getController("isShowNum")
	self.m_isEnoughController = self:getController("isEnough")
	self.m_isDiamondController = self:getController("isDiamond")
	self.m_nameTypeController = self:getController("nameType")
	self.m_isLockController = self:getController("isLock")
	self.m_showResonanceController = self:getController("showResonance")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_effectBg = self:getChild("effectBg")
	self.m_effectIconDown = self:getChild("effectIconDown")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_magicalHolder = self:getChild("magicalHolder")
	self.m_effectIcon = self:getChild("effectIcon")
	self.m_levelBg = self:getChild("levelBg")
	self.m_glyphQualityComp = self:getChild("glyphQualityComp")
	self.m_resonanceLevelComp = self:getChild("resonanceLevelComp")
	self.m_refineBg = self:getChild("refineBg")
	self.m_levelText = self:getChild("levelText")
	self.m_refineText = self:getChild("refineText")
	self.m_numText = self:getChild("numText")
	self.m_grayGraph = self:getChild("grayGraph")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_contentGroup = self:getChild("contentGroup")
	self.m_effectNode = self:getChild("effectNode")
	self.m_itemSpecialUseLoader = self:getChild("itemSpecialUseLoader")
end

var_0_0.ShowLevelCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsShowRefineCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsGlyphCtrl = {
	normal = 0,
	glyph = 1
}
var_0_0.IsShowNumCtrl = {
	hide = 1,
	show = 0
}
var_0_0.IsEnoughCtrl = {
	shortage = 0,
	enough = 1
}
var_0_0.IsDiamondCtrl = {
	normal = 0,
	diamond = 1
}
var_0_0.NameTypeCtrl = {
	twoRow = 2,
	oneRow = 1,
	hide = 0
}
var_0_0.IsLockCtrl = {
	否 = 0,
	是 = 1
}
var_0_0.ShowResonanceCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
