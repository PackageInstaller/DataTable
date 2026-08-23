local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnh"

function var_0_0:__ctor()
	self.m_hasKnightController = self:getController("hasKnight")
	self.m_showHpBarController = self:getController("showHpBar")
	self.m_stateController = self:getController("state")
	self.m_hasSealController = self:getController("hasSeal")
	self.m_hidePlusController = self:getController("hidePlus")
	self.m_moveBg = self:getChild("moveBg")
	self.m_addBtn = self:getChild("addBtn")
	self.m_knightClickNode = self:getChild("knightClickNode")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_keepsakeLoader = self:getChild("keepsakeLoader")
	self.m_leftQualityLoader = self:getChild("leftQualityLoader")
	self.m_starGroupComp = self:getChild("starGroupComp")
	self.m_hpBar = self:getChild("hpBar")
	self.m_levelText = self:getChild("levelText")
	self.m_mask = self:getChild("mask")
	self.m_stateText = self:getChild("stateText")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_leaderLoader = self:getChild("leaderLoader")
end

var_0_0.HasKnightCtrl = {
	none = 0,
	has = 1
}
var_0_0.ShowHpBarCtrl = {
	show = 1,
	hide = 0
}
var_0_0.StateCtrl = {
	isDead = 2,
	isUsed = 1,
	normal = 0
}
var_0_0.HasSealCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HidePlusCtrl = {
	show = 0,
	hide = 1
}

return var_0_0
