local var_0_0 = {}

var_0_0.URL = "ui://gc6wunfkh36u22"

function var_0_0:__ctor()
	self.m_closePnl = self:getChild("closePnl")
	self.m_discountTxt = self:getChild("discountTxt")
	self.m_headIconComp = self:getChild("headIconComp")
	self.m_knightName = self:getChild("knightName")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_itemTitleTxt = self:getChild("itemTitleTxt")
	self.m_itemList = self:getChild("itemList")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
