local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1jr2h3b"

function var_0_0:__ctor()
	self.m_hideDetailController = self:getController("hideDetail")
	self.m_levelComp = self:getChild("levelComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_expTxt = self:getChild("expTxt")
	self.m_probar = self:getChild("probar")
end

return var_0_0
