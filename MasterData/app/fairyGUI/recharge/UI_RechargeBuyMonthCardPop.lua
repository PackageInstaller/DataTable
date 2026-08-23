local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wkrlh6z"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_popPanel = self:getChild("popPanel")
	self.m_cardNameText = self:getChild("cardNameText")
	self.m_monthCardPic = self:getChild("monthCardPic")
	self.m_priceUnitText = self:getChild("priceUnitText")
	self.m_priceText = self:getChild("priceText")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_buyDesc = self:getChild("buyDesc")
	self.m_dailyDesc = self:getChild("dailyDesc")
	self.m_content = self:getChild("content")
end

var_0_0.TypeCtrl = {
	高级 = 1,
	基础 = 0
}

return var_0_0
