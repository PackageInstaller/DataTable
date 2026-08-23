local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5lrhf7bo"

function var_0_0:__ctor()
	self.m_isShowProductController = self:getController("isShowProduct")
	self.m_bgEffNode = self:getChild("bgEffNode")
	self.m_productEffNode = self:getChild("productEffNode")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_infoComp = self:getChild("infoComp")
	self.m_knightList = self:getChild("knightList")
	self.m_dailyBtn = self:getChild("dailyBtn")
	self.m_costItemList = self:getChild("costItemList")
	self.m_frontBgLoader = self:getChild("frontBgLoader")
	self.m_consumptionItemList = self:getChild("consumptionItemList")
	self.m_tipsComp = self:getChild("tipsComp")
	self.m_productTipComp = self:getChild("productTipComp")
	self.m_productHoldNode = self:getChild("productHoldNode")
	self.m_effectIcon1 = self:getChild("effectIcon1")
	self.m_effectIcon2 = self:getChild("effectIcon2")
	self.m_effectIcon3 = self:getChild("effectIcon3")
	self.m_iconEffHolder = self:getChild("iconEffHolder")
	self.m_guideHelper = self:getChild("guideHelper")
	self.m_enterTransition = self:getTransition("enter")
	self.m_coinGetTransition = self:getTransition("coinGet")
end

return var_0_0
