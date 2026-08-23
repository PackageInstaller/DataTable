local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd1u"

function var_0_0:__ctor()
	self.m_showDefaultController = self:getController("showDefault")
	self.m_hideBgController = self:getController("hideBg")
	self.m_rightIconLoader = self:getChild("rightIconLoader")
	self.m_leftIconLoader = self:getChild("leftIconLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_effectNode = self:getChild("effectNode")
end

var_0_0.ShowDefaultCtrl = {
	hide = 1,
	show = 0
}
var_0_0.HideBgCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
