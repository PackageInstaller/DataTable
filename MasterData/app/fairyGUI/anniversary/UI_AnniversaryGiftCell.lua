local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqmi252x"

function var_0_0:__ctor()
	self.m_isLimitController = self:getController("isLimit")
	self.m_isUnBuyController = self:getController("isUnBuy")
	self.m_isFreeController = self:getController("isFree")
	self.m_isDiscountController = self:getController("isDiscount")
	self.m_IsTimeLimitController = self:getController("IsTimeLimit")
	self.m_showRechargeTypeController = self:getController("showRechargeType")
	self.m_bg = self:getChild("bg")
	self.m_timeLimitTxt = self:getChild("timeLimitTxt")
	self.m_timeGroup = self:getChild("timeGroup")
	self.m_item = self:getChild("item")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_priceComp = self:getChild("priceComp")
	self.m_priceCompMoney = self:getChild("priceCompMoney")
	self.m_zhezhao = self:getChild("zhezhao")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_levelText = self:getChild("levelText")
	self.m_discountTitle = self:getChild("discountTitle")
	self.m_popBtn = self:getChild("popBtn")
	self.m_awardBtn = self:getChild("awardBtn")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
