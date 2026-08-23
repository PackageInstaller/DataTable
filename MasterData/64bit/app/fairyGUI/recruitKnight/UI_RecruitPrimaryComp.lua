local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd1m"

function var_0_0:__ctor()
	self.m_isCompleteController = self:getController("isComplete")
	self.m_completeAllConditionController = self:getController("completeAllCondition")
	self.m_roundPosController = self:getController("roundPos")
	self.m_knightComp1 = self:getChild("knightComp1")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_tipBtn = self:getChild("tipBtn")
	self.m_tipEffectNode = self:getChild("tipEffectNode")
	self.m_proCurText = self:getChild("proCurText")
	self.m_proNextText = self:getChild("proNextText")
	self.m_typeText = self:getChild("typeText")
	self.m_chaperText = self:getChild("chaperText")
	self.m_recruitBtn = self:getChild("recruitBtn")
	self.m_effBtn = self:getChild("effBtn")
	self.m_leftTimeText = self:getChild("leftTimeText")
	self.m_timesGroup = self:getChild("timesGroup")
	self.m_viewBtn = self:getChild("viewBtn")
	self.m_roundLoader = self:getChild("roundLoader")
	self.m_roundText = self:getChild("roundText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switch_2Transition = self:getTransition("switch_2")
	self.m_switch_1Transition = self:getTransition("switch_1")
end

var_0_0.IsCompleteCtrl = {
	lock = 0,
	completeAll = 3,
	completeOne = 1,
	unableReward = 4,
	normal = 2
}
var_0_0.CompleteAllConditionCtrl = {
	complete = 1,
	normal = 0
}
var_0_0.RoundPosCtrl = {
	down = 1,
	normal = 0
}

return var_0_0
