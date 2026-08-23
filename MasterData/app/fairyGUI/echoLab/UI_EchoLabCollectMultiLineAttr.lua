local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3y"

function var_0_0:__ctor()
	self.m_showIconController = self:getController("showIcon")
	self.m_titleText1 = self:getChild("titleText1")
	self.m_valueText1 = self:getChild("valueText1")
	self.m_titleText2 = self:getChild("titleText2")
	self.m_valueText2 = self:getChild("valueText2")
	self.m_icon = self:getChild("icon")
end

var_0_0.ShowIconCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
