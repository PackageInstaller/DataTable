local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnhmqwgic2z"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isShowEndController = self:getController("isShowEnd")
	self.m_timesController = self:getController("times")
	self.m_popPanel = self:getChild("popPanel")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_awardList = self:getChild("awardList")
	self.m_endComp = self:getChild("endComp")
	self.m_backBtn = self:getChild("backBtn")
	self.m_attackerNode = self:getChild("attackerNode")
	self.m_defenderNode = self:getChild("defenderNode")
	self.m_content = self:getChild("content")
	self.m_touchComp = self:getChild("touchComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_moveFrontTransition = self:getTransition("moveFront")
	self.m_moveBackTransition = self:getTransition("moveBack")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsShowEndCtrl = {
	_end = 1,
	normal = 0
}
var_0_0.TimesCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
