local var_0_0 = {}

var_0_0.URL = "ui://co68dz79kiwnf"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isSexyController = self:getController("isSexy")
	self.m_enterEffDown = self:getChild("enterEffDown")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_rewardList = self:getChild("rewardList")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_descTxt = self:getChild("descTxt")
	self.m_limitBuyTxt = self:getChild("limitBuyTxt")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_discount = self:getChild("discount")
	self.m_enterEffUp = self:getChild("enterEffUp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
