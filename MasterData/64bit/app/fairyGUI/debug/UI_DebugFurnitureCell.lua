local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yhff95ibi2"

function var_0_0:__ctor()
	self.m_isSpineController = self:getController("isSpine")
	self.m_actionShowController = self:getController("actionShow")
	self.m_furnitureLoader = self:getChild("furnitureLoader")
	self.m_furnitureComp = self:getChild("furnitureComp")
	self.m_spineFurnitureBorder = self:getChild("spineFurnitureBorder")
	self.m_furnitureGroup = self:getChild("furnitureGroup")
	self.m_knightHolderComp = self:getChild("knightHolderComp")
end

var_0_0.IsSpineCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ActionShowCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
