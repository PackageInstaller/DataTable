local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oto34rrhb"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_tipPosController = self:getController("tipPos")
	self.m_isShowStageController = self:getController("isShowStage")
	self.m_isForbiddenController = self:getController("isForbidden")
	self.m_showTipController = self:getController("showTip")
	self.m_showFuncController = self:getController("showFunc")
	self.m_floopBgComp = self:getChild("floopBgComp")
	self.m_guardBtn = self:getChild("guardBtn")
	self.m_abandonBtn = self:getChild("abandonBtn")
	self.m_rewardBg = self:getChild("rewardBg")
	self.m_proText = self:getChild("proText")
	self.m_probar = self:getChild("probar")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_lockText = self:getChild("lockText")
	self.m_gotoBtn = self:getChild("gotoBtn")
	self.m_gotoGroup = self:getChild("gotoGroup")
	self.m_tipCloseBtn = self:getChild("tipCloseBtn")
	self.m_floorTipBtn = self:getChild("floorTipBtn")
	self.m_tipComp = self:getChild("tipComp")
	self.m_stageComp = self:getChild("stageComp")
	self.m_btnPic = self:getChild("btnPic")
	self.m_suitListComp = self:getChild("suitListComp")
	self.m_floorTxtComp = self:getChild("floorTxtComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_autoNode = self:getChild("autoNode")
	self.m_fundBtn = self:getChild("fundBtn")
	self.m_sweepBtn = self:getChild("sweepBtn")
	self.m_sweepGroup = self:getChild("sweepGroup")
	self.m_fightValueList = self:getChild("fightValueList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsLockCtrl = {
	lock = 1,
	normal = 0
}
var_0_0.TipPosCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowStageCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsForbiddenCtrl = {
	forbid = 1,
	normal = 0
}
var_0_0.ShowTipCtrl = {
	hide = 0,
	show = 1
}
var_0_0.ShowFuncCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
