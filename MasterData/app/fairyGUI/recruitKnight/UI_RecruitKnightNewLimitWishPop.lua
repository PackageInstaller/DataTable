local var_0_0 = {}

var_0_0.URL = "ui://c64rm38yqydu12uytp8"

function var_0_0:__ctor()
	self.m_wishState1Controller = self:getController("wishState1")
	self.m_wishState2Controller = self:getController("wishState2")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_percentComp = self:getChild("percentComp")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_title = self:getChild("title")
	self.m_memberComp1 = self:getChild("memberComp1")
	self.m_wishList = self:getChild("wishList")
	self.m_tabList = self:getChild("tabList")
	self.m_mask = self:getChild("mask")
	self.m_tipText = self:getChild("tipText")
	self.m_light = self:getChild("light")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.WishState1Ctrl = {
	wish = 1,
	done = 3,
	none = 0
}
var_0_0.WishState2Ctrl = {
	wish = 1,
	done = 5,
	none = 0
}
var_0_0.IsEmptyCtrl = {
	empty = 1,
	normal = 0
}

return var_0_0
