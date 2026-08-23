local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulkvyy38"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_activeController = self:getController("active")
	self.m_indexController = self:getController("index")
	self.m_inSelectController = self:getController("inSelect")
	self.m_isBigPointController = self:getController("isBigPoint")
	self.m_typeBg = self:getChild("typeBg")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_lineLoader = self:getChild("lineLoader")
	self.m_eff = self:getChild("eff")
end

return var_0_0
