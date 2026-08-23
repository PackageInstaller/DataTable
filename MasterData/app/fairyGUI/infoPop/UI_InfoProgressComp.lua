local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnp0x6gibxd"

function var_0_0:__ctor()
	self.m_isEnoughController = self:getController("isEnough")
	self.m_quliatyIcon = self:getChild("quliatyIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_nameType = self:getChild("nameType")
	self.m_infoNameGroup = self:getChild("infoNameGroup")
	self.m_icon = self:getChild("icon")
	self.m_curNumText = self:getChild("curNumText")
	self.m_fullNumText = self:getChild("fullNumText")
	self.m_progress = self:getChild("progress")
	self.m_getBtn = self:getChild("getBtn")
	self.m_progressGroup = self:getChild("progressGroup")
end

var_0_0.IsEnoughCtrl = {
	是 = 0,
	否 = 1
}

return var_0_0
