local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ynth05ibhv"

function var_0_0:__ctor()
	self.m_isHideInfoController = self:getController("isHideInfo")
	self.m_isOtherController = self:getController("isOther")
	self.m_leftCfgTypeController = self:getController("leftCfgType")
	self.m_rightCfgTypeController = self:getController("rightCfgType")
	self.m_battleLayerComp = self:getChild("battleLayerComp")
	self.m_enterBtn = self:getChild("enterBtn")
	self.m_leftEasyBtn = self:getChild("leftEasyBtn")
	self.m_leftCfgBtn = self:getChild("leftCfgBtn")
	self.m_rightEasyBtn = self:getChild("rightEasyBtn")
	self.m_rightCfgBtn = self:getChild("rightCfgBtn")
	self.m_pathBtn = self:getChild("pathBtn")
	self.m_exportBtn = self:getChild("exportBtn")
	self.m_rightList = self:getChild("rightList")
	self.m_leftList = self:getChild("leftList")
	self.m_switchBtn = self:getChild("switchBtn")
	self.m_guideBattleBtn1 = self:getChild("guideBattleBtn1")
	self.m_guideBattleBtn2 = self:getChild("guideBattleBtn2")
	self.m_startEnergyInput = self:getChild("startEnergyInput")
	self.m_startComboInput = self:getChild("startComboInput")
end

var_0_0.IsHideInfoCtrl = {
	show = 0,
	hide = 1
}
var_0_0.IsOtherCtrl = {
	other = 1,
	project = 0
}
var_0_0.LeftCfgTypeCtrl = {
	monster_team = 1,
	knight = 0
}
var_0_0.RightCfgTypeCtrl = {
	monster_team = 1,
	knight = 0
}

return var_0_0
