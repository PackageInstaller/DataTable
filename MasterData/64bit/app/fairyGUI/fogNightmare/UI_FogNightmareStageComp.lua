local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88olf8arrpi"

function var_0_0:__ctor()
	self.m_wavePosStateController = self:getController("wavePosState")
	self.m_showCancelController = self:getController("showCancel")
	self.m_hasLoadController = self:getController("hasLoad")
	self.m_buffTipController = self:getController("buffTip")
	self.m_spKnightIconController = self:getController("spKnightIcon")
	self.m_isFrontStyleController = self:getController("isFrontStyle")
	self.m_isHideFirstAwardController = self:getController("isHideFirstAward")
	self.m_touchBg = self:getChild("touchBg")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_spIconLoader = self:getChild("spIconLoader")
	self.m_spineNode = self:getChild("spineNode")
	self.m_effectBg = self:getChild("effectBg")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_effectNode = self:getChild("effectNode")
	self.m_buffList = self:getChild("buffList")
	self.m_floorText = self:getChild("floorText")
	self.m_buffTipText = self:getChild("buffTipText")
	self.m_childCompRoot = self:getChild("childCompRoot")
	self.m_waveList = self:getChild("waveList")
	self.m_firstAwardsList = self:getChild("firstAwardsList")
	self.m_firstAward = self:getChild("firstAward")
	self.m_suitListComp = self:getChild("suitListComp")
	self.m_btnLine = self:getChild("btnLine")
	self.m_btnLoad = self:getChild("btnLoad")
	self.m_btnStage = self:getChild("btnStage")
	self.m_autoBtn = self:getChild("autoBtn")
	self.m_skipFormation = self:getChild("skipFormation")
	self.m_btnCancel = self:getChild("btnCancel")
	self.m_btnPic = self:getChild("btnPic")
	self.m_rewardBg = self:getChild("rewardBg")
	self.m_proText = self:getChild("proText")
	self.m_probar = self:getChild("probar")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_bgEffectNode = self:getChild("bgEffectNode")
	self.m_frontText = self:getChild("frontText")
	self.m_frontClickNode = self:getChild("frontClickNode")
	self.m_buffClickNode = self:getChild("buffClickNode")
	self.m_autoNode = self:getChild("autoNode")
	self.m_skipChallenge = self:getChild("skipChallenge")
	self.m_enterTransition = self:getTransition("enter")
	self.m_frontShowTransition = self:getTransition("frontShow")
	self.m_enter2Transition = self:getTransition("enter2")
	self.m_fadeTransition = self:getTransition("fade")
end

var_0_0.WavePosStateCtrl = {
	down = 0,
	showUnite = 2,
	normal = 1
}
var_0_0.ShowCancelCtrl = {
	hide = 0,
	show = 1
}
var_0_0.HasLoadCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.BuffTipCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.SpKnightIconCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsFrontStyleCtrl = {
	front = 1,
	normal = 0
}
var_0_0.IsHideFirstAwardCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
