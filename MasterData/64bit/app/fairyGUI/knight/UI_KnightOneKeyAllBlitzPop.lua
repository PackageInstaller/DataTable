local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivm2b3frg8"

function var_0_0:__ctor()
	self.m_showListController = self:getController("showList")
	self.m_popPanel = self:getChild("popPanel")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_defenderNode = self:getChild("defenderNode")
	self.m_attackerNode = self:getChild("attackerNode")
	self.m_allAwardComp = self:getChild("allAwardComp")
	self.m_targetAwardComp = self:getChild("targetAwardComp")
	self.m_timeTip = self:getChild("timeTip")
	self.m_backBtn = self:getChild("backBtn")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_moveFrontTransition = self:getTransition("moveFront")
end

var_0_0.ShowListCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
