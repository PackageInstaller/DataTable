local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3x"

function var_0_0:__ctor()
	self.m_hideTitleController = self:getController("hideTitle")
	self.m_titleDes = self:getChild("titleDes")
	self.m_attrList = self:getChild("attrList")
end

var_0_0.HideTitleCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
