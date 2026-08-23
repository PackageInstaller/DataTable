local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepmuw9s"

function var_0_0:__ctor()
	self.m_hideStarController = self:getController("hideStar")
	self.m_quality = self:getChild("quality")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_addTxt = self:getChild("addTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_otherQualityIcon = self:getChild("otherQualityIcon")
	self.m_otherElementLoader = self:getChild("otherElementLoader")
end

var_0_0.HideStarCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
