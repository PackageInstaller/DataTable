local var_0_0 = {}

var_0_0.URL = "ui://2r646mayq5bh3f"

function var_0_0:__ctor()
	self.m_isOpenController = self:getController("isOpen")
	self.m_hideStateController = self:getController("hideState")
	self.m_stateText = self:getChild("stateText")
	self.m_settingBtn = self:getChild("settingBtn")
	self.m_tipText = self:getChild("tipText")
end

var_0_0.IsOpenCtrl = {
	close = 0,
	open = 1
}
var_0_0.HideStateCtrl = {
	open = 0,
	hide = 1
}

return var_0_0
