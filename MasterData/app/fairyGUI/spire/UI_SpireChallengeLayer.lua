local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm2w"

function var_0_0:__ctor()
	self.m_isBossController = self:getController("isBoss")
	self.m_isPassAllController = self:getController("isPassAll")
	self.m_isUnlockAutoController = self:getController("isUnlockAuto")
	self.m_bgLoader1 = self:getChild("bgLoader1")
	self.m_bgLoader2 = self:getChild("bgLoader2")
	self.m_bgBossLoader = self:getChild("bgBossLoader")
	self.m_mapComp1 = self:getChild("mapComp1")
	self.m_mapComp2 = self:getChild("mapComp2")
	self.m_roleSpineNode = self:getChild("roleSpineNode")
	self.m_floorTxt = self:getChild("floorTxt")
	self.m_normalUIComp = self:getChild("normalUIComp")
	self.m_bossUIComp = self:getChild("bossUIComp")
	self.m_deepComp = self:getChild("deepComp")
	self.m_touchMapNode = self:getChild("touchMapNode")
	self.m_touchMonsterNode = self:getChild("touchMonsterNode")
	self.m_lineUpComp = self:getChild("lineUpComp")
	self.m_normalBtn = self:getChild("normalBtn")
	self.m_bossBtn = self:getChild("bossBtn")
	self.m_autoBtn = self:getChild("autoBtn")
	self.m_normal1Btn = self:getChild("normal1Btn")
	self.m_btnEffNode = self:getChild("btnEffNode")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_maskComp = self:getChild("maskComp")
	self.m_transformComp = self:getChild("transformComp")
	self.m_moveMap1Transition = self:getTransition("moveMap1")
	self.m_moveMap2Transition = self:getTransition("moveMap2")
	self.m_roleMoveOutTransition = self:getTransition("roleMoveOut")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_enterBossTransition = self:getTransition("enterBoss")
	self.m_roleMoveInTransition = self:getTransition("roleMoveIn")
	self.m_standByTransition = self:getTransition("standBy")
end

var_0_0.IsBossCtrl = {
	boss = 1,
	normal = 0
}
var_0_0.IsPassAllCtrl = {
	passAll = 1,
	normal = 0
}
var_0_0.IsUnlockAutoCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
