local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnvxsogic2t"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_timesController = self:getController("times")
	self.m_isShowEndController = self:getController("isShowEnd")
	self.m_popPanel = self:getChild("popPanel")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_attackerNode = self:getChild("attackerNode")
	self.m_defenderNode = self:getChild("defenderNode")
	self.m_awardList = self:getChild("awardList")
	self.m_endComp = self:getChild("endComp")
	self.m_backBtn = self:getChild("backBtn")
	self.m_content = self:getChild("content")
	self.m_touchComp = self:getChild("touchComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_moveFrontTransition = self:getTransition("moveFront")
	self.m_moveBackTransition = self:getTransition("moveBack")
end

var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.TimesCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.IsShowEndCtrl = {
	normal = 0,
	_end = 1
}

return var_0_0
