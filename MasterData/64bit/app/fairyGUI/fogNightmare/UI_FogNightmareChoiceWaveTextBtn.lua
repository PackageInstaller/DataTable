local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oqxburrmr"

function var_0_0:__ctor()
	self.m_showMaskController = self:getController("showMask")
	self.m_errorTipNode = self:getChild("errorTipNode")
end

var_0_0.ShowMaskCtrl = {
	show = 1,
	hide = 0
}

return var_0_0
