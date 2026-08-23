local var_0_0 = {}

var_0_0.URL = "ui://foyq921sfu8o27"

function var_0_0:__ctor()
	self.m_isShowRedLineController = self:getController("isShowRedLine")
	self.m_stageProgressController = self:getController("stageProgress")
	self.m_0_1Transition = self:getTransition("0_1")
	self.m_1_2Transition = self:getTransition("1_2")
	self.m_2_3Transition = self:getTransition("2_3")
	self.m_3_4Transition = self:getTransition("3_4")
	self.m_4_5Transition = self:getTransition("4_5")
end

var_0_0.IsShowRedLineCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StageProgressCtrl = {
	page0 = 0,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1
}

return var_0_0
