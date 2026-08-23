local var_0_0 = {}

var_0_0.URL = "ui://sap1qckt10cbfrdx"

function var_0_0:__ctor()
	self.m_showBtnController = self:getController("showBtn")
	self.m_redLine = self:getChild("redLine")
	self.m_infoBtn = self:getChild("infoBtn")
end

return var_0_0
