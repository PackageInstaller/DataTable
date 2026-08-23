local var_0_0 = {}

var_0_0.URL = "ui://foyq921sz0z97"

function var_0_0:__ctor()
	self.m_isAddItemController = self:getController("isAddItem")
	self.m_isRewardController = self:getController("isReward")
	self.m_isFreeController = self:getController("isFree")
	self.m_huawenLoader = self:getChild("huawenLoader")
	self.m_addItemList = self:getChild("addItemList")
	self.m_topBar = self:getChild("topBar")
	self.m_curTime = self:getChild("curTime")
	self.m_TotalTime = self:getChild("TotalTime")
	self.m_itemList = self:getChild("itemList")
	self.m_resComp = self:getChild("resComp")
	self.m_getAward = self:getChild("getAward")
	self.m_accelerateBtn = self:getChild("accelerateBtn")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_lastCount = self:getChild("lastCount")
	self.m_tipTxt = self:getChild("tipTxt")
end

var_0_0.IsAddItemCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsRewardCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsFreeCtrl = {
	page0 = 0,
	page2 = 4,
	page1 = 1
}

return var_0_0
