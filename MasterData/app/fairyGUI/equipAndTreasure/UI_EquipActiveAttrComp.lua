local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7pf2e81"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_activeNumTxt = self:getChild("activeNumTxt")
	self.m_attrNameTxt1 = self:getChild("attrNameTxt1")
	self.m_attrValueTxt1 = self:getChild("attrValueTxt1")
	self.m_attrNameTxt2 = self:getChild("attrNameTxt2")
	self.m_attrValueTxt2 = self:getChild("attrValueTxt2")
end

var_0_0.IsActiveCtrl = {
	未激活 = 0,
	激活 = 1
}

return var_0_0
