local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8dtxkhlgic4k"

function var_0_0:__ctor()
	self.m_showUpDetailController = self:getController("showUpDetail")
	self.m_openWishController = self:getController("openWish")
	self.m_bgGLoader = self:getChild("bgGLoader")
	self.m_leftBg = self:getChild("leftBg")
	self.m_knightBtn1 = self:getChild("knightBtn1")
	self.m_knightBtn2 = self:getChild("knightBtn2")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_countDownTxt = self:getChild("countDownTxt")
	self.m_countDown = self:getChild("countDown")
	self.m_wishComp = self:getChild("wishComp")
	self.m_minimumText = self:getChild("minimumText")
	self.m_groupClickComp = self:getChild("groupClickComp")
	self.m_detailGroupComp = self:getChild("detailGroupComp")
	self.m_arrowNode = self:getChild("arrowNode")
	self.m_upGroupBtn = self:getChild("upGroupBtn")
	self.m_bigTitle = self:getChild("bigTitle")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.ShowUpDetailCtrl = {
	hide = 0,
	show = 1
}
var_0_0.OpenWishCtrl = {
	open = 1,
	lock = 0
}

return var_0_0
