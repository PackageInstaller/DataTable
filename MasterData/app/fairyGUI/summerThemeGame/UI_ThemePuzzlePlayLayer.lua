local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6osmakk3nl"

function var_0_0:__ctor()
	self.m_pauseController = self:getController("pause")
	self.m_stageController = self:getController("stage")
	self.m_show_partitionController = self:getController("show_partition")
	self.m_bgComp = self:getChild("bgComp")
	self.m_countdownComp = self:getChild("countdownComp")
	self.m_progressComp = self:getChild("progressComp")
	self.m_showPicComp = self:getChild("showPicComp")
	self.m_partitionHolderComp = self:getChild("partitionHolderComp")
	self.m_effectComp = self:getChild("effectComp")
	self.m_aniDistComp = self:getChild("aniDistComp")
	self.m_pieceComp = self:getChild("pieceComp")
	self.m_pauseBtn = self:getChild("pauseBtn")
	self.m_pauseComp = self:getChild("pauseComp")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_completeTransition = self:getTransition("complete")
end

var_0_0.PauseCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StageCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Show_partitionCtrl = {
	page0 = 0,
	page1 = 3
}

return var_0_0
