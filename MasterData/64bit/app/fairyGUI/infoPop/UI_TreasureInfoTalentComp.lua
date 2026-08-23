local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bns36ugibxp"

function var_0_0:__ctor()
	self.m_isGlyphActiveController = self:getController("isGlyphActive")
	self.m_hasRefineTalentController = self:getController("hasRefineTalent")
	self.m_titleComp = self:getChild("titleComp")
	self.m_refineTalentList = self:getChild("refineTalentList")
	self.m_glyphSuitTitle = self:getChild("glyphSuitTitle")
	self.m_glyphSuitNameTxt = self:getChild("glyphSuitNameTxt")
	self.m_glyphSuitTalentList = self:getChild("glyphSuitTalentList")
end

var_0_0.IsGlyphActiveCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HasRefineTalentCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
