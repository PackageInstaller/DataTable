local var_0_0 = {}

var_0_0.URL = "ui://ami25kgymo4c0"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isShowCostController = self:getController("isShowCost")
	self.m_petPicComp = self:getChild("petPicComp")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_topBar = self:getChild("topBar")
	self.m_knightList = self:getChild("knightList")
	self.m_equipList = self:getChild("equipList")
	self.m_petList = self:getChild("petList")
	self.m_uniteTokenList = self:getChild("uniteTokenList")
	self.m_tabList = self:getChild("tabList")
	self.m_artifactList = self:getChild("artifactList")
	self.m_furnitureList = self:getChild("furnitureList")
	self.m_ableFragmentList = self:getChild("ableFragmentList")
	self.m_rebornBtn = self:getChild("rebornBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_costComp = self:getChild("costComp")
	self.m_rebornBtn1 = self:getChild("rebornBtn1")
	self.m_resComp1 = self:getChild("resComp1")
	self.m_costComp1 = self:getChild("costComp1")
	self.m_selectAllBtn = self:getChild("selectAllBtn")
	self.m_qualityFilterComp = self:getChild("qualityFilterComp")
	self.m_decorativePointLoader = self:getChild("decorativePointLoader")
	self.m_decorativePointTxt = self:getChild("decorativePointTxt")
	self.m_furnitureSellBtn = self:getChild("furnitureSellBtn")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page5 = 6,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page6 = 7,
	page3 = 3,
	page7 = 8
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowCostCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
