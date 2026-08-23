local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd1e"

function var_0_0:__ctor()
	self.m_isTenController = self:getController("isTen")
	self.m_canGetPrimaryController = self:getController("canGetPrimary")
	self.m_isHideBtnGroupController = self:getController("isHideBtnGroup")
	self.m_startNode = self:getChild("startNode")
	self.m_endNode = self:getChild("endNode")
	self.m_itemNode1 = self:getChild("itemNode1")
	self.m_itemNode2 = self:getChild("itemNode2")
	self.m_itemNode3 = self:getChild("itemNode3")
	self.m_itemNode4 = self:getChild("itemNode4")
	self.m_itemNode6 = self:getChild("itemNode6")
	self.m_itemNode5 = self:getChild("itemNode5")
	self.m_itemNode7 = self:getChild("itemNode7")
	self.m_itemNode8 = self:getChild("itemNode8")
	self.m_itemNode9 = self:getChild("itemNode9")
	self.m_itemNode10 = self:getChild("itemNode10")
	self.m_itemNode0 = self:getChild("itemNode0")
	self.m_shareComp = self:getChild("shareComp")
	self.m_tipText = self:getChild("tipText")
	self.m_returnBtn = self:getChild("returnBtn")
	self.m_title = self:getChild("title")
	self.m_reciveBtn = self:getChild("reciveBtn")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costNumText = self:getChild("costNumText")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_continueBtn = self:getChild("continueBtn")
	self.m_continueText = self:getChild("continueText")
	self.m_showBtnBoxTransition = self:getTransition("showBtnBox")
	self.m_hideBtnBoxTransition = self:getTransition("hideBtnBox")
	self.m_multRewardShow1Transition = self:getTransition("multRewardShow1")
	self.m_backTransition = self:getTransition("back")
	self.m_multRewardShow0Transition = self:getTransition("multRewardShow0")
end

var_0_0.IsTenCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanGetPrimaryCtrl = {
	canGet = 1,
	normal = 0
}
var_0_0.IsHideBtnGroupCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
