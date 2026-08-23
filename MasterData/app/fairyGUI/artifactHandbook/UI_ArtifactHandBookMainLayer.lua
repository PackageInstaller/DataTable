local var_0_0 = {}

var_0_0.URL = "ui://fl8ril81rz3q0"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_qualityController = self:getController("quality")
	self.m_oneKeyController = self:getController("oneKey")
	self.m_belongdownLoader = self:getChild("belongdownLoader")
	self.m_knightBelongComp = self:getChild("knightBelongComp")
	self.m_belongupLoader = self:getChild("belongupLoader")
	self.m_groupList = self:getChild("groupList")
	self.m_tab1 = self:getChild("tab1")
	self.m_tab2 = self:getChild("tab2")
	self.m_tab3 = self:getChild("tab3")
	self.m_tab4 = self:getChild("tab4")
	self.m_selectBtn = self:getChild("selectBtn")
	self.m_processBg = self:getChild("processBg")
	self.m_curNumTxt = self:getChild("curNumTxt")
	self.m_allCountTxt = self:getChild("allCountTxt")
	self.m_touchPnl = self:getChild("touchPnl")
	self.m_bookList = self:getChild("bookList")
	self.m_progressComp = self:getChild("progressComp")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_oneKeyCostBg = self:getChild("oneKeyCostBg")
	self.m_oneKeyCostComp = self:getChild("oneKeyCostComp")
	self.m_oneKeyGroup = self:getChild("oneKeyGroup")
	self.m_selectComp = self:getChild("selectComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_changeComp = self:getChild("changeComp")
	self.m_changeComp2 = self:getChild("changeComp2")
	self.m_pnlEnterTransition = self:getTransition("pnlEnter")
	self.m_enterTransition = self:getTransition("enter")
	self.m_listTransition = self:getTransition("list")
	self.m_switch0Transition = self:getTransition("switch0")
	self.m_switch1Transition = self:getTransition("switch1")
end

return var_0_0
