local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lzqgm2v"

function var_0_0:__ctor()
	self.m_isBuffShopController = self:getController("isBuffShop")
	self.m_closePnl = self:getChild("closePnl")
	self.m_resComp = self:getChild("resComp")
	self.m_eff = self:getChild("eff")
	self.m_title = self:getChild("title")
	self.m_costComp = self:getChild("costComp")
	self.m_freshBtn = self:getChild("freshBtn")
	self.m_shopList = self:getChild("shopList")
	self.m_buffList = self:getChild("buffList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsBuffShopCtrl = {
	buff = 1,
	knight = 0
}

return var_0_0
