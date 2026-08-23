local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepkb6qibn8"

function var_0_0:__ctor()
	self.m_isShowNumController = self:getController("isShowNum")
	self.m_isShowRefineController = self:getController("isShowRefine")
	self.m_isShowInfoController = self:getController("isShowInfo")
	self.m_showLevelController = self:getController("showLevel")
	self.m_nameTypeController = self:getController("nameType")
	self.m_scaleIndexController = self:getController("scaleIndex")
	self.m_hideSkinController = self:getController("hideSkin")
	self.m_iconHoldComp = self:getChild("iconHoldComp")
	self.m_BaseIconTagComp = self:getChild("BaseIconTagComp")
end

var_0_0.IsShowNumCtrl = {
	show = 1,
	none = 0,
	hide = 2
}
var_0_0.IsShowRefineCtrl = {
	show = 2,
	none = 0,
	hide = 1
}
var_0_0.IsShowInfoCtrl = {
	show = 2,
	none = 0,
	hide = 1
}
var_0_0.ShowLevelCtrl = {
	show = 2,
	none = 0,
	hide = 1
}
var_0_0.NameTypeCtrl = {
	twoRow = 3,
	none = 0,
	oneRow = 2,
	hide = 1
}
var_0_0.ScaleIndexCtrl = {
	["70"] = 3,
	["80"] = 2,
	["90"] = 1,
	["100"] = 0,
	["30"] = 7,
	["40"] = 6,
	["50"] = 5,
	["60"] = 4
}
var_0_0.HideSkinCtrl = {
	none = 0,
	normal = 1,
	hide = 2
}

return var_0_0
