local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wmuduby"

function var_0_0:__ctor()
	self.m_isFirstController = self:getController("isFirst")
	self.m_isAdditionalController = self:getController("isAdditional")
	self.m_isGiftController = self:getController("isGift")
	self.m_item = self:getChild("item")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_resComp = self:getChild("resComp")
	self.m_resIcon2 = self:getChild("resIcon2")
	self.m_resNum2 = self:getChild("resNum2")
	self.m_resIcon3 = self:getChild("resIcon3")
	self.m_resNum3 = self:getChild("resNum3")
end

var_0_0.IsFirstCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsAdditionalCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsGiftCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
