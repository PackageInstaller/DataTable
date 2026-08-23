local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7f5qc9z"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_activeNumTxt = self:getChild("activeNumTxt")
	self.m_attrNameTxt = self:getChild("attrNameTxt")
	self.m_attrValueTxt = self:getChild("attrValueTxt")
end

var_0_0.IsActiveCtrl = {
	未激活 = 0,
	激活 = 1
}

return var_0_0
