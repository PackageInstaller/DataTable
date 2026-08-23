local var_0_0 = {}

var_0_0.URL = "ui://dy04zo9niea80"

function var_0_0:__ctor()
	self.m_itemTypeController = self:getController("itemType")
	self.m_isBuyController = self:getController("isBuy")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_bgEffectComp = self:getChild("bgEffectComp")
	self.m_returnIconLoader = self:getChild("returnIconLoader")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_txtLoader = self:getChild("txtLoader")
	self.m_ratioTxt = self:getChild("ratioTxt")
	self.m_rareAwardLeftLine = self:getChild("rareAwardLeftLine")
	self.m_rareAwardRightLine = self:getChild("rareAwardRightLine")
	self.m_rareAwardList = self:getChild("rareAwardList")
	self.m_awardTxtIcon = self:getChild("awardTxtIcon")
	self.m_allAwardList = self:getChild("allAwardList")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_btnEffectComp = self:getChild("btnEffectComp")
end

return var_0_0
