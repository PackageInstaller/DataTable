local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7qaksa6"

function var_0_0:__ctor()
	self.m_colorCtrlController = self:getController("colorCtrl")
	self.m_skillProcessTxt = self:getChild("skillProcessTxt")
	self.m_skillNameTxt = self:getChild("skillNameTxt")
	self.m_descTxt = self:getChild("descTxt")
end

var_0_0.ColorCtrlCtrl = {
	["3件激活"] = 3,
	["2件激活"] = 2,
	["1件激活"] = 1,
	都没激活 = 0
}

return var_0_0
