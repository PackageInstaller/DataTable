local var_0_0 = {}

var_0_0.URL = "ui://kvb3znephjpc1emigav"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_gainBarImg = self:getChild("gainBarImg")
	self.m_campLoader = self:getChild("campLoader")
	self.m_effDadComp = self:getChild("effDadComp")
end

var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
