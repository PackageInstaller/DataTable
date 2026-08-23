local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepf6o1ibkw"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isShowTypeTextController = self:getController("isShowTypeText")
	self.m_levelShowTypeController = self:getController("levelShowType")
	self.m_isShowNameController = self:getController("isShowName")
	self.m_skillTypeController = self:getController("skillType")
	self.m_hideBgController = self:getController("hideBg")
	self.m_showUnitCostController = self:getController("showUnitCost")
	self.m_isShowStarCompController = self:getController("isShowStarComp")
	self.m_decorateFrame = self:getChild("decorateFrame")
	self.m_bgEffectComp = self:getChild("bgEffectComp")
	self.m_combineBg = self:getChild("combineBg")
	self.m_rootBg = self:getChild("rootBg")
	self.m_iconBg = self:getChild("iconBg")
	self.m_iconComp = self:getChild("iconComp")
	self.m_leaderIconComp = self:getChild("leaderIconComp")
	self.m_skillTypeLeftBg = self:getChild("skillTypeLeftBg")
	self.m_skillTypeText = self:getChild("skillTypeText")
	self.m_typeGroup = self:getChild("typeGroup")
	self.m_skillTypeRightBg = self:getChild("skillTypeRightBg")
	self.m_nameText = self:getChild("nameText")
	self.m_levelBg = self:getChild("levelBg")
	self.m_levelText = self:getChild("levelText")
	self.m_levelGroup = self:getChild("levelGroup")
	self.m_imgEmpty = self:getChild("imgEmpty")
	self.m_costText = self:getChild("costText")
	self.m_starComp = self:getChild("starComp")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowTypeTextCtrl = {
	hide = 0,
	show = 1
}
var_0_0.LevelShowTypeCtrl = {
	none = 1,
	normal = 0
}
var_0_0.IsShowNameCtrl = {
	hide = 0,
	show = 1
}
var_0_0.SkillTypeCtrl = {
	passive = 2,
	combine = 1,
	leader = 4,
	succuba = 3,
	normal = 0
}
var_0_0.HideBgCtrl = {
	hide = 1,
	show = 0
}
var_0_0.ShowUnitCostCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsShowStarCompCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
