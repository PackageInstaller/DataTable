local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jdif969l5"

function var_0_0:__ctor()
	self.m_choseIndexController = self:getController("choseIndex")
	self.m_mask = self:getChild("mask")
	self.m_card1 = self:getChild("card1")
	self.m_card2 = self:getChild("card2")
	self.m_card3 = self:getChild("card3")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ChoseIndexCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
