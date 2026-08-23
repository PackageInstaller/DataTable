local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm3n"

function var_0_0:__ctor()
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_isLockController = self:getController("isLock")
	self.m_isSelectedController = self:getController("isSelected")
	self.m_txtSizeIcon = self:getChild("txtSizeIcon")
	self.m_maxIcon = self:getChild("maxIcon")
	self.m_desTxtAuto = self:getChild("desTxtAuto")
	self.m_desTxtShort = self:getChild("desTxtShort")
	self.m_numTxt = self:getChild("numTxt")
end

var_0_0.IsShowBgCtrl = {
	show = 1,
	hide = 0
}
var_0_0.IsLockCtrl = {
	normal = 0,
	lock = 1
}
var_0_0.IsSelectedCtrl = {
	normal = 0,
	selected = 1
}

return var_0_0
