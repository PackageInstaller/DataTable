local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wgech2t"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_typeController = self:getController("type")
	self.m_stageController = self:getController("stage")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_rewardLoader = self:getChild("rewardLoader")
	self.m_dengji = self:getChild("dengji")
	self.m_zhuxianRewardLoader = self:getChild("zhuxianRewardLoader")
	self.m_zhuxian = self:getChild("zhuxian")
	self.m_heiyuan = self:getChild("heiyuan")
	self.m_mijing = self:getChild("mijing")
	self.m_allBuyAwardBtn = self:getChild("allBuyAwardBtn")
	self.m_allBuyNum = self:getChild("allBuyNum")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_welfareGroup = self:getChild("welfareGroup")
	self.m_descTxt = self:getChild("descTxt")
	self.m_rechargeBtn = self:getChild("rechargeBtn")
	self.m_priceTxt = self:getChild("priceTxt")
	self.m_buyedTxt = self:getChild("buyedTxt")
	self.m_bugBtnGroup = self:getChild("bugBtnGroup")
	self.m_oneKeyLBtn = self:getChild("oneKeyLBtn")
	self.m_allRewardTxt = self:getChild("allRewardTxt")
	self.m_oneKeyBtnGroup = self:getChild("oneKeyBtnGroup")
	self.m_buySBtn = self:getChild("buySBtn")
	self.m_price2Txt = self:getChild("price2Txt")
	self.m_oneKeySBtn = self:getChild("oneKeySBtn")
	self.m_oneKey2Txt = self:getChild("oneKey2Txt")
	self.m_BtnGroup = self:getChild("BtnGroup")
	self.m_awardList = self:getChild("awardList")
	self.m_stageList = self:getChild("stageList")
	self.m_rightGroup = self:getChild("rightGroup")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}
var_0_0.TypeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page4 = 4,
	page3 = 3
}
var_0_0.StageCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page4 = 4,
	page3 = 3
}

return var_0_0
