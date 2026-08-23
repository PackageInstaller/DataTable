local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktnonnfrel"

function var_0_0:__ctor()
	self.m_isLineUpController = self:getController("isLineUp")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_skillIconComp = self:getChild("skillIconComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_detailComp = self:getChild("detailComp")
	self.m_buffDescLabel = self:getChild("buffDescLabel")
	self.m_content = self:getChild("content")
end

return var_0_0
