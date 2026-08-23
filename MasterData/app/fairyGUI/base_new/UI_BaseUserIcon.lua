local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepr7qviboo"

function var_0_0:__ctor()
	self.m_isNameShowController = self:getController("isNameShow")
	self.m_isLevelShowController = self:getController("isLevelShow")
	self.m_emptyController = self:getController("empty")
	self.m_hideBgController = self:getController("hideBg")
	self.m_hideFrameController = self:getController("hideFrame")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_avataEffNode = self:getChild("avataEffNode")
	self.m_frameLoader = self:getChild("frameLoader")
	self.m_effHolder = self:getChild("effHolder")
	self.m_nameText = self:getChild("nameText")
	self.m_levelText = self:getChild("levelText")
end

var_0_0.IsNameShowCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsLevelShowCtrl = {
	hide = 0,
	show = 1
}
var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HideBgCtrl = {
	hide = 1,
	show = 0
}
var_0_0.HideFrameCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
