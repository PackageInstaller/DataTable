local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm2x"

function var_0_0:__ctor()
	self.m_isAddItemController = self:getController("isAddItem")
	self.m_isRewardController = self:getController("isReward")
	self.m_isFreeController = self:getController("isFree")
	self.m_titleEff = self:getChild("titleEff")
	self.m_addItemList = self:getChild("addItemList")
	self.m_curTimetext = self:getChild("curTimetext")
	self.m_totalTimeText = self:getChild("totalTimeText")
	self.m_itemList = self:getChild("itemList")
	self.m_resComp = self:getChild("resComp")
	self.m_quickAwardBtn = self:getChild("quickAwardBtn")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_lastCount = self:getChild("lastCount")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
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
	page2 = 2,
	page1 = 1
}

return var_0_0
