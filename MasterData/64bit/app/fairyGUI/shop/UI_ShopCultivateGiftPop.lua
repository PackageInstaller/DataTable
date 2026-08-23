local var_0_0 = {}

var_0_0.URL = "ui://454a48jpcd4u14bnngz"

function var_0_0:__ctor()
	self.m_isWitchController = self:getController("isWitch")
	self.m_closePnl = self:getChild("closePnl")
	self.m_title = self:getChild("title")
	self.m_witchBgLoader = self:getChild("witchBgLoader")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_witch = self:getChild("witch")
	self.m_giftList = self:getChild("giftList")
	self.m_closeBtn = self:getChild("closeBtn")
end

var_0_0.IsWitchCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
