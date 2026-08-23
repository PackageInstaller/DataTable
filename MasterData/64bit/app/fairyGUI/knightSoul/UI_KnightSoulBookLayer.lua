local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulamy94"

function var_0_0:__ctor()
	self.m_isMaxStarController = self:getController("isMaxStar")
	self.m_hasStarController = self:getController("hasStar")
	self.m_isShowQuickSelController = self:getController("isShowQuickSel")
	self.m_detailComp = self:getChild("detailComp")
	self.m_bookComp = self:getChild("bookComp")
	self.m_cardListComp = self:getChild("cardListComp")
	self.m_honorBg = self:getChild("honorBg")
	self.m_honorText = self:getChild("honorText")
	self.m_honorBtn = self:getChild("honorBtn")
	self.m_recruitBg = self:getChild("recruitBg")
	self.m_recruitText = self:getChild("recruitText")
	self.m_recruitBtn = self:getChild("recruitBtn")
	self.m_bagBg = self:getChild("bagBg")
	self.m_bagText = self:getChild("bagText")
	self.m_bagBtn = self:getChild("bagBtn")
	self.m_quickSelBg = self:getChild("quickSelBg")
	self.m_quickSelText = self:getChild("quickSelText")
	self.m_quickSelBtn = self:getChild("quickSelBtn")
	self.m_quick = self:getChild("quick")
	self.m_activateBtn = self:getChild("activateBtn")
	self.m_recycleBtn = self:getChild("recycleBtn")
	self.m_touchComp = self:getChild("touchComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_selectComp = self:getChild("selectComp")
	self.m_panelInTransition = self:getTransition("panelIn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
