local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5kq1l7f2"

function var_0_0:__ctor()
	self.m_isUpController = self:getController("isUp")
	self.m_canWearController = self:getController("canWear")
	self.m_equipIcon = self:getChild("equipIcon")
	self.m_attrNameTxt = self:getChild("attrNameTxt")
	self.m_attrValueTxt = self:getChild("attrValueTxt")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costValueTxt = self:getChild("costValueTxt")
	self.m_changeBtn = self:getChild("changeBtn")
	self.m_nameTxt = self:getChild("nameTxt")
end

return var_0_0
