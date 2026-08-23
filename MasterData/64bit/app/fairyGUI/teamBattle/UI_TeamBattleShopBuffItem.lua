local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8luss5f5"

function var_0_0:__ctor()
	self.m_isBuyController = self:getController("isBuy")
	self.m_buffCard = self:getChild("buffCard")
	self.m_costComp = self:getChild("costComp")
end

var_0_0.IsBuyCtrl = {
	normal = 0,
	buy = 1
}

return var_0_0
