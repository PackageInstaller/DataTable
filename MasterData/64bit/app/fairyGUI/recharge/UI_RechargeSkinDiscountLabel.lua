local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wj0dsbs"

function var_0_0:__ctor()
	self.m_isDiamondController = self:getController("isDiamond")
	self.m_preTitle = self:getChild("preTitle")
	self.m_delLine = self:getChild("delLine")
end

var_0_0.IsDiamondCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
