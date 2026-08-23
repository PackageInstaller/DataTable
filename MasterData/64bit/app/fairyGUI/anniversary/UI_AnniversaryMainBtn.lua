local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqt2wej"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_descBg = self:getChild("descBg")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
