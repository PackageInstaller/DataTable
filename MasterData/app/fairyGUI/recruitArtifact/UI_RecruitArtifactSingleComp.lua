local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8dq71dlgic8c"

function var_0_0:__ctor()
	self.m_showUpDetailController = self:getController("showUpDetail")
	self.m_openWishController = self:getController("openWish")
	self.m_leftLoader = self:getChild("leftLoader")
	self.m_txtLoader1 = self:getChild("txtLoader1")
	self.m_rightLoader = self:getChild("rightLoader")
	self.m_txtLoader2 = self:getChild("txtLoader2")
	self.m_knightBtn1 = self:getChild("knightBtn1")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_wishComp = self:getChild("wishComp")
	self.m_minimumText = self:getChild("minimumText")
	self.m_groupClickComp = self:getChild("groupClickComp")
	self.m_detailGroupComp = self:getChild("detailGroupComp")
	self.m_upGroupBtn = self:getChild("upGroupBtn")
	self.m_arrowNode = self:getChild("arrowNode")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.ShowUpDetailCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.OpenWishCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
