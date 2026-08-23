local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wf97s1z"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_isBuyController = self:getController("isBuy")
	self.m_hasWeekCardController = self:getController("hasWeekCard")
	self.m_giftIcon = self:getChild("giftIcon")
	self.m_giftName = self:getChild("giftName")
	self.m_giftNum = self:getChild("giftNum")
	self.m_giftFreeTxt = self:getChild("giftFreeTxt")
	self.m_giftWeekCardTxt = self:getChild("giftWeekCardTxt")
	self.m_priceSign = self:getChild("priceSign")
	self.m_giftPrice = self:getChild("giftPrice")
	self.m_viewTouch = self:getChild("viewTouch")
	self.m_buyTouch = self:getChild("buyTouch")
	self.m_discountTxt = self:getChild("discountTxt")
	self.m_offTxt = self:getChild("offTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsFreeCtrl = {
	是 = 0,
	否 = 1
}
var_0_0.IsBuyCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.HasWeekCardCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
