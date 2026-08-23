local var_0_0 = {}

var_0_0.URL = "ui://2r646mayuyzo12"

function var_0_0:__ctor()
	self.m_lockStateController = self:getController("lockState")
	self.m_wearStateController = self:getController("wearState")
	self.m_selectStateController = self:getController("selectState")
	self.m_isTimeLimitController = self:getController("isTimeLimit")
	self.m_effHolder = self:getChild("effHolder")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.LockStateCtrl = {
	解锁 = 0,
	未解锁 = 1
}
var_0_0.WearStateCtrl = {
	佩戴中 = 1,
	未佩戴 = 0
}
var_0_0.SelectStateCtrl = {
	选中 = 2,
	未选中 = 1,
	无状态 = 0
}
var_0_0.IsTimeLimitCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
